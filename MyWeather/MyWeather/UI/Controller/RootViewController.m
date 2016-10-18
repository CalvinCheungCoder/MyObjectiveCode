//
//  RootViewController.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/10.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "RootViewController.h"
#import "PNChart.h"
#import "WeatherCell.h"
#import "WeatherModel.h"
#import "AirViewController.h"
#import "LifeIndexViewController.h"
#import "MenuViewController.h"
#import "NavHeadTitleView.h"

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,NavHeadTitleViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) UIView *BackView;

@property (nonatomic, strong) UIScrollView *scrollView;
// 顶部背景
@property (nonatomic, strong) UIView *colorBackgroundView;
// 城市
@property (nonatomic, strong) UILabel *CityLabel;
// 温度
@property (nonatomic, strong) UILabel *temLabel;
// 天气
@property (nonatomic, strong) UILabel *weatherLabel;
// 天气图片
@property (nonatomic, strong) UIImageView *weatherImage;
// 湿度
@property (nonatomic, strong) UILabel *humidityLabel;
// 风向
@property (nonatomic, strong) UILabel *directLabel;
// 风力
@property (nonatomic, strong) UILabel *powerLabel;
// 更新时间
@property (nonatomic, strong) UILabel *updateLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSDictionary *dataDict;

@property (nonatomic, strong) NavHeadTitleView *NavView;//导航栏

@property (nonatomic, strong) DatabaseManager *manger;

@property (nonatomic, strong) NSString *cityName;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.BackView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.BackView];
    
    self.manger = [[DatabaseManager alloc]init];

    [self initializeLocationService];
    
    [self setHeadView];
    
    // 创建天气 TableView
//    [self createWeathTableView];
    // 获取聚合天气数据
//    [self GetJuHeWeatherData];
}

#pragma mark -- 头视图
- (void)setHeadView{
    
    self.NavView = [[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.NavView.title = @"";
    self.NavView.color = [UIColor whiteColor];
    self.NavView.backTitleImage = @"Plus";
    self.NavView.rightTitleImage = @"Plus";
    self.NavView.delegate = self;
    [self.view addSubview:self.NavView];
    [self SetUpUIOne];
}

- (void)NavHeadback{
    
    MenuViewController *menu = [[MenuViewController alloc]init];
    //弱引用转换,为了防止循环引用
    __weak RootViewController *weakSelf = self;
    
    menu.CityChooseBlock = ^(NSString *city) {
        
        MyLog(@"blockCity ==%@",city);
        self.cityName = city;
        // 获取聚合天气数据
        [self GetJuHeWeatherData];
    };
    [self presentViewController:menu animated:YES completion:nil];
}
- (void)NavHeadToRight{
    
}

#pragma mark -- 定位
- (void)initializeLocationService {
    
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init] ;
        self.locationManager.delegate = self;
        // 设置定位精度
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        // 每隔多少米定位一次（这里的设置为每隔百米)
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
        // 使用应用程序期间允许访问位置数据
        [self.locationManager requestWhenInUseAuthorization];
        // 开始定位
        [self.locationManager startUpdatingLocation];
    }else {
        // 提示用户无法进行定位操作
        MyLog(@"%@",@"定位服务当前可能尚未打开，请设置打开！");
    }
}

#pragma mark -- 获取聚合天气数据
-(void)GetJuHeWeatherData{
    
    self.dataArr = [[NSMutableArray alloc]init];
    NSDictionary *parm = @{@"key":OpenID,@"cityname":self.cityName,@"dtype":@"json"};
    [NetWorking requestDataByURL:JuHeWeather Parameters:parm success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultDict = responseObject[@"result"];
        _dataDict = resultDict[@"data"];
        // 实时天气
        NSDictionary *realtimeDict = _dataDict[@"realtime"];
        NSDictionary *weatherDic = realtimeDict[@"weather"];

        self.CityLabel.text = [NSString stringWithFormat:@"%@",realtimeDict[@"city_name"]];
        self.temLabel.text = [NSString stringWithFormat:@"%@°",weatherDic[@"temperature"]];;
        self.humidityLabel.text = [NSString stringWithFormat:@"相对湿度:%@",weatherDic[@"humidity"]];
        self.weatherLabel.text = [NSString stringWithFormat:@"%@",weatherDic[@"info"]];
        
        NSDictionary *windDic = realtimeDict[@"wind"];
        self.directLabel.text = [NSString stringWithFormat:@"%@",windDic[@"direct"]];
        self.powerLabel.text = [NSString stringWithFormat:@"%@",windDic[@"power"]];
        
        // 未来 5 天天气
        NSDictionary *weatherDict = _dataDict[@"weather"];
        for (NSDictionary *dict in weatherDict) {
            
            WeatherModel *model = [[WeatherModel alloc]init];
            model.date = [NSString stringWithFormat:@"%@",dict[@"date"]];
            model.week = [NSString stringWithFormat:@"周%@",dict[@"week"]];
            model.nongli = [NSString stringWithFormat:@"%@",dict[@"nongli"]];
            
            NSDictionary *infoDict = dict[@"info"];
            NSArray *dayArr = infoDict[@"day"];
            model.textnight = dayArr[1];
            model.winddirection = dayArr[3];
            model.windscale = dayArr[4];
            model.high = dayArr[2];

            NSArray *nightArr = infoDict[@"night"];
            model.textnight = nightArr[1];
            model.winddirection = nightArr[3];
            model.windscale = nightArr[4];
            model.low = nightArr[2];
            
            [self.dataArr addObject:model];
        }
//        [self.tableView reloadData];
        [self createWeathTableView];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -- 创建顶部视图
-(void)SetUpUIOne{
    
    // 背景
    CAGradientLayer *topView = [CAGradientLayer layer];
    topView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight * 0.45);
    topView.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.29 green:0.47 blue:0.82 alpha:1] CGColor], (id)[[UIColor colorWithRed:0.67 green:0.65 blue:0.87 alpha:1] CGColor], nil , nil ];
    [self.BackView.layer insertSublayer:topView atIndex:0];
    
    // 城市
    self.CityLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 25, ScreenWidth - 120, 30)];
    self.CityLabel.textColor = [UIColor whiteColor];
    self.CityLabel.textAlignment = NSTextAlignmentCenter;
    self.CityLabel.font = [UIFont systemFontOfSize:20.f];
    [self.BackView addSubview:self.CityLabel];
    // 温度
    self.temLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-60, self.CityLabel.bottom + 40, 120, 90)];
    self.temLabel.textColor = [UIColor whiteColor];
    self.temLabel.textAlignment = NSTextAlignmentCenter;
    self.temLabel.font = [UIFont systemFontOfSize:78.f];
    [self.BackView addSubview:self.temLabel];
    
    
    // 查看生活指数
    UIButton *lifeBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, ScreenHeight*0.45 - 30, ScreenWidth/2 - 60, 20)];
    [lifeBtn setTitle:@"查看生活指数" forState:UIControlStateNormal];
    [lifeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lifeBtn addTarget:self action:@selector(lifeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    lifeBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [self.BackView addSubview:lifeBtn];
    
    // 查看生活指数
    UIButton *airBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2 + 30, ScreenHeight*0.45 - 30, ScreenWidth/2 - 60, 20)];
    [airBtn setTitle:@"查看空气质量" forState:UIControlStateNormal];
    [airBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    airBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [airBtn addTarget:self action:@selector(airBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.BackView addSubview:airBtn];
}

-(void)RightBtnClicked{
    
}

// 生活指数
-(void)lifeBtnClick{
    
    LifeIndexViewController *life = [[LifeIndexViewController alloc]init];
    life.data = self.dataDict;
    [self presentViewController:life animated:YES completion:nil];
}

// 空气质量
-(void)airBtnClick{
    
    AirViewController *air = [[AirViewController alloc]init];
    air.data = self.dataDict;
    [self presentViewController:air animated:YES completion:nil];
}

#pragma mark -- 创建 WeatherTableView
-(void)createWeathTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScreenHeight*0.45, ScreenWidth, ScreenHeight*0.55) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.BackView addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"Cell";
    
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[WeatherCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WeatherModel *model = self.dataArr[indexPath.row];
    cell.temLabel.text = [NSString stringWithFormat:@"%@°~%@°",model.low,model.high];
    cell.timeLabel.text = model.week;
    cell.weatherLabel.text = model.textnight;
    cell.weathImage.image = [UIImage imageNamed:@"100"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}


#pragma mark -- CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    // 系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [self.locationManager stopUpdatingLocation];
    // 此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count >0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //Users/Calvin/Desktop/App资源/喜马拉雅FM 5.4.33/Payload/ting.app/zone_deletepic@3x.png/ 获取城市
             NSString *currCity = placemark.locality;
             MyLog(@"currCity == %@",currCity);
//             self.CityLabel.text = currCity;
             self.cityName = currCity;
             
//             [self createWeathTableView];
             // 获取聚合天气数据
             [self GetJuHeWeatherData];
             
             // 插入城市数据
             UserData *data = [[UserData alloc] init];
             data.city = currCity;
             NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
             for (UserData *temp in arr) {
                 
                 if ([currCity isEqualToString:temp.city]) {
                     
                     return;
                 }
             }
             [self.manger insertCollecInformation:data];
             
             if (!currCity) {
                 // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 currCity = placemark.administrativeArea;
                 MyLog(@"currCity == %@",currCity);
                 
             }
         }else if (error ==nil && [array count] == 0){
             
             MyLog(@"No results were returned.");
             
         }else if (error !=nil){
             
             MyLog(@"An error occurred = %@", error);
         }
     }];
}

@end
