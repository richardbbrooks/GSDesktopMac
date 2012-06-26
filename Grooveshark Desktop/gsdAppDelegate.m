//
//  gsdAppDelegate.m
//  Grooveshark Desktop
//
//  Created by Richard Brooks on 6/15/12.
//  Copyright (c) 2012 Grooveshark. All rights reserved.
//

#import "gsdAppDelegate.h"
#import <IOKit/hidsystem/ev_keymap.h>

@implementation gsdAppDelegate

@synthesize window;
@synthesize mainView;
@synthesize mainWebView;

//Todo - not hardcode this. Grab it from what it should be.
static NSString *userAgent = @"Mozilla/5.0 Macintosh Intel Mac OS X 10_7_4 AppleWebKit/534.57.2 KHTML, like Gecko Version/5.1.7 Safari/534.57.2 GroovesharkDesktopMac/0.1";

-(void)dealloc
{
    [self setMainWebView:nil];
    [self setMainView:nil];
    [self setWindow:nil];
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.mainWebView setCustomUserAgent:userAgent];
    
    NSURL *url = [NSURL URLWithString:@"http://grooveshark.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[self.mainWebView mainFrame] loadRequest:request];
    
#ifdef DEBUG
    NSLog(@"Custom user agent: %@", self.mainWebView.customUserAgent);
#endif
}

- (void)sendEvent:(NSEvent*)event
{
	if([event type] == NSSystemDefined && [event subtype] == 8)
	{
		int keyCode = (([event data1] & 0xFFFF0000) >> 16);
		int keyFlags = ([event data1] & 0x0000FFFF);
		int keyState = (((keyFlags & 0xFF00) >> 8)) == 0xA;
		int keyRepeat = (keyFlags & 0x1);
        
		[self mediaKeyEvent:keyCode state:keyState repeat:keyRepeat];
	}
    
	[super sendEvent:event];
}

- (void)mediaKeyEvent:(int)key state:(BOOL)state repeat:(BOOL)repeat
{
#ifdef DEBUG
    NSLog (@"Key is %d", key);
#endif
    
	switch( key )
    {
        case NX_KEYTYPE_PLAY:
            if( state == 0 )
                [self.mainWebView stringByEvaluatingJavaScriptFromString:@"GS.player.togglePlayPause()"];
            break;
            
        case NX_KEYTYPE_FAST:
            if( state == 0 )
                [self.mainWebView stringByEvaluatingJavaScriptFromString:@"GS.player.nextSong()"];
            break;
            
        case NX_KEYTYPE_REWIND:
            if( state == 0 )
                [self.mainWebView stringByEvaluatingJavaScriptFromString:@"GS.player.previousSong()"];
            break;
    }
}

@end

