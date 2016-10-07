//
//  NetWorking.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

#import "NetWorking.h"

@implementation NetWorking

+ (AFHTTPRequestOperationManager *)initAFHttpManager {
    static AFHTTPRequestOperationManager *manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[AFHTTPRequestOperationManager alloc] init];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        manager.operationQueue.maxConcurrentOperationCount = 1;
    });
    
    return manager;
}

+(void)requestDataByURL:(NSString *)URL Parameters:(NSDictionary *)parameters success:(SuccessBlock)success failBlock:(FailBlock)fail{
    
    AFHTTPRequestOperationManager *manager = [NetWorking initAFHttpManager];
    [manager GET:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(operation,error);
    }];
}

@end
