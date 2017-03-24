//
//  DHSlideView.h
//  DHNavSegment
//
//  Created by 张丁豪 on 2017/3/24.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHSlideView;
@protocol DHSlideViewDelegate <NSObject>

- (void)slideView:(DHSlideView *)slideView didSelectedAtIndex:(NSInteger)index;

@end

@interface DHSlideView : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, assign) CGFloat titleW;

@property (nonatomic, assign) CGFloat titleH;

@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, strong) UIColor *titleNormalColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, assign) id<DHSlideViewDelegate> delegate;

- (void)changeColorWithOffsetX:(CGFloat)x width:(CGFloat)width;

@end
