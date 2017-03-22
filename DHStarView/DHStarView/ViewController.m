//
//  ViewController.m
//  DHStarView
//
//  Created by 张丁豪 on 2017/3/22.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "ViewController.h"
#import "DHStarView.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DHStarView *star = [[DHStarView alloc]initWithFrame:CGRectMake(20, 100, 200, 20) numberOfStars:5 currentStar:3.2 rateStyle:IncompleteStar isAnination:YES andamptyImageName:@"b27_icon_star_gray" fullImageName:@"b27_icon_star_yellow" finish:^(CGFloat currentStar) {
        
    }];
    [self.view addSubview:star];
}



@end
