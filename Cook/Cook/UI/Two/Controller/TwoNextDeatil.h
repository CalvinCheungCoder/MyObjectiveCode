//
//  TwoNextDeatil.h
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoNextDeatil : BaseViewController

@property (nonatomic,copy) NSString *number2;
@property (nonatomic,copy) NSString *title2;

@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *titleCollect;
@property (nonatomic, copy) NSString *thumbCollect;
@property (nonatomic, copy) NSString *IDCollect;

-(instancetype)initWithNumber:(NSString *)number title:(NSString *)title thumb:(NSString *)thumb;

@end
