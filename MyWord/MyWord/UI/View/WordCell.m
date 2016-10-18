//
//  WordCell.m
//  MyWord
//
//  Created by CalvinCheung on 16/10/17.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "WordCell.h"

@implementation WordCell

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
        
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.wordLabel.frame = CGRectMake(20, 5, self.bounds.size.width - 40, 20);
}

@end
