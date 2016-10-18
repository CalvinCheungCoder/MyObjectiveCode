//
//  MenuViewController.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/18.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "MenuViewController.h"
#import "GYZChooseCityController.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource,GYZChooseCityDelegate>

@property (nonatomic, strong) DatabaseManager *manger;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(74, 119, 210);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"initData" object:nil];
    
    [self createTopUI];
    [self createTableView];
}

#pragma mark -- 创建顶部菜单栏
-(void)createTopUI{
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 20, 20)];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(CloseThiePage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 25, ScreenWidth - 160, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"城市管理";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:label];
    
    UIButton *AddBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 40, 30, 20, 20)];
    [AddBtn setBackgroundImage:[UIImage imageNamed:@"Plus.png"] forState:UIControlStateNormal];
    [AddBtn addTarget:self action:@selector(AddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:AddBtn];
}

#pragma mark -- 添加城市
-(void)AddBtnClick{
    
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
//    cityPickerVC.ChooseCity = self;
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
            
            return;
        }
    }
    [self.manger insertCollecInformation:data];
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    [chooseCityController dismissViewControllerAnimated:YES completion:nil];
}


- (void)initData {
    
    _manger = [DatabaseManager manager];
    _dataArr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
    MyLog(@"_dataArr == %@",_dataArr);
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self initData];
}

#pragma mark -- 关闭页面
-(void)CloseThiePage{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 创建tableView
- (void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UserData *data = _dataArr[indexPath.row];
    cell.textLabel.text = data.city;
    
    return cell;
}

// editing Delete
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UserData *model = _dataArr[indexPath.row];
        [_manger deleteObject:model.city];
        [_dataArr removeObject:model];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //判断block是否为空
    UserData *model = _dataArr[indexPath.row];
    if (self.CityChooseBlock) {
        self.CityChooseBlock(model.city);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
