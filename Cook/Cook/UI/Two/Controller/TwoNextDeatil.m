//
//  TwoNextDeatil.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "TwoNextDeatil.h"
#import "ShareView.h"

@interface TwoNextDeatil ()<UIWebViewDelegate,CustomShareViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic, strong) DatabaseManager *manger;

@property (nonatomic, copy) NSString *collectStr;

@end

@implementation TwoNextDeatil

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
                          @{@"image":@"shareView_wb@2x",
                            @"title":@"新浪微博"},
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

-(void)easyCustomShareViewButtonAction:(ShareView *)shareView title:(NSString *)title{
    
    if ([title isEqualToString:@"微信"]) {
        
        [self shareTextToWechat];
        
    }else if ([title isEqualToString:@"朋友圈"]){
        
        [self WechatTimeLine];
        
    }else if ([title isEqualToString:@"新浪微博"]){
        
    }else{
        
        // 复制链接
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:kZhuanTiDeatail,self.number2];
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        // 显示文字
        [SVProgressHUD showSuccessWithStatus:@"链接已经复制"];
        // 整个后面的背景选择
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
}

-(void)getNetData{
    
    NSString *url = [NSString stringWithFormat:kZhuanTiDeatail,self.number2];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}


- (void)shareTextToWechat
{
    
    NSString *url = [NSString stringWithFormat:kZhuanTiDeatail,self.number2];
    NSString *text = [NSString stringWithFormat:@"我在早餐粥谱发现了好东西: %@，地址是: %@ 快来看看吧",_title2,url];
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = text;
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            if ((int)error.code == 2010) {
                message = @"取消分享";
            }else{
                message = @"分享失败";
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)WechatTimeLine
{
    
    NSString *url = [NSString stringWithFormat:kZhuanTiDeatail,self.number2];
    NSString *text = [NSString stringWithFormat:@"我在早餐粥谱发现了好东西: %@，地址是: %@ 快来看看吧",_title2,url];
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = text;
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            if ((int)error.code == 2010) {
                message = @"取消分享";
            }else{
                message = @"分享失败";
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
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

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}


@end
