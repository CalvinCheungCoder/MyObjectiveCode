//
//  DHStarsView.h
//  DHShowStarsView
//
//  Created by 张丁豪 on 2017/3/27.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHStarsView : UIView

@property (nonatomic, assign) NSInteger maxStar;        // 最大值
@property (nonatomic, assign) NSInteger showStar;       // 显示值
@property (nonatomic, strong) UIColor *emptyColor;      // 空颜色
@property (nonatomic, strong) UIColor *fullColor;       // 满颜色

@end
