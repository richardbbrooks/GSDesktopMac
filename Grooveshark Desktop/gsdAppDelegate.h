//
//  gsdAppDelegate.h
//  Grooveshark Desktop
//
//  Created by Richard Brooks on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import <IOKit/hidsystem/ev_keymap.h>

@interface gsdAppDelegate : NSApplication

@property (unsafe_unretained) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSView *mainView;
@property (weak) IBOutlet WebView *mainWebView;


@end

