//
//  AirViewController.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/14.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "AirViewController.h"

@interface AirViewController ()

@end

@implementation AirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    NSDictionary *pm25Dict = self.data[@"pm25"];
    MyLog(@"pm25 == %@",pm25Dict);
    
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
