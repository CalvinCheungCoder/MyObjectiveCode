//
//  BaseViewController.m
//  Cook
//
//  Created by 张丁豪 on 2017/4/24.
//  Copyright © 2017年 CalvinCheung. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(236, 236, 236);
    
    [self.navigationController.navigationBar setBarTintColor:RGB(253, 163, 62)];
    [self.navigationController.navigationBar setBackgroundColor:RGB(253, 163, 62)];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}


@end
