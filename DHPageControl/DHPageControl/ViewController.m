//
//  ViewController.m
//  DHPageControl
//
//  Created by 张丁豪 on 2017/3/22.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "ViewController.h"
#import "DHPageControl.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.f)

#define RandomColor RGB(arc4random()%256,arc4random()%256,arc4random()%256)

#define PageNumber 4

@interface ViewController ()<UIScrollViewDelegate,DHPageControlDelegate>

@property (nonatomic, strong) DHPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScrollView *guideScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    guideScrollView.delegate = self;
    guideScrollView.contentSize = CGSizeMake(ScreenWidth * PageNumber, ScreenHeight);
    guideScrollView.contentOffset = CGPointMake(0, 0);
    guideScrollView.showsVerticalScrollIndicator = NO;
    guideScrollView.showsHorizontalScrollIndicator = NO;
    guideScrollView.bounces = NO;
    guideScrollView.pagingEnabled = YES;
    [self.view addSubview:guideScrollView];
    
    for (int i = 0; i < PageNumber; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        view.backgroundColor = RandomColor;
        [guideScrollView addSubview:view];
    }
    
    self.pageControl = [[DHPageControl alloc]initWithStyel:DHPageControlStyelRectangle];
    self.pageControl.numberOfPages = PageNumber;
    self.pageControl.center = CGPointMake(self.view.frame.size.width/2, 140);
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:81/255.0 green:182/255.0 blue:200/255.0 alpha:1];
    self.pageControl.defersCurrentPageDisplay = NO;
    self.pageControl.delegate = self;
    [self.view addSubview:self.pageControl];
}

-(void)pageControl:(DHPageControl *)pageControl changgeCurrentPage:(NSInteger)currentPage{
    
    
}

#pragma mark --
#pragma mark -- scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    int currentpage = point.x/ScreenWidth;
    
    self.pageControl.currentPage = currentpage;
}



@end
