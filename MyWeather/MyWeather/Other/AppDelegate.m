//
//  AppDelegate.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/10.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    RootViewController *root = [[RootViewController alloc]init];
//    CustomNavigationController *cusNav = [[CustomNavigationController alloc]initWithRootViewController:root];
    self.window.rootViewController = root;
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
