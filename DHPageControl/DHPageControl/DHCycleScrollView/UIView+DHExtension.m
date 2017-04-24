//
//  UIView+DHExtension.m
//  DHPageControl
//
//  Created by 张丁豪 on 2017/3/31.
//  Copyright © 2017年 calvin. All rights reserved.
//

#import "UIView+DHExtension.h"

@implementation UIView (DHExtension)

- (CGFloat)dh_height
{
    return self.frame.size.height;
}

- (void)setDh_height:(CGFloat)dh_height
{
    CGRect temp = self.frame;
    temp.size.height = dh_height;
    self.frame = temp;
}

- (CGFloat)dh_width
{
    return self.frame.size.width;
}

- (void)setDh_width:(CGFloat)dh_width
{
    CGRect temp = self.frame;
    temp.size.width = dh_width;
    self.frame = temp;
}


- (CGFloat)dh_y
{
    return self.frame.origin.y;
}

- (void)setDH_y:(CGFloat)dh_y
{
    CGRect temp = self.frame;
    temp.origin.y = dh_y;
    self.frame = temp;
}

- (CGFloat)dh_x
{
    return self.frame.origin.x;
}

- (void)setDh_x:(CGFloat)dh_x
{
    CGRect temp = self.frame;
    temp.origin.x = dh_x;
    self.frame = temp;
}

@end
