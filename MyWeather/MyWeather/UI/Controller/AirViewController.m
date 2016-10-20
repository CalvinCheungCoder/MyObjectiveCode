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
    
    self.view.backgroundColor = RGB(74, 119, 210);
    
    NSDictionary *pm25Dict = self.data[@"pm25"];
    MyLog(@"pm25 == %@",pm25Dict);
    
    [self setUpCloseBtn];
}


- (void)setUpCloseBtn{
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 25, 20, 20)];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(CloseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}

- (void)CloseBtnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
