//
//  AppDelegate.h
//  UUID Menu
//
//  Created by Peter Horn on 18.01.14.
//  Copyright (c) 2014 Peter Horn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem *statusItem;
    IBOutlet NSMenu *menu;
    @private NSString *processedUUID;
}

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSMenuItem *lowercaseMenuItem;
@property (strong) IBOutlet NSMenuItem *hyphenlessMenuItem;
@end
