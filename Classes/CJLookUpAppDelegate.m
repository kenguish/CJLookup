//
//  CJLookUpAppDelegate.m
//  CJLookUp
//
//  Created by Kenneth Anguish on 4/5/10.
//  Copyright Kenneth Anguish 2010. All rights reserved.
//

#import "TabBarController.h"
#import "CJLookUpAppDelegate.h"

#import "AboutTableViewController.h"
#import "InputMatchViewController.h"
#import "CJDefaultStyleSheet.h"
#import "HintsViewController.h"
#import "InAppSettings.h"
#import "Appirater.h"

@implementation CJLookUpAppDelegate

@synthesize window, deviceToken;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[TTStyleSheet setGlobalStyleSheet: [[CJDefaultStyleSheet alloc] init]];
	
	TTNavigator* navigator = [TTNavigator navigator];
	navigator.persistenceMode = TTNavigatorPersistenceModeNone;
	
	navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
	
	TTURLMap* map = navigator.URLMap;
	[map from: @"*" toViewController:[TTWebController class]];
	[map from: @"tt://tabBar" toSharedViewController:[TabBarController class]];
	[map from: @"tt://inputmatch" toViewController: [InputMatchViewController class]];
	[map from: @"tt://help" toViewController: [AboutTableViewController class]];
	[map from: @"tt://hints" toViewController: [HintsViewController class]];
	[map from: @"tt://settings" toSharedViewController:[InAppSettingsViewController class]];
	
	if (![navigator restoreViewControllers]) {
		TTURLAction *urlAction = [[[TTURLAction alloc] initWithURLPath:@"tt://tabBar"] autorelease];
		urlAction.animated = NO;
		[navigator openURLAction: urlAction];
	} else {
		TTURLAction *urlAction = [[[TTURLAction alloc] initWithURLPath:@"tt://inputmatch"] autorelease];
		urlAction.animated = NO;
		[navigator openURLAction: urlAction];
		
	}


	
	return YES;
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
	[[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
	return YES;
}


/****************************** PUSH NOTIFICATIONS ****************************************************************/
// Delegation methods
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	// NSLog(@"- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken called");
	
    //self.registered = YES;
	
	NSLog(@"The device UDID is: %@", [[UIDevice currentDevice] uniqueIdentifier]);
	NSLog(@"The device token is: %@", [devToken description]);
	
	const unsigned *tokenBytes = [devToken bytes];
	NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
						  ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
						  ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
						  ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
	/*
	 NSLog(@"The device token in hex is: %@", hexToken);
	 NSLog(@"Setting device token: deviceToken to something");
	 */
	
	self.deviceToken = hexToken;
	NSLog(@"Device token: %@", self.deviceToken);
	
	//[self sendProviderDeviceToken:devTokenBytes]; // custom method
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
	// NSLog(@"- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err  called");
	// 
    // NSLog(@"Error in registration. Error: %@", err);
}

- (NSString *)currentDeviceToken {
	// NSLog(@"DEBUG> currentDeviceToken is triggered");
	// NSLog(@"DEBUG> value is :%@", self.deviceToken);
	return self.deviceToken;
}




- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
