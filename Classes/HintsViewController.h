//
//  HintsViewController.h
//  CJLookUp
//
//  Created by Kenneth Anguish on 7/2/10.
//  Copyright 2010 Kenneth Anguish. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HintsViewController : TTViewController <UIWebViewDelegate> {
	UIWebView *webView;
}
@property (nonatomic, retain) UIWebView *webView;

@end
