//
//  WordDetailViewController.m
//  MyWord
//
//  Created by CalvinCheung on 16/10/16.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "WordDetailViewController.h"

@interface WordDetailViewController ()

@end

@implementation WordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"WordDetail";
    
    [self setUpUI];
}

- (void)setUpUI{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, ScreenWidth - 40, 20)];
    label.text = [NSString stringWithFormat:@"单词:%@",self.data.word];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    UILabel *des = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, ScreenWidth - 40, 30)];
    des.textAlignment = NSTextAlignmentLeft;
    des.text = [NSString stringWithFormat:@"注释:%@",self.data.des];
    des.textColor = [UIColor grayColor];
    [self.view addSubview:des];
    
}

@end
