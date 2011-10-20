#import "TabBarController.h"

@implementation TabBarController

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController



- (void)viewDidLoad {
	[self setTabURLs: [NSArray arrayWithObjects: 
					   @"tt://inputmatch", 
					   @"tt://hints",
					   @"tt://settings",
					   @"tt://help", 
						nil]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation { 
    return YES; // [self.selectedViewController 
				// shouldAutorotateToInterfaceOrientation:interfaceOrientation]; 
} 

@end
