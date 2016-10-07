//
//  ThreeCell.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "ThreeCell.h"

@implementation ThreeCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor colorWithRed:1 green:0.56 blue:0.36 alpha:1];
        [self.contentView addSubview:backView];
        self.backView = backView;
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.textColor = [UIColor blackColor];
        detailLabel.font = [UIFont systemFontOfSize:14.f];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:detailLabel];
        self.detailLabel = detailLabel;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:14.f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backView.frame = CGRectMake(10, 10, 30, 30);
    self.backView.layer.cornerRadius = 15;
    self.backView.layer.masksToBounds = YES;
    
    self.detailLabel.frame = CGRectMake(50, 10, self.width - 90, 30);
    
    self.titleLabel.frame = CGRectMake(10, 10, 30, 30);
}

@end
