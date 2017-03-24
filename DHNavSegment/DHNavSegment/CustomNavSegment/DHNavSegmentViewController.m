//
//  DHNavSegmentViewController.m
//  DHNavSegment
//
//  Created by 张丁豪 on 2017/3/24.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "DHNavSegmentViewController.h"
#import "UIView+DHExtension.h"
#import "DHSlideView.h"

@interface DHNavSegmentViewController ()<UIScrollViewDelegate,DHSlideViewDelegate>

@property (nonatomic, weak) UIScrollView *mainScrollView;

@property (nonatomic, weak) DHSlideView *slideView;

@end

@implementation DHNavSegmentViewController

- (instancetype)initWithTitles:(NSArray *)titles ViewControllers:(NSArray *)vcs
{
    if (self = [super init]) {
        
        [self setup];
        
        self.titles = titles;
        self.vcs = vcs;
    }
    return self;
}

- (void)setup
{
    self.navBarBgColor = [UIColor redColor];
    self.titleBorderColor = [UIColor whiteColor];
    self.titleNormalColor = [UIColor whiteColor];
    self.titleSelectedColor = [UIColor redColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    
    [self addChildViewControllers];
    
    [self initScrollView];
}

/**
 *  初始化导航栏
 */
- (void)initNavBar
{
    self.navigationController.navigationBar.barTintColor = self.navBarBgColor;
    
    DHSlideView *slideView = [[DHSlideView alloc] initWithFrame:CGRectMake(0, 0, 200, 30) titles:self.titles];
    slideView.delegate = self;
    slideView.backgroundColor = self.navBarBgColor;
    slideView.borderColor = self.titleBorderColor;
    slideView.titleNormalColor = self.titleNormalColor;
    slideView.titleSelectedColor = self.titleSelectedColor;
    
    self.navigationItem.titleView = slideView;
    self.slideView = slideView;
}

/**
 *  添加子控制器
 */
- (void)addChildViewControllers
{
    [self.vcs enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:vc];
    }];
}

/**
 *  初始化ScrollView
 */
- (void)initScrollView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    mainScrollView.delegate = self;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.bounces = NO; // 默认为YES 取消设置NO
    [self.view addSubview:mainScrollView];
    self.mainScrollView = mainScrollView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:mainScrollView];
}

#pragma mark --
#pragma mark -- DHSlideViewDelegate
- (void)slideView:(DHSlideView *)slideView didSelectedAtIndex:(NSInteger)index
{
    [self addChildVCViewWithIndex:index];
    
    [self.mainScrollView setContentOffset:CGPointMake(self.mainScrollView.width * index, 0) animated:NO];
}

#pragma mark --
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.slideView changeColorWithOffsetX:scrollView.contentOffset.x width:scrollView.width];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    if (index == self.childViewControllers.count - 1) {
        [self addChildVCViewWithIndex:index];
    }else{
        for (NSInteger i = index; i <= index+1; i++) {
            [self addChildVCViewWithIndex:i];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)addChildVCViewWithIndex:(NSInteger)index
{
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = index * self.mainScrollView.width;
    vc.view.y = 0;
    vc.view.height = self.mainScrollView.height;
    [self.mainScrollView addSubview:vc.view];
}

@end
