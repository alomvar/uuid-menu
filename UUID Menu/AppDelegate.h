//
//  AppDelegate.h
//  UUID Menu
//
//  Created by Peter Horn on 18.01.14.
//  Copyright (c) 2014 Peter Horn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate> {
    NSStatusItem *statusItem;
    IBOutlet NSMenu *menu;
}

@property (weak) IBOutlet NSMenuItem *lowercaseMenuItem;
@property (weak) IBOutlet NSMenuItem *hyphenlessMenuItem;
@end
