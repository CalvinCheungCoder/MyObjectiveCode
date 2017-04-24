//
//  UIView+DHExtension.h
//  DHPageControl
//
//  Created by 张丁豪 on 2017/3/31.
//  Copyright © 2017年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

@interface UIView (DHExtension)

@property (nonatomic, assign) CGFloat dh_height;
@property (nonatomic, assign) CGFloat dh_width;

@property (nonatomic, assign) CGFloat dh_y;
@property (nonatomic, assign) CGFloat dh_x;

@end
