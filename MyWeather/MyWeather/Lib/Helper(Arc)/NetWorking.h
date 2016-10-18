//
//  NetWorking.h
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetWorking : NSObject

// 请求成功之后回调的 Block
typedef void(^SuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);

// 请求失败之后回调的 Block
typedef void(^FailBlock) (AFHTTPRequestOperation *operation, NSError *error);

// 封装Get请求方法
+ (void)requestDataByURL:(NSString *)URL Parameters:(NSDictionary *)parameters success:(SuccessBlock)success failBlock:(FailBlock)fail;

- (NSString *)weekdayFromDate:(NSDate *)date;

@end
