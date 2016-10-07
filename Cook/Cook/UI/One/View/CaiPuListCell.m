//
//  CaiPuListCell.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "CaiPuListCell.h"

@implementation CaiPuListCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.ImageView = image;
        
        UIView *shadeView = [[UIView alloc] init];
        shadeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self.contentView addSubview:shadeView];
        self.shadeView = shadeView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
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
    
    self.ImageView.frame = CGRectMake(5, 5, self.width - 10, self.height - 10);
    
    self.shadeView.frame = CGRectMake(5, self.height - 35, self.width - 10, 30);
    
    self.titleLabel.frame = CGRectMake(20, self.height - 30, self.width - 40, 25);
}

@end
