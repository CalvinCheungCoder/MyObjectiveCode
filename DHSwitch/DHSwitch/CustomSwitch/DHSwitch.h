//
//  DHSwitch.h
//  DHSwitch
//
//  Created by 张丁豪 on 2017/3/23.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ColorSwitchShapeOval,
    ColorSwitchShapeRectangle,
    ColorSwitchShapeRectangleNoCorner
} ColorSwitchShape;

@interface DHSwitch : UIControl <UIGestureRecognizerDelegate>

@property (nonatomic, getter = isOn) BOOL on;

@property (nonatomic, assign) ColorSwitchShape shape;

@property (nonatomic, strong) UIColor *onTintColor;

@property (nonatomic, strong) UIColor *offTintColor;

@property (nonatomic, strong) UIColor *thumbTintColor;

@property (nonatomic, assign) BOOL shadow;

@property (nonatomic, strong) UIColor *offTintBorderColor;

@property (nonatomic, strong) UIColor *onTintBorderColor;

@property (nonatomic, strong) UILabel *onBackLabel; // 打开时候的文字

@property (nonatomic, strong) UILabel *offBackLabel; // 关闭时候的文字

@end
