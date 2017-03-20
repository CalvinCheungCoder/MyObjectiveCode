//
//  RootViewController.m
//  NavDropdownMenu
//
//  Created by 张丁豪 on 2017/3/20.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "RootViewController.h"
#import "DHNavDropdownMenu.h"

@interface RootViewController ()<DHNavDropdownMenuDataSource,DHNavDropdownMenuDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self setup];
}

- (void)setup {
    DHNavDropdownMenu *menu = [[DHNavDropdownMenu alloc] initWithNavigationController:self.navigationController];
    menu.dataSource = self;
    menu.delegate = self;
    self.navigationItem.titleView = menu;
}

- (NSArray<NSString *> *)titleArrayForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu {
    return self.titleArray;
}

- (CGFloat)arrowPaddingForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu {
    return 8.0;
}

- (UIImage *)arrowImageForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu {
    return [UIImage imageNamed:@"Arrow"];
}

- (void)navigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu didSelectTitleAtIndex:(NSUInteger)index {
    
    NSLog(@"点击的按钮 == %ld",index);
}

#pragma mark - Property method
- (NSArray<NSString *> *)titleArray {
    return @[@"好友圈", @"测试标题", @"账号", @"23456"];
}


@end
