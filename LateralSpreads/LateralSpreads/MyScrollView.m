//
//  MyScrollView.m
//  LateralSpreads
//
//  Created by CalvinCheung on 16/9/27.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "MyScrollView.h"
#import "LeftView.h"

// 拖拽出来的View宽
#define showLeftViewMaxWidth 100
// 可拖动最大距离
#define maxWidth [UIScreen mainScreen].bounds.size.width * 0.75

@interface MyScrollView ()<UIGestureRecognizerDelegate>
{
    // 初始位置
    CGPoint initialPosition;
}

@property (nonatomic, strong) LeftView *leftView;
// 蒙版
@property (nonatomic, strong) UIView *backView;

@end

@implementation MyScrollView

-(UIView *)leftView
{
    if (!_leftView) {
        _leftView = [[LeftView alloc]initWithFrame:CGRectMake(-maxWidth, 0, maxWidth, self.frame.size.height)];
        _leftView.backgroundColor = [UIColor whiteColor];
    }
    return _leftView;
}

-(UIView *)backView
{
    if (!_backView)
    {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
        UIPanGestureRecognizer *backPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(backPanGes:)];
        [_backView addGestureRecognizer:backPan];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewTapGes:)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

-(void)backPanGes:(UIPanGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateBegan) {
        // 获取leftView初始位置
        initialPosition.x = self.leftView.center.x;
    }
    
    CGPoint point = [ges translationInView:self];
    
    if (point.x <= 0 && point.x <= maxWidth) {
        _leftView.center = CGPointMake(initialPosition.x + point.x , _leftView.center.y);
        CGFloat alpha = MIN(0.5, (maxWidth + point.x) / (2* maxWidth));
        _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alpha];
    }
    
    if (ges.state == UIGestureRecognizerStateEnded)
    {
        if ( - point.x <= showLeftViewMaxWidth) {
            
            
            [UIView animateWithDuration:0.35f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _leftView.frame = CGRectMake(0, 0, maxWidth, self.frame.size.height);
                _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
            } completion:^(BOOL finished) {
                
            }];
            
        }else if ( - point.x > showLeftViewMaxWidth &&  - point.x <= maxWidth)
        {
            [UIView animateWithDuration:0.35f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _leftView.frame = CGRectMake(-maxWidth, 0, maxWidth, self.frame.size.height);
                _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
            } completion:^(BOOL finished) {
                [_backView removeFromSuperview];
            }];
        }
    }
}


-(void)backViewTapGes:(UITapGestureRecognizer *)ges
{
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _leftView.frame = CGRectMake(-maxWidth, 0, maxWidth, self.frame.size.height);
        _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        self.pan.enabled = YES;
        [_backView removeFromSuperview];
    }];
    
}

/**************************************************************/


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    [self addGestureRecognizer];
}

-(void)addGestureRecognizer
{
    self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    self.pan.delegate = self;
    [self addGestureRecognizer:self.pan];
}

-(void)panGesture:(UIPanGestureRecognizer *)ges
{
    [self dragLeftView:ges];
}

-(void)dragLeftView:(UIPanGestureRecognizer *)panGes
{
    
    [_leftView removeFromSuperview];
    [_backView removeFromSuperview];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.backView];
    [window addSubview:self.leftView];
    
    if (panGes.state == UIGestureRecognizerStateBegan) {
        //获取leftView初始位置
        initialPosition.x = self.leftView.center.x;
    }
    
    CGPoint point = [panGes translationInView:self];
    
    if (point.x >= 0 && point.x <= maxWidth) {
        _leftView.center = CGPointMake(initialPosition.x + point.x , _leftView.center.y);
        CGFloat alpha = MIN(0.5, (maxWidth + point.x) / (2* maxWidth) - 0.5);
        _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alpha];
    }
    
    if (panGes.state == UIGestureRecognizerStateEnded)
    {
        if (point.x <= showLeftViewMaxWidth) {
            
            [UIView animateWithDuration:0.35f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _leftView.frame = CGRectMake(-maxWidth, 0, maxWidth, self.frame.size.height);
                _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
            } completion:^(BOOL finished) {
                [_backView removeFromSuperview];
            }];
            
        }else if (point.x > showLeftViewMaxWidth && point.x <= maxWidth)
        {
            [UIView animateWithDuration:0.35f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _leftView.frame = CGRectMake(0, 0, maxWidth, self.frame.size.height);
                _backView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

@end
