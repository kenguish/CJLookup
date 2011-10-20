#import "AboutTableViewController.h"

@implementation AboutTableViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil])) {
		self.title = @"更多";
		
		/*
         self.navigationItem.backBarButtonItem =
         [[[UIBarButtonItem alloc] initWithTitle: @"Help"
         style: UIBarButtonItemStyleBordered
         target: nil 
         action: nil] autorelease];
         */
		
		self.tableViewStyle = UITableViewStyleGrouped;
		
		UIImage* image = [UIImage imageNamed:@"icon-help.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
		
		// self.navigationBarTintColor = [UIColor colorWithRed:1.000 green:0.222 blue:0.309 alpha:1.000];
        
    }
	
    return self;
}

- (void)loadView {
	self.wantsFullScreenLayout = NO;
	
	[super loadView];
}

- (void)viewDidLoad {
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTModelViewController

- (void)createModel {
	self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
					   @"About",
					   [TTTableTextItem itemWithText:@"CJ Input 倉頡找字快" URL:@"http://iphone.fleur.hk/cjinput/"],
					   
					   @"iPhone developer",
					   [TTTableTextItem itemWithText:@"Fleur Hong Kong 花香港" URL:@"http://fleur.hk/"],
					   [TTTableTextItem itemWithText:@"Fleur Hong Kong iPhone" URL:@"http://iphone.fleur.hk/"],
					   [TTTableTextItem itemWithText:@"DB Timetable 愉景灣車船時間表" URL:@"http://itunes.apple.com/us/app/id345351667?mt=8"],
					   
					   @"General info 倉頡輸入法",
					   [TTTableTextItem itemWithText:@"Cangjie Input Method" URL:@"http://en.wikipedia.org/wiki/Cangjie_method"],
					   [TTTableTextItem itemWithText:@"Chinese Character Database" URL:@"http://humanum.arts.cuhk.edu.hk/Lexis/lexi-can/"],
					   [TTTableTextItem itemWithText:@"Friend of the Cangjie" URL:@"http://www.chinesecj.com/forum/"],

					   @"Useful info on Chinese Input",
					   [TTTableTextItem itemWithText:@"Laboratory of Chu Bong-Foo" URL:@"http://www.cbflabs.com/"],
					   [TTTableTextItem itemWithText:@"OpenVanilla" URL:@"http://en.wikipedia.org/wiki/OpenVanilla"],
					   [TTTableTextItem itemWithText:@"Chinese Mac at Yale" URL:@"http://www.yale.edu/chinesemac/"], nil];
						
}

@end
