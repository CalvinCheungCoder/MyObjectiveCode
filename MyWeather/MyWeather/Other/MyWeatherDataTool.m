//
//  MyWeatherDataTool.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/12.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "MyWeatherDataTool.h"
#import "UIApplication+Extension.h"

@implementation MyWeatherDataTool

#pragma mark - Load weatehr data

+ (void)loadWeatherDataCityname:(NSString *)cityname
                        success:(void (^)(NSDictionary *weatherData))success
                        failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *parm = @{@"key":OpenID,@"cityname":cityname,@"dtype":@"json"};
    [NetWorking requestDataByURL:JuHeWeather Parameters:parm success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultDict = responseObject[@"result"];
        NSDictionary *dataDict = resultDict[@"data"];
        
        success(dataDict);

    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
        
    }];
}


#pragma mark - Get method

+ (NSString *)defaultCityname {
    
    NSArray *commonCities = [self commonCities];
    NSString *cityname;
    if (commonCities.count > 0) {
        cityname = commonCities[0];
    } else {
        cityname = @"北京";
    }
    return cityname;
}

+ (NSString *)defaultCityid {
    
    return [MyWeatherDataTool cityidOfCityname:[self defaultCityname]];
}

+ (NSArray *)commonCities {
    
    NSString *filePath = [[[UIApplication sharedApplication] cachesPath] stringByAppendingPathComponent:@"commonCities.plist"];
    NSArray *commonCities = [NSArray arrayWithContentsOfFile:filePath];
    if (!commonCities) {
        commonCities = @[@"北京", @"上海"];
    }
    return commonCities;
}

+ (NSArray *)hotCities {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hotCities" ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:filePath];
}

+ (NSArray *)allCities {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allCities" ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:filePath];
}

+ (NSArray *)allCitiesDics {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allCitiesDics" ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:filePath];
}

+ (NSDictionary *)cachedWeatherDatas {
    
    NSString *filePath = [[[UIApplication sharedApplication] cachesPath] stringByAppendingPathComponent:@"cachedWeatherDatas.plist"];
    return [NSDictionary dictionaryWithContentsOfFile:filePath];
}

#pragma mark - Save method

+ (void)saveCommonCities:(NSArray *)commonCities {
    
    NSString *filePath = [[[UIApplication sharedApplication] cachesPath] stringByAppendingPathComponent:@"commonCities.plist"];
    [commonCities writeToFile:filePath atomically:YES];
}

+ (void)saveCachedWeatherDatas:(NSDictionary *)cachedWeatherDatas {
    
    NSString *filePath = [[[UIApplication sharedApplication] cachesPath] stringByAppendingPathComponent:@"cachedWeatherDatas.plist"];
    [cachedWeatherDatas writeToFile:filePath atomically:YES];
}

#pragma mark - Tool method

+ (NSString *)cityidOfCityname:(NSString *)cityname {
    
    NSArray *allCitiesDics = [MyWeatherDataTool allCitiesDics];
    for (NSInteger i = 0; i < allCitiesDics.count; i++) {
        NSDictionary *cityDic = allCitiesDics[i];
        if ([cityname isEqualToString:cityDic[@"city"]]) {
            return cityname;
        }
    }
    return nil;
}




@end
