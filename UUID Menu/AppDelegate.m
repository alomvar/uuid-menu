//
//  AppDelegate.m
//  UUID Menu
//
//  Created by Peter Horn on 18.01.14.
//  Copyright (c) 2014 Peter Horn. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (NSString*)GenerateUUIDString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    // TODO: Assign to private property!
    NSString *rawUUID = (__bridge NSString *)string;
    return rawUUID;
}

- (void)awakeFromNib {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:menu];
    // [statusItem setTitle:@"UUID Menu"];
    [statusItem setHighlightMode:YES];
    [statusItem setImage:[NSImage imageNamed:@"key2"]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (IBAction)copy:(id)sender {
    NSString *uuid = [self GenerateUUIDString];
    
    if ([self.hyphenlessMenuItem state] == NSOnState)
    {
        uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    if ([self.lowercaseMenuItem state] == NSOnState)
    {
        uuid = [uuid lowercaseString];
    }
    
    NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
    NSString *notificationText = [NSString stringWithFormat:@"UUID %@ copied to clipboard.", uuid];
    [pasteBoard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:nil];
    [pasteBoard setString:uuid forType:NSStringPboardType];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationText object:self];
}

- (IBAction)toggleCase:(NSMenuItem *)sender {
    if ([sender state] == NSOnState)
    {
        [sender setState:NSOffState];
    }
    else
    {
        [sender setState:NSOnState];
    }
}

- (IBAction)toggleHyphens:(NSMenuItem *)sender {
    if ([sender state] == NSOnState)
    {
        [sender setState:NSOffState];
    }
    else
    {
        [sender setState:NSOnState];
    }
}

- (IBAction)quit:(id)sender {
    [[NSStatusBar systemStatusBar] removeStatusItem:statusItem];
    [NSApp terminate:nil];
}

@end
