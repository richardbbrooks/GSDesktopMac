//
//  gsdAppDelegate.h
//  Grooveshark Desktop
//
//  Created by Richard Brooks on 6/15/12.
//  Copyright (c) 2012 Grooveshark. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface gsdAppDelegate : NSApplication

@property (retain) IBOutlet NSWindow *window;
@property (retain) IBOutlet NSView *mainView;
@property (retain) IBOutlet WebView *mainWebView;

@end

