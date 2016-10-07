//
//  TwoNextDeatil.h
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoNextDeatil : UIViewController

@property (nonatomic,copy) NSString *number2;
@property (nonatomic,copy) NSString *title2;

-(instancetype)initWithNumber:(NSString *)number title:(NSString *)title;

@end
