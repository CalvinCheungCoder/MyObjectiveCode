//
//  DHStarsView.m
//  DHShowStarsView
//
//  Created by 张丁豪 on 2017/3/27.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "DHStarsView.h"

#define YKStarFont [UIFont systemFontOfSize:18]  // 星星size宏定义

@implementation DHStarsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        // 未点亮时的颜色是 灰色的
        self.emptyColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        // 点亮时的颜色是 亮黄色的
        self.fullColor = [UIColor orangeColor];
        // 默认的长度设置为100
        self.maxStar = 100;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSString *stars = @"★★★★★";
    
    rect = self.bounds;
    CGSize starSize = [stars sizeWithFont:YKStarFont];
    rect.size = starSize;
    [_emptyColor set];
    [stars drawInRect:rect withFont:YKStarFont];
    
    CGRect clip = rect;
    clip.size.width = clip.size.width * _showStar / _maxStar;
    CGContextClipToRect(context,clip);
    [_fullColor set];
    [stars drawInRect:rect withFont:YKStarFont];
    
}

@end
