//
//  ViewController.m
//  LateralSpreads
//
//  Created by CalvinCheung on 16/9/27.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "ViewController.h"
#import "MyScrollView.h"

@interface ViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIPanGestureRecognizer *pan;
}
@property (nonatomic, strong) MyScrollView *scroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    [self.view addSubview:self.scroll];
    
    
}

-(UIScrollView *)scroll
{
    if (!_scroll)
    {
        _scroll = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scroll.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
        _scroll.pagingEnabled = YES;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.delegate = self;
        _scroll.bounces = NO;
    }
    return _scroll;
}


@end
