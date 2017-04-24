//
//  DHCollectionViewCell.h
//  DHPageControl
//
//  Created by 张丁豪 on 2017/3/31.
//  Copyright © 2017年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSString *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;

@property (nonatomic, assign) BOOL hasConfigured;


@end
