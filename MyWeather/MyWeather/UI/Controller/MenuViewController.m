//
//  MenuViewController.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/18.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>

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
}


#pragma mark -- 加载数据
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
    
    // 判断block是否为空
    UserData *model = _dataArr[indexPath.row];
    if (self.CityChooseBlock) {
        self.CityChooseBlock(model.city);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
