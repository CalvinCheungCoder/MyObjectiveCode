//
//  OtherViewController.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/11.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark -- 获取三日天气
//-(void)GetWeatherOne{
//    
//    self.dataArr = [[NSMutableArray alloc]init];
//    
//    NSDictionary *WeatherDict = @{@"location":@"shanghai",
//                                  @"language":@"zh-Hans",
//                                  @"unit":@"c",
//                                  @"start":@"0",
//                                  @"days":@"3"};
//    
//    [NetWorking requestDataByURL:Weather Parameters:WeatherDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary *resultsDict = responseObject[@"results"];
//        
//        for (NSDictionary *dict in resultsDict) {
//            NSDictionary *dailyDict = dict[@"daily"];
//            for (NSDictionary *dict in dailyDict) {
//                WeatherModel *model = [[WeatherModel alloc]init];
//                model.date = [NSString stringWithFormat:@"%@",dict[@"date"]];
//                model.high = [NSString stringWithFormat:@"%@",dict[@"high"]];
//                model.low = [NSString stringWithFormat:@"%@",dict[@"low"]];
//                model.precip = [NSString stringWithFormat:@"%@",dict[@"precip"]];
//                model.textday = [NSString stringWithFormat:@"%@",dict[@"text_day"]];
//                model.textnight = [NSString stringWithFormat:@"%@",dict[@"text_night"]];
//                model.winddirection = [NSString stringWithFormat:@"%@",dict[@"wind_direction"]];
//                model.winddirectiondegree = [NSString stringWithFormat:@"%@",dict[@"wind_direction_degree"]];
//                model.windscale = [NSString stringWithFormat:@"%@",dict[@"wind_scale"]];
//                model.windspeed = [NSString stringWithFormat:@"%@",dict[@"wind_speed"]];
//                
//                [self.dataArr addObject:model];
//            }
//            [self.tableView reloadData];
//        }
//        
//    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//}
//
//#pragma mark -- 获取当日天气
//-(void)GetWeatherTwo{
//    
//    NSDictionary *WeatherDictTwo = @{@"location":@"上海市",
//                                     @"language":@"zh-Hans",
//                                     @"unit":@"c"};
//    
//    [NetWorking requestDataByURL:WeatherTwo Parameters:WeatherDictTwo success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        NSDictionary *resultsDict = responseObject[@"results"];
//        //        MyLog(@"resultsDict == %@",resultsDict);
//        
//        for (NSDictionary *dict in resultsDict) {
//            NSDictionary *locationDict = dict[@"location"];
//            self.CityLabel.text = locationDict[@"name"];
//            
//            NSDictionary *nowDict = dict[@"now"];
//            self.temLabel.text = [NSString stringWithFormat:@"%@%@",nowDict[@"temperature"],@"°"];
//            self.weatherLabel.text = nowDict[@"text"];
//        }
//        NSLog(@"resultsDict == %@",resultsDict);
//        
//    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//}
//
//#pragma mark -- 获取穿衣数据
//-(void)GetLife{
//    
//    NSDictionary *LifeDict = @{@"location":@"shanghai",
//                               @"language":@"zh-Hans"};
//    
//    [NetWorking requestDataByURL:LifeIndex Parameters:LifeDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //        NSLog(@"LifeIndex == %@",responseObject);
//        
//    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//}

@end
