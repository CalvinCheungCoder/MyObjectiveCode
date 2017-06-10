//
//  RootViewController.m
//  CustomTransitions
//
//  Created by CalvinCheung on 16/9/29.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "RootViewController.h"
#import "SecViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.title = @"Root";
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 150, [UIScreen mainScreen].bounds.size.width - 100, 46)];
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    btn.layer.cornerRadius = 8;
    [btn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)nextPage{
    
    SecViewController *sec = [[SecViewController alloc]init];
    [self.navigationController pushViewController:sec animated:YES];
}

@end
