//
//  BaseViewController.h
//  UIViewController2
//
//  Created by Hailong.wang on 15/7/30.
//  Copyright (c) 2015年 Hailong.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Addition.h"
#import "Factory.h"
#import "MyHelper.h"


@interface BaseViewController : UIViewController

//初始化数据源
- (void)initData;
//创建视图
- (void)createView;

//添加事件
- (void)addTouchAction;
//创建上导航左侧按钮(以view作模板)
- (void)createNavigationLeftButton:(id)view;
//创建上导航的左侧按钮(系统标题)
- (void)createNavigationLeftButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
//创建上导航右侧按钮(以view作模板)
- (void)createNavigationRightButton:(id)view;
//创建上导航的右侧按钮(系统标题)
- (void)createNavigationRightButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
//使用pop返回
- (void)backAction;

@end










