//
//  TwoCell.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "TwoCell.h"

@implementation TwoCell

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
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.textColor = [UIColor grayColor];
        detailLabel.font = [UIFont systemFontOfSize:12.f];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:detailLabel];
        self.detailLabel = detailLabel;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.ImageView.frame = CGRectMake(5, 5, self.width - 10, self.height - 30);
    
    self.shadeView.frame = CGRectMake(5, self.height - 50, self.width - 10, 25);
    
    self.titleLabel.frame = CGRectMake(20, self.height - 50, self.width - 40, 25);
    
    self.detailLabel.frame = CGRectMake(10, self.height - 23, self.width - 20, 20);
}


@end
