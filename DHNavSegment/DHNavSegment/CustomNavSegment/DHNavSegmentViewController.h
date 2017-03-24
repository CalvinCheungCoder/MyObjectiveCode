//
//  DHNavSegmentViewController.h
//  DHNavSegment
//
//  Created by 张丁豪 on 2017/3/24.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHNavSegmentViewController : UIViewController

/** 初始化方法 */
- (instancetype)initWithTitles:(NSArray *)titles ViewControllers:(NSArray *)vcs;

/** 导航标题 */
@property (nonatomic, strong) NSArray *titles;
/** 控制器 */
@property (nonatomic, strong) NSArray *vcs;
/** 导航栏背景颜色 */
@property (nonatomic, strong) UIColor *navBarBgColor;
/** 标题边框颜色 */
@property (nonatomic, strong) UIColor *titleBorderColor;
/** 标题正常颜色 */
@property (nonatomic, strong) UIColor *titleNormalColor;
/** 标题选中颜色 */
@property (nonatomic, strong) UIColor *titleSelectedColor;

@end
