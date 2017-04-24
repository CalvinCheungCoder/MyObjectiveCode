//
//  ViewController.m
//  DHPageControl
//
//  Created by 张丁豪 on 2017/3/31.
//  Copyright © 2017年 calvin. All rights reserved.
//

#import "ViewController.h"
#import "DHCycleScrollView.h"

@interface ViewController ()<DHCycleScrollViewDelegate>

@property (nonatomic, strong) DHCycleScrollView *scrollView;

@property (nonatomic ,strong) NSArray *imageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    // 设置顶部轮播器
    self.scrollView = [[DHCycleScrollView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 180)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    // 设置分页位置
    self.scrollView.pageControlAliment = DHCycleScrollViewPageContolAlimentRight;
    // 设置时间间隔
    self.scrollView.autoScrollTimeInterval = 3.0;
    // 设置当前分页圆点颜色
    self.scrollView.currentPageDotColor = [UIColor whiteColor];
    // 设置其它分页圆点颜色
    self.scrollView.pageDotColor = [UIColor lightGrayColor];
    // 设置背景图
    self.scrollView.placeholderImage = [UIImage imageNamed:@"bannerIcon"];
    // 设置动画样式
    self.scrollView.pageControlStyle = DHCycleScrollViewPageContolStyleAnimated;
    
    self.imageArray = @[@"001",@"002",@"003",@"004",@"005"];
    self.scrollView.localizationImageNamesGroup = self.imageArray;
    [self.view addSubview:self.scrollView];
}

#pragma mark --
#pragma mark -- SDCycleScrollViewDElegate
- (void)cycleScrollView:(DHCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSLog(@"点击了 == %ld",index);
}



@end
