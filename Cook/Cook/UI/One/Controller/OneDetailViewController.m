//
//  OneDetailViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "OneDetailViewController.h"
#import "ShareView.h"
#import "UserData.h"
#import "DatabaseManager.h"

@interface OneDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) DatabaseManager *manger;

@property (nonatomic, copy) NSString *collectStr;

@end

@implementation OneDetailViewController

- (instancetype)initWithNumber:(NSString *)number title:(NSString *)title thumb:(NSString *)thumb
{
    self = [super init];
    if (self) {
        self.title2 = title;
        self.number2 = number;
        self.thumbCollect = thumb;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.manger = [DatabaseManager manager];
    
    UILabel *label = [Factory createLabelWithTitle:@"详细做法" frame:CGRectMake(0, 0, 40, 40) textColor:[UIColor whiteColor] fontSize:16.f];
    self.navigationItem.titleView = label;
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];

    [self getNetData];
    
    //分享按钮
    UIImage *shareImage = [[UIImage imageNamed:@"share"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:shareImage style:UIBarButtonItemStyleDone target:self action:@selector(ShareThisPage)];
    self.navigationItem.rightBarButtonItem = right;
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
    
    NSString *url = [NSString stringWithFormat:kCaiPuDetail,self.number2];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    switch (navigationType)
    {
            //点击连接
        case UIWebViewNavigationTypeLinkClicked:
        {
            if ([request.URL.absoluteString isEqualToString:@"bookmark://"]) {
                [self specialData];
            }
        }
            break;
        default:
            break;
    }
    return YES;
    
}

- (void)specialData {
    
    UserData *data = [[UserData alloc] init];
    data.title = _title2;
    data.thumb = _thumbCollect;
    data.idcollect = _number2;
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
    for (UserData *temp in arr) {
        
        if ([_number2 isEqualToString:temp.idcollect]) {

            NSString *str1 = @"var bookmark = document.getElementById('bookmark');" "bookmark.innerHTML = '已收藏';";
            [self.webView stringByEvaluatingJavaScriptFromString:str1];
            return;
        }
    }
    
    [self.manger insertCollecInformation:data];
    NSString *str1 = @"var bookmark = document.getElementById('bookmark');" "bookmark.innerHTML = '已收藏';";
    [self.webView stringByEvaluatingJavaScriptFromString:str1];
}

@end
