//
//  PrivacyViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/8.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [Factory createLabelWithTitle:@"服务协议" frame:CGRectMake(0, 0, 40, 40) textColor:[UIColor whiteColor] fontSize:18.f];
    self.navigationItem.titleView = label;
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.scrollView.backgroundColor = [UIColor whiteColor];
    webView.backgroundColor = [UIColor whiteColor];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"service.html"
                                                         ofType:nil];
    NSString *htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];
    [webView loadHTMLString:htmlCont baseURL:baseURL];
    
    [self.view addSubview:webView];
    
}


@end
