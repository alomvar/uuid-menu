//
//  AppDelegate.m
//  UUID Menu
//
//  Created by Peter Horn on 18.01.14.
//  Copyright (c) 2014 Peter Horn. All rights reserved.

#import "AppDelegate.h"

@implementation AppDelegate

- (NSString*)GenerateUUIDString
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString *rawUUID = (__bridge NSString *)string;
    return rawUUID;
}

- (void)copyUUID:(NSString *)uuid
{
    NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
    [pasteBoard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:nil];
    [pasteBoard setString:uuid forType:NSStringPboardType];
}

- (void)awakeFromNib
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:menu];
    [statusItem setHighlightMode:YES];
    [statusItem setImage:[NSImage imageNamed:@"key2"]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    NSDictionary *userinfo = [notification userInfo];
    NSString *uuid = [userinfo objectForKey:@"uuid"];
    
    if (uuid != (id)[NSNull null])
    {
        [self copyUUID:uuid];
    }
}

- (IBAction)copy:(id)sender
{
    NSString *uuid = [self GenerateUUIDString];
    
    if ([self.hyphenlessMenuItem state] == NSOnState)
    {
        uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    if ([self.lowercaseMenuItem state] == NSOnState)
    {
        uuid = [uuid lowercaseString];
    }
    
    [self copyUUID:uuid];

    NSArray *notificationInfoKeys = [[NSArray alloc] initWithObjects:@"uuid", nil];
    NSArray *notificationInfoObjects = [[NSArray alloc] initWithObjects:uuid, nil];
    NSDictionary *notificationInfo = [[NSDictionary alloc] initWithObjects:notificationInfoObjects forKeys:notificationInfoKeys];
    
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"UUID copied to clipboard";
    notification.informativeText = [NSString stringWithFormat:@"%@", uuid];
    notification.userInfo = notificationInfo;
    notification.soundName = NSUserNotificationDefaultSoundName;
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

- (IBAction)toggleCase:(NSMenuItem *)sender
{
    if ([sender state] == NSOnState)
    {
        [sender setState:NSOffState];
    }
    else
    {
        [sender setState:NSOnState];
    }
}

- (IBAction)toggleHyphens:(NSMenuItem *)sender
{
    if ([sender state] == NSOnState)
    {
        [sender setState:NSOffState];
    }
    else
    {
        [sender setState:NSOnState];
    }
}

- (IBAction)quit:(id)sender
{
    [[NSStatusBar systemStatusBar] removeStatusItem:statusItem];
    [NSApp terminate:nil];
}

@end
