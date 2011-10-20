//
//  CJLookUpAppDelegate.h
//  CJLookUp
//
//  Created by Kenneth Anguish on 4/5/10.
//  Copyright Kenneth Anguish 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJLookUpAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	NSString *deviceToken;
}

@property (nonatomic, retain) NSString *deviceToken;

@property (nonatomic, retain) IBOutlet UIWindow *window;
- (NSString *)currentDeviceToken;

@end

