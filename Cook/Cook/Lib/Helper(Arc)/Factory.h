//
//  Factory.h
//  StopWatchDemo
//
//  Created by Hailong.wang on 15/7/28.
//  Copyright (c) 2015年 Hailong.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Factory : NSObject

//创建Button的工厂，将特殊的元素传入，生产相对应的Button
+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame target:(id)target selector:(SEL)selector;

+ (UIButton *)createButtonWithTitle:(NSString *)title
                              frame:(CGRect)frame
                          titleFont:(CGFloat)size
                          textColor:(UIColor *)textColor
                    backgroundColor:(UIColor *)bgColor
                             target:(id)target
                           selector:(SEL)selector;

//创建Label的工厂，将特殊的元素传入，生产相对应的Label
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame;
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color;
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame fontSize:(CGFloat)size;
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color fontSize:(CGFloat)size;

//创建View的工厂，将特殊的元素传入，生产相应的View
+ (UIView *)createViewWithBackgroundColor:(UIColor *)color frame:(CGRect)frame;

//创建textField的工厂，将特殊的元素传入，生产响应的textField
+ (UITextField *)createViewWithText:(NSString *)text frame:(CGRect)frame placeholder:(NSString *)placeholder textColor:(UIColor *)color borderStyle:(UITextBorderStyle)borderStyle;

//轩哥
+ (UIButton *)creatButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name title:(NSString *)title;
+ (UILabel *)creatLabelWithFrame:(CGRect)frame text:(NSString *)text;

@end
