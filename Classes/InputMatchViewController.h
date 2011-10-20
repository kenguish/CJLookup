//
//  InputMatchViewController.h
//  CJLookup
//
//  Created by Kenneth Anguish on 4/5/10.
//  Copyright 2010 Kenneth Anguish. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

#import "FMDatabase.h"

#define kCharLabelTag 1
#define kEngLabelTag 2
#define kChiLabelTag 3

@interface InputMatchViewController : UIViewController <UISearchBarDelegate> {
	IBOutlet UITableView *theTableView;
	IBOutlet UISearchBar *theSearchBar;
	
	
	NSMutableArray *filteredListData;		// the filtered content as a result of the search
	
	NSDictionary *cjLookUp;
	
	NSString *previousSearchQuery;

}

@property (nonatomic, retain) IBOutlet UITableView *theTableView;
@property (nonatomic, retain) IBOutlet UISearchBar *theSearchBar;

@property (nonatomic, retain) NSDictionary *cjLookUp;
@property (nonatomic, retain) NSMutableArray *filteredListData;

@property (nonatomic, retain) NSString *previousSearchQuery;

- (void)matchInput:(NSString *)inputText;

@end

