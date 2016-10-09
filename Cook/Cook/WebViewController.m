//
//  WebViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/9.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:topView];
    
    UILabel *label = [Factory createLabelWithTitle:@"详情" frame:CGRectMake(ScreenWidth/2 - 20, 20, 40, 44) textColor:[UIColor whiteColor] fontSize:18.f];
    [topView addSubview:label];
    
    UIButton *btn = [Factory createButtonWithTitle:@"关闭" frame:CGRectMake(20, 25, 40, 30) target:self selector:@selector(BtnClicked)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [topView addSubview:btn];
    
    [self setupWebView];
}

-(void)setupWebView{
    
    UIWebView *myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    myWebView.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.URLString]];
    [myWebView loadRequest:request];
    [self.view addSubview:myWebView];
    
}

-(void)BtnClicked{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
