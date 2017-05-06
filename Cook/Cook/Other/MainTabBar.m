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
#import "FourViewController.h"
#import "SettingViewController.h"

@interface MainTabBar ()

@end

@implementation MainTabBar

- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self createViewController];
    
    // 创建子控制器
    [self createSubViewControllers];
    // 设置所有的、分栏元素项
    [self setTabBarItems];
}


// 创建子控制器
- (void)createSubViewControllers{
    
    // 状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    OneViewController *One = [[OneViewController alloc]init];
    CustomNavigationController *navi = [[CustomNavigationController alloc]initWithRootViewController:One];
    navi.fullScreenPopGestureEnabled = YES;
    
    TwoViewController *Two = [[TwoViewController alloc]init];
    CustomNavigationController *navi2 = [[CustomNavigationController alloc]initWithRootViewController:Two];
    navi2.fullScreenPopGestureEnabled = YES;
    
    ThreeViewController *four = [[ThreeViewController alloc]init];
    CustomNavigationController *navi4 = [[CustomNavigationController alloc]initWithRootViewController:four];
    navi4.fullScreenPopGestureEnabled = YES;
    
    FourViewController *Three = [[FourViewController alloc]init];
    CustomNavigationController *navi3 = [[CustomNavigationController alloc]initWithRootViewController:Three];
    navi3.fullScreenPopGestureEnabled = YES;
    
    SettingViewController *five = [[SettingViewController alloc]init];
    CustomNavigationController *navi5 = [[CustomNavigationController alloc]initWithRootViewController:five];
    navi5.fullScreenPopGestureEnabled = YES;
    
    self.viewControllers = @[navi,navi2,navi4,navi3,navi5];
}

// 设置所有的、分栏元素项
- (void)setTabBarItems{
    
    NSArray *titleArr = @[@"粥谱",@"专题",@"小知识",@"收藏",@"设置"];
    NSArray *normalImgArr = @[@"one",@"two",@"three",@"four",@"set@2x"];
    NSArray *selectedImgArr = @[@"oneSele",@"twoSele",@"threeSele",@"fourSele",@"setSele@2x"];
    // 循环设置信息
    for (int i = 0; i<titleArr.count; i++)
    {
        UIViewController *vc = self.viewControllers[i];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[UIImage imageNamed:normalImgArr[i]] selectedImage:[[UIImage imageNamed:selectedImgArr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        vc.tabBarItem.tag = i+1;
    }
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(253, 163, 62)} forState:UIControlStateSelected];
    
    // 消除Tabbar黑线
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    // 设置Tabbar背景色
    [[UITabBar appearance]setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    
    //获取导航条最高权限
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}

@end
