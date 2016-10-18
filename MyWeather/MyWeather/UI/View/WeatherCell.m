//
//  WeatherCell.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/10.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "WeatherCell.h"

@implementation WeatherCell

// 在这个方法中添加所有的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.weathImage = image;
        
        UILabel *weatherLabel = [[UILabel alloc] init];
        weatherLabel.textColor = [UIColor blackColor];
        weatherLabel.font = [UIFont systemFontOfSize:16.f];
        weatherLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:weatherLabel];
        self.weatherLabel = weatherLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.font = [UIFont systemFontOfSize:14.f];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *timeLabelTwo = [[UILabel alloc] init];
        timeLabelTwo.textColor = [UIColor grayColor];
        timeLabelTwo.font = [UIFont systemFontOfSize:12.f];
        timeLabelTwo.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:timeLabelTwo];
        self.timeLabelTwo = timeLabelTwo;
        
        UILabel *temLabel = [[UILabel alloc] init];
        temLabel.textColor = [UIColor blackColor];
        temLabel.font = [UIFont systemFontOfSize:12.f];
        temLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:temLabel];
        self.temLabel = temLabel;
    }
    return self;
}

// 设置所有的子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.weathImage.frame = CGRectMake(self.width/2 - 20, 10, 30, 30);
    
    self.weatherLabel.frame = CGRectMake(self.weathImage.right + 5, 8, self.width/2-70, 35);
    
    self.timeLabel.frame = CGRectMake(10, 15, self.width/2 - 30, 20);
    
//    self.timeLabelTwo.frame = CGRectMake(10, 35, self.width/2-30, 20);
    
    self.temLabel.frame = CGRectMake(self.width-80, 10, 70, 30);
}
@end
