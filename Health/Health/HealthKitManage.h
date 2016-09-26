//
//  HealthKitManage.h
//  Health
//
//  Created by CalvinCheung on 16/9/26.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import <UIKit/UIDevice.h>


#define HKVersion [[[UIDevice currentDevice] systemVersion] doubleValue]
#define CustomHealthErrorDomain @"com.sdqt.healthError"

@interface HealthKitManage : NSObject

@property (nonatomic, strong) HKHealthStore *healthStore;

+(id)shareInstance;

- (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))compltion;

- (void)getStepCount:(void(^)(double value, NSError *error))completion;

- (void)getDistance:(void(^)(double value, NSError *error))completion;

@end
