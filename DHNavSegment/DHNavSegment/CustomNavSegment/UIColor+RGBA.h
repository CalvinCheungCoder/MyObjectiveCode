//
//  UIColor+RGBA.h
//  DHNavSegment
//
//  Created by 张丁豪 on 2017/3/24.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct
{
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
}RGBA;

@interface UIColor (RGBA)

/**
 *  获取UIColor对象的RGBA值
 *
 *  @param color UIColor
 *
 *  @return RGBA
 */
RGBA RGBAFromUIColor(UIColor *color);

@end
