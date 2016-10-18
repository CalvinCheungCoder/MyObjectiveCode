//
//  LifeIndexViewController.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/14.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "LifeIndexViewController.h"

@interface LifeIndexViewController ()

@end

@implementation LifeIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    NSDictionary *lifeDict = self.data[@"life"];
    
    NSDictionary *infoDict = lifeDict[@"info"];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:infoDict[@"yundong"],
                            infoDict[@"xiche"],
                            infoDict[@"ganmao"],
                            infoDict[@"ziwaixian"],
                            infoDict[@"chuanyi"],
                            infoDict[@"kongtiao"], nil];
    
    for (int i = 0; i < arr.count; i ++) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, 40 + 90 * i, ScreenWidth - 20, 85);
        label.font = [UIFont systemFontOfSize:12.f];
        label.tag = i;
        label.textColor = [UIColor whiteColor];
        NSString *str = [NSString stringWithFormat:@"%@",arr[i]];
        label.text = [str substringWithRange:NSMakeRange(1, str.length-2)];
        label.numberOfLines = 0;
        [self.view addSubview:label];
    }
    
    [self setUpCloseBtn];
}

- (void)setUpCloseBtn{
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-30, ScreenHeight - 60, 60, 30)];
    [closeBtn setBackgroundColor:[UIColor orangeColor]];
    closeBtn.layer.cornerRadius = 5;
    [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(CloseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}

- (void)CloseBtnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
