//
//  MyWordCell.m
//  MyWord
//
//  Created by CalvinCheung on 16/10/16.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "MyWordCell.h"

@implementation MyWordCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *wordLabel = [[UILabel alloc] init];
        wordLabel.textColor = [UIColor blackColor];
        wordLabel.font = [UIFont systemFontOfSize:16.f];
        wordLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:wordLabel];
        self.wordLabel = wordLabel;
        
        UILabel *desLabel = [[UILabel alloc] init];
        desLabel.textColor = [UIColor grayColor];
        desLabel.font = [UIFont systemFontOfSize:14.f];
        desLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:desLabel];
        self.desLabel = desLabel;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.wordLabel.frame = CGRectMake(20, 5, self.bounds.size.width - 40, 20);
    
    self.desLabel.frame = CGRectMake(20, 25, self.bounds.size.width - 40, 20);
}


@end
