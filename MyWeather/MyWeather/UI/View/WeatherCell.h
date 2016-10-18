//
//  WeatherCell.h
//  MyWeather
//
//  Created by CalvinCheung on 16/10/10.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UITableViewCell

// 天气图片
@property (nonatomic, strong) UIImageView *weathImage;
// 温度
@property (nonatomic, strong) UILabel *temLabel;
// 时间
@property (nonatomic, strong) UILabel *timeLabel;
// 天气
@property (nonatomic, strong) UILabel *weatherLabel;

@end
