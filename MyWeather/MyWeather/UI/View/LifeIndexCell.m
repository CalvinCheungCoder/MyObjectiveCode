//
//  LifeIndexCell.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/19.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "LifeIndexCell.h"

@implementation LifeIndexCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.iconImage = image;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:14.f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *desLabel = [[UILabel alloc] init];
        desLabel.textColor = [UIColor blackColor];
        desLabel.font = [UIFont systemFontOfSize:12.f];
        desLabel.textAlignment = NSTextAlignmentLeft;
        desLabel.numberOfLines = 2;
        [self.contentView addSubview:desLabel];
        self.desLabel = desLabel;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImage.frame = CGRectMake(10, 10, 30, 30);

    self.titleLabel.frame = CGRectMake(50, 10, self.width - 70, 20);
    
    self.desLabel.frame = CGRectMake(50, self.titleLabel.bottom, self.titleLabel.width, 40);
}


@end
