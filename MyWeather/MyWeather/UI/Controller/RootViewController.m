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
#import "WeatherLineChart.h"
#import "GYZChooseCityController.h"

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,NavHeadTitleViewDelegate,GYZChooseCityDelegate>

// 定位管理
@property (nonatomic, strong) CLLocationManager *locationManager;
// 顶部View
@property (nonatomic, strong) UIView *BackView;
// 顶部背景
@property (nonatomic, strong) UIView *colorBackgroundView;
// 城市
@property (nonatomic, strong) UILabel *CityLabel;
// 温度
@property (nonatomic, strong) UILabel *temLabel;
// 更新时间
@property (nonatomic, strong) UILabel *UpdateLabel;
// tableView
@property (nonatomic, strong) UITableView *tableView;
// 数据
@property (nonatomic, strong) NSMutableArray *dataArr;
// 生活指数
@property (nonatomic, strong) NSDictionary *suggestionDict;
// 空气质量
@property (nonatomic, strong) NSDictionary *aqiDict;
// headTableView
@property (nonatomic, strong) UIView *headLineView;
// 分栏按钮
@property (nonatomic, strong) UIButton *seleBtn;
// 导航栏
@property (nonatomic, strong) NavHeadTitleView *NavView;
// 城市管理
@property (nonatomic, strong) DatabaseManager *manger;
// 城市名
@property (nonatomic, strong) NSString *cityName;
// 左滑动
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeft;
// 右滑动
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRight;
// 标记
@property (nonatomic, assign) NSInteger tag;
// 小圆点
@property (nonatomic, strong) UIPageControl *pageControl;


@end

@implementation RootViewController

- (UISwipeGestureRecognizer *)swipeLeft {
    
    if (!_swipeLeft) {
        _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(swipeGeneralInfoViewLeft)];
        _swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    return _swipeLeft;
}

- (UISwipeGestureRecognizer *)swipeRight {
    
    if (!_swipeRight) {
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(swipeGeneralInfoViewRight)];
        _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _swipeRight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.BackView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.BackView];
    
    self.manger = [[DatabaseManager alloc]init];

    [self initializeLocationService];
    
    [self setHeadView];
    
    // 创建天气 TableView
    [self createWeathTableView];
    // 获取聚合天气数据
//    [self GetJuHeWeatherData];
    
}

#pragma mark -- 标记
- (void)setIntTag{
    
    _manger = [DatabaseManager manager];
    NSArray *arr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
    UserData *cityData = [[UserData alloc]init];
    for (int i = 0; i < arr.count; i ++) {
        cityData = arr[i];
        NSString *city = [NSString stringWithFormat:@"%@",cityData.city];
        if ([self.cityName isEqualToString:city]) {
            
            self.tag = i;
            [self GetJuHeWeatherData];
        }
    }
}

#pragma mark -- 向左滑动
- (void)swipeGeneralInfoViewLeft{
    
    _manger = [DatabaseManager manager];
    NSArray *arr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
    if (self.tag == arr.count-1) {
        
        return;
        
    }else{
        
        self.tag ++;
        [self GetJuHeWeatherData];
    }
}

#pragma mark -- 向右滑动
- (void)swipeGeneralInfoViewRight{
    
    if (self.tag == 0) {
        
        return;
    }else{
        
        self.tag --;
        [self GetJuHeWeatherData];
    }
}

#pragma mark -- 头视图
- (void)setHeadView{
    
    self.NavView = [[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.NavView.title = @"";
    self.NavView.color = [UIColor whiteColor];
    self.NavView.backTitleImage = @"menu";
    self.NavView.rightTitleImage = @"Plus";
    self.NavView.delegate = self;
    [self.view addSubview:self.NavView];
    [self SetUpUIOne];
}

#pragma mark -- LeftBtn
- (void)NavHeadback{
    
    MenuViewController *menu = [[MenuViewController alloc]init];
    //弱引用转换,为了防止循环引用
//    __weak RootViewController *weakSelf = self;
    
    menu.CityChooseBlock = ^(NSString *city) {
        
        self.cityName = city;
        
        [self setIntTag];
    };
    [self presentViewController:menu animated:YES completion:nil];
}

#pragma mark -- 添加城市
- (void)NavHeadToRight{
    
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}

#pragma mark -- GYZCityPickerDelegate
- (void)cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
    // 插入城市数据
    UserData *data = [[UserData alloc] init];
    data.city = city.cityName;
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
    for (UserData *temp in arr) {
        
        if ([city.cityName isEqualToString:temp.city]) {
            
            self.cityName = city.cityName;
            [self GetJuHeWeatherData];
            
            return;
        }
    }
    
    [self.manger insertCollecInformation:data];
    // 加载数据
    self.cityName = city.cityName;
    [self GetJuHeWeatherData];
    
    [chooseCityController dismissViewControllerAnimated:YES completion:nil];
}

- (void)cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    [chooseCityController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 定位
- (void)initializeLocationService {
    
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init] ;
        self.locationManager.delegate = self;
        // 设置定位精度
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        // 每隔多少米定位一次（这里的设置为每隔千米)
        self.locationManager.distanceFilter = kCLLocationAccuracyKilometer;
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
    
    self.dataArr = [NSMutableArray new];
    
    _manger = [DatabaseManager manager];
    NSArray *arr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
    UserData *cityData = [[UserData alloc]init];
    cityData = arr[self.tag];
    self.pageControl.numberOfPages = arr.count;
    self.pageControl.currentPage = self.tag;
    self.cityName = [NSString stringWithFormat:@"%@",cityData.city];
    NSString *str = [self.cityName substringToIndex:self.cityName.length-1];
    NSDictionary *parm = @{@"apikey":APIKEY,@"city":str};
    [NetWorking requestDataByURL:WorldWeather Parameters:parm success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultDict = responseObject[@"HeWeather data service 3.0"][0];
//        MyLog(@"resultDict == %@",resultDict);
        // 基本信息
        NSDictionary *basic = responseObject[@"HeWeather data service 3.0"][0][@"basic"];
//        MyLog(@"basic == %@",basic);
        self.CityLabel.text = [NSString stringWithFormat:@"%@",basic[@"city"]];
        self.UpdateLabel.text = [NSString stringWithFormat:@"更新时间：%@",basic[@"update"][@"loc"]];
        
        // 实况天气
        NSDictionary *now = responseObject[@"HeWeather data service 3.0"][0][@"now"];
//        MyLog(@"now %@",now);
        self.temLabel.text = [NSString stringWithFormat:@"%@°",now[@"tmp"]];
        
        // 未来 7 天天气
        NSDictionary *weatherDict = responseObject[@"HeWeather data service 3.0"][0][@"daily_forecast"];
        _dataArr = [NSMutableArray new];
        for (NSDictionary *Dict in weatherDict) {
            
            WeatherModel *model = [[WeatherModel alloc]init];
            
            model.textday = [NSString stringWithFormat:@"%@",Dict[@"cond"][@"txt_d"]];
            model.weathImage = [NSString stringWithFormat:@"%@",Dict[@"cond"][@"code_d"]];
            model.high = [NSString stringWithFormat:@"%@",Dict[@"tmp"][@"max"]];
            model.low = [NSString stringWithFormat:@"%@",Dict[@"tmp"][@"min"]];
            
            NSString *dateString = [NSString stringWithFormat:@"%@",Dict[@"date"]];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormatter dateFromString:dateString];
            date = [date dateByAddingTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMT]];
            NetWorking *work = [[NetWorking alloc]init];
            NSString *weekday = [work weekdayFromDate:date];
            model.date = weekday;
            
            [_dataArr addObject:model];
        }
        [self.tableView reloadData];
        
        // 生活指数
        self.suggestionDict = responseObject[@"HeWeather data service 3.0"][0][@"suggestion"];
//        MyLog(@"suggestion == %@",suggestion);
        
        // 空气质量
        self.aqiDict = responseObject[@"HeWeather data service 3.0"][0][@"aqi"];
//        MyLog(@"aqi == %@",aqi);
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -- 获取分时数据
- (void)getSetHourWeather{
    
    self.dataArr = [NSMutableArray new];
    NSString *str = [self.cityName substringToIndex:self.cityName.length-1];
    NSDictionary *parm = @{@"apikey":APIKEY,@"city":str};
    [NetWorking requestDataByURL:WorldWeather Parameters:parm success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 三小时预报
        NSDictionary *hourWeather = responseObject[@"HeWeather data service 3.0"][0][@"hourly_forecast"];
//
//        _dataArr = [NSMutableArray new];
//        for (NSDictionary *Dict in hourWeather) {
//            MyLog(@"dict == %@",Dict);
//            WeatherModel *model = [[WeatherModel alloc]init];
//            
//            model.textday = [NSString stringWithFormat:@"%@",Dict[@"cond"][@"txt_d"]];
//            model.weathImage = [NSString stringWithFormat:@"%@",Dict[@"cond"][@"code_d"]];
//            model.high = [NSString stringWithFormat:@"%@",Dict[@"tmp"][@"max"]];
//            model.low = [NSString stringWithFormat:@"%@",Dict[@"tmp"][@"min"]];
//            
//            NSString *dateString = [NSString stringWithFormat:@"%@",Dict[@"date"]];
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//            NSDate *date = [dateFormatter dateFromString:dateString];
//            date = [date dateByAddingTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMT]];
//            NetWorking *work = [[NetWorking alloc]init];
//            NSString *weekday = [work weekdayFromDate:date];
//            model.date = weekday;
//            
//            [_dataArr addObject:model];
//        }
//        [self.tableView reloadData];
        
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
    // 小圆点
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(40, self.CityLabel.bottom+5, ScreenWidth-80, 10)];
    [self.BackView addSubview:self.pageControl];
    // 温度
    self.temLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-50, self.CityLabel.bottom + 40, 120, 90)];
    self.temLabel.textColor = [UIColor whiteColor];
    self.temLabel.textAlignment = NSTextAlignmentCenter;
    self.temLabel.font = [UIFont systemFontOfSize:72.f];
    [self.BackView addSubview:self.temLabel];
    
    // 查看生活指数
    UIButton *lifeBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, ScreenHeight*0.45 - 50, ScreenWidth/2 - 60, 20)];
    [lifeBtn setTitle:@"查看生活指数" forState:UIControlStateNormal];
    [lifeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lifeBtn addTarget:self action:@selector(lifeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    lifeBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.BackView addSubview:lifeBtn];
    
    // 查看生活指数
    UIButton *airBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2 + 30, ScreenHeight*0.45 - 50, ScreenWidth/2 - 60, 20)];
    [airBtn setTitle:@"查看空气质量" forState:UIControlStateNormal];
    [airBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    airBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [airBtn addTarget:self action:@selector(airBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.BackView addSubview:airBtn];
    
    self.UpdateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, airBtn.bottom + 10, ScreenWidth-20, 18)];
    self.UpdateLabel.textColor = [UIColor whiteColor];
    self.UpdateLabel.textAlignment = NSTextAlignmentRight;
    self.UpdateLabel.font = [UIFont systemFontOfSize:10.f];
    [self.BackView addSubview:self.UpdateLabel];
    
    [self.BackView addGestureRecognizer:self.swipeLeft];
    [self.BackView addGestureRecognizer:self.swipeRight];
}

#pragma mark -- 生活指数
-(void)lifeBtnClick{
    
    LifeIndexViewController *life = [[LifeIndexViewController alloc]init];
    life.data = self.suggestionDict;
    [self presentViewController:life animated:YES completion:nil];
}

#pragma mark -- 空气质量
-(void)airBtnClick{
    
    AirViewController *air = [[AirViewController alloc]init];
    air.data = self.aqiDict;
    [self presentViewController:air animated:YES completion:nil];
}

#pragma mark -- 创建 WeatherTableView
-(void)createWeathTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScreenHeight*0.45, ScreenWidth, ScreenHeight*0.55) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
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
    cell.timeLabel.text = model.date;
    cell.timeLabelTwo.text = model.nongli;
    cell.weatherLabel.text = model.textday;
    cell.weathImage.image = [UIImage imageNamed:model.weathImage];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_headLineView) {
        _headLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        _headLineView.backgroundColor = [UIColor whiteColor];
        
        NSArray *arr = [NSArray arrayWithObjects:@"未来天气",@"分时天气", nil];
        for (int i = 0;i < 2;i ++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*(ScreenWidth/2), 5, ScreenWidth/2, 30);
            btn.tag = i;
            [btn setTitle:arr[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(headBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [_headLineView addSubview:btn];
            if (i == 0)
            {   btn.selected = YES;
                self.seleBtn = btn;
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
            } else {
                btn.selected = NO;
            }
        }
    }
    return _headLineView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark -- BtnClick
- (void)headBtnClick:(UIButton *)Btn{
    
    if (Btn.tag == 0) {
        
        self.seleBtn.selected = NO;
        self.seleBtn = Btn;
        self.seleBtn.selected = YES;
        
    }else{
        
        self.seleBtn.selected = NO;
        self.seleBtn = Btn;
        self.seleBtn.selected = YES;
    }
}

#pragma mark -- CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
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
             // 获取城市
             NSString *currCity = placemark.locality;
             MyLog(@"currCity == %@",currCity);
             self.cityName = currCity;
             
             if (!currCity) {
                 // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 currCity = placemark.administrativeArea;
                 MyLog(@"currCity == %@",currCity);
             }
             
             // 插入城市数据
             UserData *data = [[UserData alloc] init];
             data.city = currCity;
             NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
             for (UserData *temp in arr) {
                 
                 if ([currCity isEqualToString:temp.city]) {
                     
                     // 设置标记
                     [self setIntTag];
                     return ;
                 }
             }
             [self.manger insertCollecInformation:data];
             
             // 设置标记
             [self setIntTag];
             
         }else if (error == nil && [array count] == 0){
             
             MyLog(@"No results were returned.");
             
         }else if (error != nil){
             
             MyLog(@"An error occurred = %@", error);
         }
     }];
}

@end
