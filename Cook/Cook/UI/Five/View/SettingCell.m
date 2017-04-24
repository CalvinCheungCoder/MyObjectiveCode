//
//  SettingCell.m
//  Cook
//
//  Created by CalvinCheung on 16/10/8.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.ImageView = image;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = RGB(74, 74, 74);
        titleLabel.font = [UIFont systemFontOfSize:16.f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.ImageView.frame = CGRectMake(10, 15, 25, 25);
    
    self.titleLabel.frame = CGRectMake(45, 15, self.width - 80, 30);
}

@end
