//
//  HintsViewController.m
//  CJLookUp
//
//  Created by Kenneth Anguish on 7/2/10.
//  Copyright 2010 Kenneth Anguish. All rights reserved.
//

#import "HintsViewController.h"

@implementation HintsViewController
@synthesize webView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil])) {
		self.title = @"常用提示";
		
		UIImage* image = [UIImage imageNamed:@"icon-hint.png"];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
        
    }
	
    return self;
}

- (void)viewDidLoad {
	CGRect rectsize;
	@try {
		if ([[UIDevice currentDevice].model isEqualToString: @"iPad"] ) {
			self.view.backgroundColor = RGBCOLOR( 211, 214, 219);
			rectsize = CGRectMake( 0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
		} else {
			self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
			rectsize = CGRectMake( 0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - 50.0);
		}
	}
	@catch (NSException * e) {}
	
	NSString *filepath = [[NSBundle mainBundle] pathForResource:@"hints" ofType:@"html"];
	NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath: filepath];
	
	NSString *htmlString = [[NSString alloc] initWithData: 
							[readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
	
	NSString *basepath = [[NSBundle mainBundle] bundlePath];
	NSURL *baseURL = [NSURL fileURLWithPath:basepath];
	
	// to make html content transparent to its parent view -
	// 1) set the webview's backgroundColor property to [UIColor clearColor]
	// 2) use the content in the html: <body style="background-color: transparent">
	// 3) opaque property set to NO
	//
	
	
	webView = [[UIWebView alloc] initWithFrame: rectsize];
	webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;  
	webView.delegate = self;
	[webView sizeToFit];
	
	webView.opaque = NO;
	webView.backgroundColor = [UIColor clearColor];
	
	[self.view addSubview: webView];
	
	[webView loadHTMLString: htmlString baseURL: baseURL];
	[htmlString release];
	
	
}


- (void)dealloc {
	[webView release];
	
    [super dealloc];
}


@end
