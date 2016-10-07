//
//  ThreeDetailViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "ThreeDetailViewController.h"
#import "ShareView.h"

@interface ThreeDetailViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation ThreeDetailViewController

- (instancetype)initWithID:(NSString *)ID title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.ID2 = ID;
        self.title2 = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [Factory createLabelWithTitle:self.title2 frame:CGRectMake(0, 0, 40, 40) textColor:[UIColor whiteColor] fontSize:16.f];
    self.navigationItem.titleView = label;
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    //分享按钮
    UIImage *shareImage = [[UIImage imageNamed:@"share"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:shareImage style:UIBarButtonItemStyleDone target:self action:@selector(ShareThisPage)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self getNetData];
}

-(void)ShareThisPage{
    
    NSArray *shareAry = @[@{@"image":@"shareView_wx@2x",
                            @"title":@"微信"},
                          @{@"image":@"shareView_friend@2x",
                            @"title":@"朋友圈"},
                          @{@"image":@"shareView_qq@2x",
                            @"title":@"QQ"},
                          @{@"image":@"shareView_wb@2x",
                            @"title":@"新浪微博"},
                          @{@"image":@"shareView_qzone@2x",
                            @"title":@"QQ空间"},
                          @{@"image":@"share_copyLink",
                            @"title":@"复制链接"}];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.f];
    label.text = @"分享";
    [headerView addSubview:label];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, headerView.frame.size.height-0.5, headerView.frame.size.width - 40, 0.5)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [headerView addSubview:lineLabel];
    
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, headerView.frame.size.width - 40, 0.5)];
    lineLabel1.backgroundColor = [UIColor blackColor];
    
    ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    shareView.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    shareView.headerView = headerView;
    float height = [shareView getBoderViewHeight:shareAry firstCount:7];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.middleLineLabel.hidden = YES;
    [shareView.cancleButton addSubview:lineLabel1];
    shareView.cancleButton.frame = CGRectMake(shareView.cancleButton.frame.origin.x, shareView.cancleButton.frame.origin.y, shareView.cancleButton.frame.size.width, 54);
    shareView.cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [shareView.cancleButton setTitleColor:[UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1.0] forState:UIControlStateNormal];
    [shareView setShareAry:shareAry delegate:self];
    [self.navigationController.view addSubview:shareView];
}

-(void)getNetData{
    
    NSString *url = [NSString stringWithFormat:kKnowledgeDetail,self.ID2];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSRange range = [request.URL.absoluteString rangeOfString:@"baidu"];
    if (range.location != NSNotFound  ) {
        return NO;
    }
    return YES;
}

@end
