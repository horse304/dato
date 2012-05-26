//
//  AppDelegate.m
//  Relax
//
//  Created by Dat Nguyen on 5/13/12.
//  Copyright (c) 2012 NIIT. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setApplicationSupportsShakeToEdit:YES];
    ViewController *myViewController = (ViewController*)self.window.rootViewController;
    myViewController.modelController = [[ModelController alloc] init];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    ViewController *myViewController = (ViewController*)self.window.rootViewController;
    myViewController.modelController = [[ModelController alloc] init];
    [myViewController applicationWillResignActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    ViewController *myViewController = (ViewController*)self.window.rootViewController;
    myViewController.modelController = [[ModelController alloc] init];
    [myViewController applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
