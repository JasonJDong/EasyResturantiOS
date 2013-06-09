//
//  DJAppDelegate.m
//  EasyRestaurant
//
//  Created by JasonDong on 12-10-29.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#import "DJAppDelegate.h"
#import "TeamViewController.h"
#import "FavoriteViewController.h"
#import "NearRestaurantViewController.h"
#import "MoreViewController.h"
#import "LoginViewController.h"

@implementation DJAppDelegate

@synthesize loginUser;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
//    UIViewController *viewControllerTeam = [[TeamViewController alloc] initWithNibName:@"TeamViewController" bundle:nil];
//    UIViewController *viewControllerFavorite = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController" bundle:nil];
//    UIViewController *viewControllerNearRestaurant = [[NearRestaurantViewController alloc]
//        initWithNibName:@"NearRestaurantViewController" bundle:nil];
//    UIViewController *viewControllerMore = [[MoreViewController alloc]
//        initWithNibName:@"MoreViewController" bundle:nil];
//    
//    UINavigationController *teamMainController = [[UINavigationController alloc] initWithRootViewController:viewControllerTeam];
//        
//    self.rootTabBarController = [[UITabBarController alloc] init];
//    self.rootTabBarController.viewControllers = @[teamMainController, viewControllerFavorite,viewControllerNearRestaurant,viewControllerMore];
//    self.window.rootViewController = self.rootTabBarController;
//    
    LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.window.rootViewController = loginView;
    loginView.mainBounld = self;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
