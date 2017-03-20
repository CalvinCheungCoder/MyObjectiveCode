//
//  OneTableViewCell.m
//  DHFoldTableView
//
//  Created by 张丁豪 on 2017/2/27.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "OneTableViewCell.h"

#define Width [UIScreen mainScreen].bounds.size.width

@implementation OneTableViewCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    
    UILabel *OneLabel = [[UILabel alloc] init];
    OneLabel.textColor = [UIColor blackColor];
    OneLabel.font = [UIFont systemFontOfSize:14];
    OneLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:OneLabel];
    self.OneLabel = OneLabel;
    
    UILabel *TwoLabel = [[UILabel alloc] init];
    TwoLabel.textColor = [UIColor blackColor];
    TwoLabel.font = [UIFont systemFontOfSize:14];
    TwoLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:TwoLabel];
    self.TwoLabel = TwoLabel;
    
    UILabel *ThreeLabel = [[UILabel alloc] init];
    ThreeLabel.textColor = [UIColor blackColor];
    ThreeLabel.font = [UIFont systemFontOfSize:14];
    ThreeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:ThreeLabel];
    self.ThreeLabel = ThreeLabel;
    
    UILabel *FourLabel = [[UILabel alloc] init];
    FourLabel.textColor = [UIColor blackColor];
    FourLabel.font = [UIFont systemFontOfSize:14];
    FourLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:FourLabel];
    self.FourLabel = FourLabel;
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.OneLabel.frame = CGRectMake(0, 0, Width*0.25, 50);
    self.TwoLabel.frame = CGRectMake(Width*0.25, 0, Width*0.25, 50);
    self.ThreeLabel.frame = CGRectMake(Width*0.5, 0, Width*0.25, 50);
    self.FourLabel.frame = CGRectMake(Width*0.75, 0, Width*0.25, 50);
}

@end
