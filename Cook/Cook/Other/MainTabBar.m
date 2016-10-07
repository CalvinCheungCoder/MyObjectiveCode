//
//  MainTabBar.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "MainTabBar.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "CustomNavigationController.h"

@interface MainTabBar ()

@end

@implementation MainTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createViewController];
}

-(void)createViewController{
    // 通过UIAppearance设置标题颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1 green:0.56 blue:0.36 alpha:1]} forState:UIControlStateSelected];
    
    //粥谱
    OneViewController *menu = [[OneViewController alloc] init];
    CustomNavigationController *navMenu = [[CustomNavigationController alloc] initWithRootViewController:menu];
    navMenu.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"粥谱" image:[[UIImage imageNamed:@"食谱A"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"食谱B"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //专题
    TwoViewController *special = [[TwoViewController alloc] init];
    CustomNavigationController *navSpecial = [[CustomNavigationController alloc] initWithRootViewController:special];
    navSpecial.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"专题" image:[[UIImage imageNamed:@"zhuantiA"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"zhuantiB"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //小知识
    ThreeViewController *knowledge = [[ThreeViewController alloc] init];
    CustomNavigationController *navknowledge = [[CustomNavigationController alloc] initWithRootViewController:knowledge];
    navknowledge.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"小知识" image:[[UIImage imageNamed:@"xiaozhishiA"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"xiaozhishiB"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers = @[navMenu,navSpecial,navknowledge];
}


@end
