//
//  DHNavDropdownMenu.h
//  NavDropdownMenu
//
//  Created by 张丁豪 on 2017/3/20.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHNavDropdownMenu;

@protocol DHNavDropdownMenuDataSource <NSObject>

@required

- (NSArray<NSString *> *)titleArrayForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;

@optional

- (UIFont *)titleFontForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is [UIFont systemFontOfSize:17.0]
- (UIColor *)titleColorForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is [UIColor blackColor]
- (UIImage *)arrowImageForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is nil
- (CGFloat)arrowPaddingForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is 0.0
- (NSTimeInterval)animationDurationForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is 0.25
- (BOOL)keepCellSelectionForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is YES
- (CGFloat)cellHeightForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is 45.0
- (UIEdgeInsets)cellSeparatorInsetsForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
- (NSTextAlignment)cellTextAlignmentForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is NSTextAlignmentCenter
- (UIFont *)cellTextFontForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is [UIFont systemFontOfSize:16.0]
- (UIColor *)cellTextColorForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is [UIColor blackColor]
- (UIColor *)cellBackgroundColorForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is [UIColor whiteColor]
- (UIColor *)cellSelectionColorForNavigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu;// Default is nil

@end

@protocol DHNavDropdownMenuDelegate <NSObject>

@required

- (void)navigationDropdownMenu:(DHNavDropdownMenu *)navigationDropdownMenu didSelectTitleAtIndex:(NSUInteger)index;

@end

@interface DHNavDropdownMenu : UIButton

@property (nonatomic, weak) id <DHNavDropdownMenuDataSource> dataSource;
@property (nonatomic, weak) id <DHNavDropdownMenuDelegate> delegate;

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

- (void)show;
- (void)hide;

@end
