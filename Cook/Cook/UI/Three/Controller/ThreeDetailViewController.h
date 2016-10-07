//
//  ThreeDetailViewController.h
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeDetailViewController : UIViewController

@property (nonatomic,copy) NSString *ID2;
@property (nonatomic,copy) NSString *title2;

- (instancetype)initWithID:(NSString *)ID title:(NSString *)title;

@end
