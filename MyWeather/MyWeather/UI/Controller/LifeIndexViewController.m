//
//  LifeIndexViewController.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/14.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "LifeIndexViewController.h"

@interface LifeIndexViewController ()

@end

@implementation LifeIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    [self setUpCloseBtn];
}

- (void)setUpCloseBtn{
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-30, ScreenHeight - 60, 60, 30)];
    [closeBtn setBackgroundColor:[UIColor orangeColor]];
    closeBtn.layer.cornerRadius = 5;
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(CloseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}

- (void)CloseBtnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
