//
//  MyWeatherDataTool.h
//  MyWeather
//
//  Created by CalvinCheung on 16/10/12.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWeatherDataTool : NSObject

// 获取天气数据
+ (void)loadWeatherDataCityname:(NSString *)cityname
                        success:(void (^)(NSDictionary *weatherData))success
                        failure:(void (^)(NSError *error))failure;

+ (NSString *)defaultCityname;
+ (NSString *)defaultCityid;

+ (NSArray *)commonCities;
+ (NSArray *)hotCities;
+ (NSArray *)allCities;
+ (NSArray *)allCitiesDics;

+ (NSDictionary *)cachedWeatherDatas;

+ (void)saveCommonCities:(NSArray *)commonCities;
+ (void)saveCachedWeatherDatas:(NSDictionary *)cachedWeatherDatas;

+ (NSString *)cityidOfCityname:(NSString *)cityname;

@end
