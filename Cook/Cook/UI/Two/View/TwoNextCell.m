//
//  TwoNextCell.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "TwoNextCell.h"

@implementation TwoNextCell

/*
 
 @property (nonatomic, strong) UIImageView *image;
 
 @property (nonatomic, strong) UILabel *title;
 
 @property (nonatomic, strong) UILabel *category;
 
 @property (nonatomic, strong) UILabel *age;
 
 @property (nonatomic, strong) UILabel *effect;
 
 */

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.image = image;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:16.f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        self.title = titleLabel;
        
        UILabel *category = [[UILabel alloc] init];
        category.textColor = [UIColor whiteColor];
        category.font = [UIFont systemFontOfSize:14.f];
        category.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:category];
        self.category = category;
        
        UILabel *age = [[UILabel alloc] init];
        age.textColor = [UIColor grayColor];
        age.font = [UIFont systemFontOfSize:12.f];
        age.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:age];
        self.age = age;
        
        UILabel *effect = [[UILabel alloc] init];
        effect.textColor = [UIColor grayColor];
        effect.font = [UIFont systemFontOfSize:12.f];
        effect.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:effect];
        self.effect = effect;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.image.frame = CGRectMake(5, 10, 80, 50);
    
    self.title.frame = CGRectMake(self.image.right + 10, 5, self.width - self.image.right - 20, 20);
    
//    self.category.frame = CGRectMake(self.title.left, self.title.bottom + 5, self.title.width, 15);
    
    self.age.frame = CGRectMake(self.title.left, self.title.bottom + 5, self.title.width, 15);
    
    self.effect.frame = CGRectMake(self.title.left, self.age.bottom + 5, self.title.width, 15);
}


@end
