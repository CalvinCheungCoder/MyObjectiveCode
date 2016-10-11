//
//  SettingViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/8.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "PrivacyViewController.h"
#import <MessageUI/MessageUI.h>
#import "AboutMeViewController.h"
#import <StoreKit/StoreKit.h>

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,SKStoreProductViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [Factory createLabelWithTitle:@"设置" frame:CGRectMake(0, 0, 40, 40) textColor:[UIColor whiteColor] fontSize:18.f];
    self.navigationItem.titleView = label;
    
    [self setTabView];
}

-(void) setTabView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
        
    }else{
        
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"Cell";
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
        cell.ImageView.image = [[UIImage imageNamed:@"icon_setting_h@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        cell.titleLabel.text = @"清除缓存";
        
    }else{
        if (indexPath.row == 0) {
            
            cell.ImageView.image = [[UIImage imageNamed:@"find_emotion@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            cell.titleLabel.text = @"关于我们";
            
        }else if (indexPath.row == 1){
            
            cell.ImageView.image = [[UIImage imageNamed:@"me_setting_comment@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            cell.titleLabel.text = @"意见反馈";
            
        }else if (indexPath.row == 2){
            
            cell.ImageView.image = [[UIImage imageNamed:@"find_culture@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            cell.titleLabel.text = @"隐私条款";
            
        }else{
            
            cell.ImageView.image = [[UIImage imageNamed:@"me_setting_points@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            cell.titleLabel.text = @"给我评分";
        }
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        self.title = @"意见反馈";
    }else{
        
        self.title = @"关于我们";
    }
    
    return self.title;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.section == 0) {
        
        NSUInteger fileSize = [[SDImageCache sharedImageCache] getSize];
        CGFloat size = fileSize/1024.0/1024.0;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否要清除缓存" message:[NSString stringWithFormat:@"缓存大小%.2fM",size] preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            [[SDImageCache sharedImageCache] clearMemory];
            [[SDImageCache sharedImageCache] clearDisk];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    
    }else{
        
        if (indexPath.row == 0) {
            
            AboutMeViewController *aboutMe = [[AboutMeViewController alloc]init];
            aboutMe.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutMe animated:YES];
            
        }else if (indexPath.row == 1){
            
            // 当前设备中是否支持 邮件功能
            if ([MFMailComposeViewController canSendMail]) {
                // 检测 是否可以 发送邮件
                // 如果支持那么 跳转到 一个 带邮件功能的界面
                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
                // 设置 相关信息
                // 设置 联系人
                [mail setToRecipients:@[@"984382258@qq.com"]];
                [mail setSubject:@"早餐粥谱Bug反馈"];
                // 邮件内容
                [mail setMessageBody:@"" isHTML:YES];
                // 获取 发送的状态 必须要设置代理
                mail.mailComposeDelegate = self;
                // 模态跳转
                [self presentViewController:mail animated:YES completion:nil];
            }else {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的设备不支持邮件功能，反馈可以在 AppStore 进行哦！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }
            
        }else if (indexPath.row == 2){
            
            PrivacyViewController *priv = [[PrivacyViewController alloc]init];
            priv.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:priv animated:YES];
            
        }else{
            
            // 初始化控制器
            SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
            // 设置代理请求为当前控制器本身
            storeProductViewContorller.delegate = self;
            // 加载一个新的视图展示
            [storeProductViewContorller loadProductWithParameters:
             // appId唯一的
             @{SKStoreProductParameterITunesItemIdentifier : @"1044575251"} completionBlock:^(BOOL result, NSError *error) {
                 // block回调
                 if(error){
//                     NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
                 }else{
                     //模态弹出appstore
                     [self presentViewController:storeProductViewContorller animated:YES completion:^{
                         
                     }
                      ];
                 }
             }];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    //跳转返回
    [controller dismissViewControllerAnimated:YES completion:nil];
}

//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
