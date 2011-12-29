//
//  ContainerTestAppDelegate.m
//  ContainerTest
//
//  Created by Zac Bowling on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContainerTestAppDelegate.h"
#import "ContainerViewController.h"
#import "TestChildViewController.h"

@implementation ContainerTestAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    TestChildViewController *alpha = [[TestChildViewController alloc] initWithNibName:nil bundle:nil];
    alpha.labelText = @"top  ";
    
    TestChildViewController *bottom = [[TestChildViewController alloc] initWithNibName:nil bundle:nil];
    bottom.labelText = @"bottom";
    

    
    ContainerViewController *cvc = [[ContainerViewController alloc] initWithTopBaseViewController:alpha bottomViewController:bottom];
    
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:cvc];
    navc.tabBarItem.title = @"Thing 1";
    
    TestChildViewController *two = [[TestChildViewController alloc] initWithNibName:nil bundle:nil];
    two.labelText = @"second";
    two.tabBarItem.title = @"Thing 2";
    
    UITabBarController *tabBarController = [[UITabBarController alloc]initWithNibName:nil bundle:nil];
    
    [tabBarController setDelegate:self];
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:navc, two, nil];
    
   
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"tab bar selected");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
