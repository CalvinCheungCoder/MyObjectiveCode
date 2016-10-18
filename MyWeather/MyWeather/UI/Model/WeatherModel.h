//
//  WeatherModel.h
//  MyWeather
//
//  Created by CalvinCheung on 16/10/10.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property (nonatomic,copy) NSString *weathImage;

@property (nonatomic,copy) NSString *temLabel;

@property (nonatomic,copy) NSString *timeLabel;

@property (nonatomic,copy) NSString *weatherLabel;
// 日期
@property (nonatomic,copy) NSString *date;
// 农历
@property (nonatomic,copy) NSString *nongli;
// 周
@property (nonatomic,copy) NSString *week;
// 白天天气现象
@property (nonatomic,copy) NSString *textday;
// 晚间天气现象
@property (nonatomic,copy) NSString *textnight;
// 当天最高温度
@property (nonatomic,copy) NSString *high;
// 当天最低温度
@property (nonatomic,copy) NSString *low;
// 降水概率，范围0~100，单位百分比
@property (nonatomic,copy) NSString *precip;
// 风向
@property (nonatomic,copy) NSString *winddirection;
// 风向角度，范围0~360
@property (nonatomic,copy) NSString *winddirectiondegree;
// 风速，单位km/h（当unit=c时）、mph（当unit=f时）
@property (nonatomic,copy) NSString *windspeed;
// 风力等级
@property (nonatomic,copy) NSString *windscale;

/*
 
 "date": "2015-09-20",             //日期
 "text_day": "多云",               //白天天气现象文字
 "code_day": "4",                  //白天天气现象代码
 "text_night": "晴",               //晚间天气现象文字
 "code_night": "0",                //晚间天气现象代码
 "high": "26",                     //当天最高温度
 "low": "17",                      //当天最低温度
 "precip": "0",                    //降水概率，范围0~100，单位百分比
 "wind_direction": "",             //风向文字
 "wind_direction_degree": "255",   //风向角度，范围0~360
 "wind_speed": "9.66",             //风速，单位km/h（当unit=c时）、mph（当unit=f时）
 "wind_scale": ""                  //风力等级
 
 */

@end
