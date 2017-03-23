//
//  ViewController.m
//  DHSwitch
//
//  Created by 张丁豪 on 2017/3/23.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "ViewController.h"
#import "DHSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DHSwitch *nkColorSwitch1 = [[DHSwitch alloc] initWithFrame:CGRectMake(20, 92, 70, 35)];
    [nkColorSwitch1 addTarget:self action:@selector(switchPressed:) forControlEvents:UIControlEventValueChanged];
    nkColorSwitch1.onBackLabel.text = @"打开";
    nkColorSwitch1.offBackLabel.text = @"关闭";
    nkColorSwitch1.onBackLabel.textColor = [UIColor whiteColor];
    nkColorSwitch1.offBackLabel.textColor = [UIColor blackColor];
    [nkColorSwitch1 setOffTintColor:[UIColor grayColor]];
    [nkColorSwitch1 setOnTintColor:[UIColor colorWithRed:81/255.0 green:183/255.0 blue:241/255.0 alpha:1]];
    [nkColorSwitch1 setThumbTintColor:[UIColor whiteColor]];
    [self.view addSubview:nkColorSwitch1];
}

#pragma mark NKColorSwitch
- (void)switchPressed:(id)sender
{
    DHSwitch *nkswitch = (DHSwitch *)sender;
    if (nkswitch.isOn)
        NSLog(@"switchPressed ON");
    else
        NSLog(@"switchPressed OFF");
}



@end
