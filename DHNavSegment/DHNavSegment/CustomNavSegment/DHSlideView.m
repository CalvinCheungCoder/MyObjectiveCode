//
//  DHSlideView.m
//  DHNavSegment
//
//  Created by 张丁豪 on 2017/3/24.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "DHSlideView.h"
#import "UIView+DHExtension.h"
#import "UIColor+RGBA.h"

@interface DHSlideView()<UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat red1;
@property (nonatomic, assign) CGFloat green1;
@property (nonatomic, assign) CGFloat blue1;
@property (nonatomic, assign) CGFloat alpha1;
@property (nonatomic, assign) CGFloat red2;
@property (nonatomic, assign) CGFloat green2;
@property (nonatomic, assign) CGFloat blue2;
@property (nonatomic, assign) CGFloat alpha2;

@end

@implementation DHSlideView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
        
        //self.layer.cornerRadius = frame.size.height/2;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = self.borderColor.CGColor;
        self.layer.borderWidth = 1;
        
        self.titles = titles;
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor redColor];
    self.borderColor = [UIColor whiteColor];
    self.titleNormalColor = [UIColor whiteColor];
    self.titleSelectedColor = [UIColor redColor];
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    NSInteger titleCount = titles.count;
    
    self.titleW = self.width / titleCount;
    self.titleH = self.height;
    // 设置背景
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake(0, 0, self.titleW, self.titleH);
    bgView.backgroundColor = [UIColor whiteColor];
    //bgView.layer.cornerRadius = self.height / 2;
    bgView.layer.cornerRadius = 3;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    self.bgView = bgView;
    // 添加标题
    for (NSInteger i = 0; i < titleCount; i++) {
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(i * self.titleW, 0, self.titleW, self.titleH);
        label.text = titles[i];
        label.tag = 100 + i;
        label.textAlignment = NSTextAlignmentCenter;
        //label.layer.cornerRadius = self.frame.size.height/2;
        label.layer.cornerRadius = 3;
        label.layer.masksToBounds = YES;
        label.font = [UIFont systemFontOfSize:15];
        label.userInteractionEnabled = YES;
        label.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped:)];
        [label addGestureRecognizer:tap];
        [self addSubview:label];
    }
}

- (void)setNormalColor
{
    for (NSInteger i = 100; i < 100 + self.titles.count; i++) {
        UILabel *label = [self viewWithTag:i];
        label.textColor = self.titleNormalColor;
    }
}

- (void)taped:(UITapGestureRecognizer *)tap
{
    //获取点击的Label
    UILabel *tapedLabel = (UILabel *)tap.view;
    tapedLabel.textColor = [UIColor redColor];
    
    if ([self.delegate respondsToSelector:@selector(slideView:didSelectedAtIndex:)]) {
        [self.delegate slideView:self didSelectedAtIndex:(tapedLabel.tag - 100)];
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
    
    RGBA rgba = RGBAFromUIColor(titleNormalColor);
    
    [self setNormalColor];
    
    self.red1 = rgba.r;
    self.green1 = rgba.g;
    self.blue1 = rgba.b;
    self.alpha1 = rgba.a;
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor
{
    _titleSelectedColor = titleSelectedColor;
    
    UILabel *label = [self viewWithTag:100];
    label.textColor = titleSelectedColor;
    
    RGBA rgba = RGBAFromUIColor(titleSelectedColor);
    
    self.red2 = rgba.r;
    self.green2 = rgba.g;
    self.blue2 = rgba.b;
    self.alpha2 = rgba.a;
}

- (void)changeColorWithOffsetX:(CGFloat)x width:(CGFloat)width
{
    [self setNormalColor];
    
    CGFloat p = fmod(x, width) / width;
    
    NSInteger index = x / width;
    
    UILabel *fromLabel = [self viewWithTag:(100+index)];
    UILabel *toLabel = (index + 1 < self.titles.count) ? [self viewWithTag:(100 + index+1)] : nil;
    
    self.bgView.x = self.titleW * (p + index);
    
    // 防止超过边界
    if (self.bgView.x < 0) {
        self.bgView.x = 0;
    }else if (self.bgView.x > (self.titles.count-1) * self.titleW){
        self.bgView.x = (self.titles.count-1) * self.titleW;
    }
    
    [self setColorFromLabel:fromLabel toLabel:toLabel precent:p];
    
}

- (void)setColorFromLabel:(UILabel *)fromLabel toLabel:(UILabel *)toLabel precent:(CGFloat)precent
{
    CGFloat redTemp1 = ((self.red2 - self.red1) * (1-precent)) + self.red1;
    CGFloat greenTemp1 = ((self.green2 - self.green1) * (1 - precent)) + self.green1;
    CGFloat blueTemp1 = ((self.blue2 - self.blue1) * (1 - precent)) + self.blue1;
    
    CGFloat redTemp2 = ((self.red2 - self.red1) * precent) + self.red1;
    CGFloat greenTemp2 = ((self.green2 - self.green1) * precent) + self.green1;
    CGFloat blueTemp2 = ((self.blue2 - self.blue1) * precent) + self.blue1;
    
    fromLabel.textColor = [UIColor colorWithRed:redTemp1 green:greenTemp1 blue:blueTemp1 alpha:1];
    toLabel.textColor = [UIColor colorWithRed:redTemp2 green:greenTemp2 blue:blueTemp2 alpha:1];
}

@end
