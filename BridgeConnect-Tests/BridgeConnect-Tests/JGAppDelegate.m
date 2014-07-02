//
//  JGAppDelegate.m
//  BridgeConnect-Tests
//
//  Created by Jonas Gessner on 02.07.14.
//  Copyright (c) 2014 Jonas Gessner. All rights reserved.
//

#import "JGAppDelegate.h"
#import "BridgeConnect.h"

@implementation JGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSLog(@"Bridge Connect Version %@", kBridgeConnectVersion);
    
    if ([BridgeConnect canImportFiles]) {
        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"Artist-Title (1)-Album" ofType:@"mp3"];
        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"Artist-Title (2)-Album" ofType:@"mp3"];
        NSString *path3 = [[NSBundle mainBundle] pathForResource:@"Artist-Title (3)-Album" ofType:@"mp3"];
        
        if ([BridgeConnect importFilesAtPaths:@[path1, path2, path3] titles:@[@"Title 1", @"Title 2", @"Title 3"] artist:@"Artist!" album:@"> album title goes here <" genre:@"Genre" artwork:[UIImage imageNamed:@"artwork.jpg"]]) {
            NSLog(@"SUCCESS");
        }
        else {
            NSLog(@"ERROR");
        }
    }
    else {
        NSLog(@"ERROR: Cannot import files, Bridge is not installed");
    }
    
    self.window.rootViewController = [UIViewController new];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    exit(0);
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
