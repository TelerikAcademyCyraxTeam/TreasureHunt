//
//  AppDelegate.m
//  TreasureHunt
//
//  Created by Admin on 11/2/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "CacheListViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"LdDZ0p4n4EbVPNkU1Pc8I5VedgNepgsC4rlyRWBs"
                  clientKey:@"QWj1wZCFrY1P3eonq8ZpbXiMUggXei2jYCCWkz6U"];
    //[PFUser logOut];
    
    [GMSServices provideAPIKey:@"AIzaSyCeXMDflh9D_jqui_E-499OS6V_jUcNhLs"];
    
    PFUser *currentUser = [PFUser currentUser];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if(currentUser){
         CacheListViewController *home = [storyboard instantiateViewControllerWithIdentifier:@"home"];
        self.window.rootViewController = home;
    }
    else{
        UIViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        self.window.rootViewController = login;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
