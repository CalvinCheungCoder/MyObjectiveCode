//
//  ViewController.m
//  DHShowStarsView
//
//  Created by 张丁豪 on 2017/3/27.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "ViewController.h"
#import "DHStarsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DHStarsView *stars = [[DHStarsView alloc]initWithFrame:CGRectMake(20, 100, 200, 80)];
    stars.showStar = 2.5 * 20;
    [self.view addSubview:stars];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
