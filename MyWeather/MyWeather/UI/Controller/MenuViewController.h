//
//  MenuViewController.h
//  MyWeather
//
//  Created by CalvinCheung on 16/10/18.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

//定义block
@property (nonatomic,copy) void (^CityChooseBlock)(NSString *City);

@end