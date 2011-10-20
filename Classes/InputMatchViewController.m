    //
//  InputMatchViewController.m
//  CJLookup
//
//  Created by Kenneth Anguish on 4/5/10.
//  Copyright 2010 Kenneth Anguish. All rights reserved.
//

/* http://github.com/lukhnos/openvanilla-oranje/tree/master/DataTables/ */

#import "InputMatchViewController.h"
#import "FMResultSet.h"
#import "FMDatabase.h"

@implementation InputMatchViewController
@synthesize theTableView, theSearchBar, filteredListData, cjLookUp, previousSearchQuery;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"CJ Lookup 倉頡找字快";
		self.title = @"找字快";
		self.navigationItem.title = @"CJ Lookup 倉頡找字快";
		
		UIImage* image = [UIImage imageNamed:@"icon-input.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];

    }
	
    return self;
}


- (void)viewDidLoad {
	self.navigationController.navigationBar.tintColor = RGBCOLOR(228, 43, 13);
	self.theSearchBar.tintColor = RGBCOLOR(228, 43, 13);
	
	self.filteredListData = [[NSMutableArray alloc] init];
	
	cjLookUp = [[NSDictionary alloc] initWithObjectsAndKeys:
					@"日", @"A", 
					@"月", @"B",
					@"金", @"C",
					@"木", @"D",
					@"水", @"E",
					@"火", @"F",
					@"土", @"G",
					@"竹", @"H",
					@"戈", @"I",
					@"十", @"J",
					@"大", @"K",
					@"中", @"L",
					@"一", @"M",
					@"弓", @"N",
					@"人", @"O",
					@"心", @"P",
					@"手", @"Q",
					@"口", @"R",
					@"尸", @"S",
					@"廿", @"T",
					@"山", @"U",
					@"女", @"V",
					@"田", @"W",
					@"難", @"X",
					@"卜", @"Y",
					@"重", @"Z",
				
					nil];
	
	theSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	theSearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	theSearchBar.delegate = self;
	
	theSearchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;  
	[theSearchBar sizeToFit];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view autoresizesSubviews];
	
	@try {
		if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"show_fleurhk_text"] isEqualToString: @"no"]) {

		} else {
			theSearchBar.text = @"花香港";
			[self matchInput: theSearchBar.text];
		}
	} @catch (NSException * e) {}
	
	/*
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	UIInterfaceOrientation orientation = [UIDevice currentDevice].orientation;

	if (orientation == UIInterfaceOrientationPortrait ) {
		NSLog(@"UIInterfaceOrientationPortrait");
	}
	
	if (orientation == UIInterfaceOrientationPortraitUpsideDown ) {
		NSLog(@"UIInterfaceOrientationPortraitUpsideDown");
	}

	
	if (orientation == UIInterfaceOrientationLandscapeLeft ) {
		NSLog(@"UIInterfaceOrientationLandscapeLeft");
	}

	
	if (orientation == UIInterfaceOrientationPortrait ) {
		NSLog(@"UIInterfaceOrientationLandscapeRight");
		[theSearchBar sizeToFit];
	}
	*/
	
	self.previousSearchQuery = @"";
}


#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.filteredListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault 
									   reuseIdentifier: SimpleTableIdentifier] autorelease];
		
		CGRect charLabelRect = CGRectMake( 10, 8, 35, 25);
		UILabel *charLabel = [[UILabel alloc] initWithFrame: charLabelRect];
		charLabel.textAlignment = UITextAlignmentLeft;
		charLabel.font = [UIFont boldSystemFontOfSize: 25];
		charLabel.tag = kCharLabelTag;
		charLabel.textColor = [UIColor blackColor];
		//charLabel.backgroundColor = [UIColor redColor];
		[cell.contentView addSubview: charLabel];
		[charLabel release];
		
		CGRect engLabelRect = CGRectMake( 55, 8, 125, 25);
		UILabel *engLabel = [[UILabel alloc] initWithFrame: engLabelRect];
		engLabel.textAlignment = UITextAlignmentLeft;
		engLabel.font = [UIFont boldSystemFontOfSize: 25];
		engLabel.tag = kEngLabelTag;
		engLabel.textColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
		//engLabel.backgroundColor = [UIColor blueColor];
		[cell.contentView addSubview: engLabel];
		[engLabel release];
		
		CGRect chiLabelRect = CGRectMake( 165, 8, 125, 25);
		UILabel *chiLabel = [[UILabel alloc] initWithFrame: chiLabelRect];
		chiLabel.textAlignment = UITextAlignmentLeft;
		chiLabel.font = [UIFont boldSystemFontOfSize: 25];
		chiLabel.tag = kChiLabelTag;
		chiLabel.textColor = [UIColor colorWithRed:0.108 green:0.755 blue:0.200 alpha:1.000];
		//chiLabel.backgroundColor = [UIColor orangeColor];
		[cell.contentView addSubview: chiLabel];
		[chiLabel release];
		
	}
	
	NSUInteger row = [indexPath row];
	
	UILabel *charLabel = (UILabel *)[cell.contentView viewWithTag: kCharLabelTag];
	charLabel.text = [NSString stringWithFormat: @"%@:", [[self.filteredListData objectAtIndex: row] objectForKey: @"char"]];
	
	UILabel *engLabel = (UILabel *)[cell.contentView viewWithTag: kEngLabelTag];
	engLabel.text = [[self.filteredListData objectAtIndex: row] objectForKey: @"sequences"];

	UILabel *chiLabel = (UILabel *)[cell.contentView viewWithTag: kChiLabelTag];

	NSString *chiSequences = @"";
	for (int i=0; i < [[[self.filteredListData objectAtIndex: row] objectForKey: @"sequences"] length]; i++) {
		NSString *current_char = [NSString stringWithFormat: @"%C", [[[self.filteredListData objectAtIndex: row] objectForKey: @"sequences"] characterAtIndex: i]];
		NSString *result_char = [cjLookUp objectForKey: current_char];
		
		chiSequences = [NSString stringWithFormat: @"%@%@", chiSequences, result_char ];
	}
	// NSLog(@"chiSequences: %@", chiSequences);
	
	chiLabel.text = chiSequences;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Search Bar

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	// searchBar.showsCancelButton = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	[self matchInput: searchBar.text ];
	// [self performSelectorInBackground:@selector(matchInput:) withObject: searchBar.text];

}

// called when Search (in our case "Done") button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
	
	[self matchInput: searchBar.text ];
}


- (void)matchInput:(NSString *)inputText {
	// NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	if ([inputText isEqualToString: @""]) {
		[self.filteredListData removeAllObjects];
		
		[theTableView reloadData];
		// [pool release];
		
		NSLog(@"Empty. skip");
		NSLog(@"-----");
	
		
		return;
	}
	// Check if input text is equal to previous text
	if ( [inputText isEqualToString: 	self.previousSearchQuery] ) {
		NSLog(@"Equal to string. skip");
		NSLog(@"-----");
		
		
		return;
	} else {
		self.previousSearchQuery = inputText;
	}
	
	
	NSString *sqlite_filepath = [[NSBundle mainBundle] pathForResource: @"cin_db" ofType:@"sqlite"];
	
	FMDatabase* sqlite_db = [FMDatabase databaseWithPath: sqlite_filepath];
	
	if (![sqlite_db open]) {
		NSLog(@"unable to open db");
	}
	
	NSMutableArray *matchingArray = [[NSMutableArray alloc] initWithCapacity: [inputText length]];
	NSMutableArray *matchingSequences = [[NSMutableArray alloc] initWithCapacity: [inputText length]];
	
	for (int i=0; i < [inputText length]; i++) {
		NSString *current_char = [NSString stringWithFormat: @"%C", [inputText characterAtIndex: i]];
		
		[matchingArray addObject: current_char];
	}
	
	// NSLog(@"matchingArray: %@", matchingArray );

	
	for (NSString *theChar in matchingArray) {
		NSString *query_string = [NSString stringWithFormat: @"select * from cjtable where glyph='%@'", theChar ];

		// NSLog(@"query string is: %@", query_string);
		
		FMResultSet *rs = [sqlite_db executeQuery: query_string];
		
		while ([rs next]) {
			NSString *sequences = [rs stringForColumn: @"sequences"];
			
			if ( !([sequences isEqualToString: @"a"] | [sequences isEqualToString: @"b"] | [sequences isEqualToString: @"c"] |
				[sequences isEqualToString: @"d"] | [sequences isEqualToString: @"e"] | [sequences isEqualToString: @"f"] |
				[sequences isEqualToString: @"g"] | [sequences isEqualToString: @"h"] | [sequences isEqualToString: @"i"] |
				[sequences isEqualToString: @"j"] | [sequences isEqualToString: @"k"] | [sequences isEqualToString: @"l"] |
				[sequences isEqualToString: @"m"] | [sequences isEqualToString: @"n"] | [sequences isEqualToString: @"o"] |
				[sequences isEqualToString: @"p"] | [sequences isEqualToString: @"q"] | [sequences isEqualToString: @"r"] |
				[sequences isEqualToString: @"s"] | [sequences isEqualToString: @"t"] | [sequences isEqualToString: @"u"] |
				[sequences isEqualToString: @"v"] | [sequences isEqualToString: @"w"] | [sequences isEqualToString: @"x"] |
				   [sequences isEqualToString: @"y"] | [sequences isEqualToString: @"z"])) {

				
				NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
									  sequences, @"sequences",
									  theChar, @"char", 
									  nil];
				
				[matchingSequences addObject: dict];
				[dict release];
			}
		}
	}
	[matchingArray release];
	
	// NSLog(@"matchingSequences:%@", matchingSequences);

	self.filteredListData = matchingSequences;
	
	[matchingSequences release];
	
	[theTableView reloadData];
	
	// [pool release];
}




#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	[filteredListData release];
	[cjLookUp release];
	
	[super dealloc];
}

@end
