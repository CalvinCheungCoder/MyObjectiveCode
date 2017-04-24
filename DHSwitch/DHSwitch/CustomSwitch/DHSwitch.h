//
//  DHSwitch.h
//  DHSwitch
//
//  Created by 张丁豪 on 2017/3/23.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger,SwitchType) {
    SwitchOfDefault = 0, // 圆形
    SwitchOfRoundedSquare, // 方形圆角
    SwitchOfSquare // 方形不带圆角
};

@interface DHSwitch : UIControl <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *onBackgroundView;
@property (nonatomic, strong) UIView *offBackgroundView;
@property (nonatomic, strong) UIView *thumbView;

@property (nonatomic, getter = isOn) BOOL on;

/**
 开关的类型
 */
@property (nonatomic, assign) SwitchType type;

/**
 打开时候的背景颜色
// */
@property (nonatomic, strong) UIColor *onTintColor;

/**
 关闭时候的背景颜色
 */
@property (nonatomic, strong) UIColor *offTintColor;

/**
 开关的颜色
 */
@property (nonatomic, strong) UIColor *thumbTintColor;

/**
 阴影
 */
@property (nonatomic, assign) BOOL shadow;

/**
 关闭时候的边框颜色
 */
@property (nonatomic, strong) UIColor *offTintBorderColor;

/**
 打开时候的边框颜色
 */
@property (nonatomic, strong) UIColor *onTintBorderColor;

/**
 打开时候的文字
 */
@property (nonatomic, strong) UILabel *onBackLabel;

/**
 关闭时候的文字
 */
@property (nonatomic, strong) UILabel *offBackLabel;

@end
