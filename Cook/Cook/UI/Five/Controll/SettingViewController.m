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
    self.title = @"设置";
    [self setTabView];
}

-(void) setTabView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"Cell";
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray *imgArr = @[@"center_01@2x",@"center_02@2x",@"center_03@2x",@"center_04@2x",@"center_05@2x"];
    NSArray *titleArr = @[@"清除缓存",@"关于我们",@"意见反馈",@"隐私条款",@"给我评分"];
    
    cell.ImageView.image = [UIImage imageNamed:imgArr[indexPath.section]];
    cell.titleLabel.text = titleArr[indexPath.section];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        NSUInteger fileSize = [[SDImageCache sharedImageCache] getSize];
        CGFloat size = fileSize/1024.0/1024.0;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否要清除缓存" message:[NSString stringWithFormat:@"缓存大小%.2fM",size] preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            [[SDImageCache sharedImageCache] clearMemory];
            [[SDImageCache sharedImageCache] clearDisk];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    
    }else if (indexPath.section == 1){
        
        AboutMeViewController *aboutMe = [[AboutMeViewController alloc]init];
        aboutMe.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutMe animated:YES];
        
    }else if (indexPath.section == 2){
        
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
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的设备暂没有安装邮件客户端，反馈可以在 AppStore 进行哦！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
    }else if (indexPath.section == 3){
        
        PrivacyViewController *priv = [[PrivacyViewController alloc]init];
        priv.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:priv animated:YES];
    }else{
            
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E6%97%A9%E9%A4%90%E7%B2%A5%E8%B0%B1/id1044575251?mt=8"]];
    }
}


// section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 10;
    }else{
        return 0.1;
    }
}
// section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.1)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    
}
// section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
// section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
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
