//
//  RootViewController.m
//  NavSegment
//
//  Created by 张丁豪 on 2017/3/20.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "RootViewController.h"
#import "OneTableView.h"
#import "TwoTableView.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface RootViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentCtrl;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    [self settingScrollView];
    [self settingSegment];
}

- (void)settingScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    scrollView.contentInset = UIEdgeInsetsMake(-64, 0, -49, 0);
    scrollView.contentSize = CGSizeMake(2 * Width, Height);
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:scrollView];
    
    OneTableView *tableViewOne = [[OneTableView alloc] initWithFrame:CGRectMake(Width,64, Width, Height-64)];
    TwoTableView *tableViewTwo = [[TwoTableView alloc] initWithFrame:CGRectMake(0,64, Width, Height-64)];
    
    [scrollView addSubview:tableViewOne];
    [scrollView addSubview:tableViewTwo];
    
    _scrollView = scrollView;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offset = scrollView.contentOffset.x;
    self.segmentCtrl.selectedSegmentIndex = offset/Width;
}

- (void)settingSegment{
    
    UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc] initWithItems:@[@"One",@"Two"]];
    self.navigationItem.titleView = segmentCtrl;
    [segmentCtrl setWidth:60 forSegmentAtIndex:0];
    [segmentCtrl setWidth:60 forSegmentAtIndex:1];
    segmentCtrl.selectedSegmentIndex = 0;
    [segmentCtrl addTarget:self action:@selector(segmentBtnClick) forControlEvents:UIControlEventValueChanged];
    _segmentCtrl = segmentCtrl;
}

- (void)segmentBtnClick{
    NSLog(@"改变========改变");
    self.scrollView.contentOffset = CGPointMake(self.segmentCtrl.selectedSegmentIndex * Width, 0);
}


@end
