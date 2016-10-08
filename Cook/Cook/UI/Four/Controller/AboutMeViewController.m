//
//  AboutMeViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/8.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [Factory createLabelWithTitle:@"关于我们" frame:CGRectMake(0, 0, 40, 40) textColor:[UIColor whiteColor] fontSize:18.f];
    self.navigationItem.titleView = label;
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    NSString *url = @"http://www.zhangdinghao.cn/?page_id=19";
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}



@end
