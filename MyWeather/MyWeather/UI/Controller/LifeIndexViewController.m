//
//  LifeIndexViewController.m
//  MyWeather
//
//  Created by CalvinCheung on 16/10/14.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "LifeIndexViewController.h"
#import "LifeIndexCell.h"
#import "LifeModel.h"

@interface LifeIndexViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation LifeIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(74, 119, 210);
    
    [self setUpCloseBtn];
    [self setUpTableView];
    [self setData];
}

- (void)setUpCloseBtn{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 25, ScreenWidth-120, 30)];
    label.text = @"生活指数";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:label];
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 20, 20)];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(CloseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}

- (void)CloseBtnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)setData{
    
    MyLog(@"%@",self.data);
    self.dataArr = [NSMutableArray new];
    NSArray *arr = [NSArray arrayWithObjects:@"drsg",@"flu",@"sport",@"comf",@"trav",@"cw",@"uv", nil];
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dict = self.data[arr[i]];
        LifeModel *model = [[LifeModel alloc]init];
        model.brf = [NSString stringWithFormat:@"%@",dict[@"brf"]];
        model.txt = [NSString stringWithFormat:@"%@",dict[@"txt"]];
        
        [self.dataArr addObject:model];
    }
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"Cell";
    
    LifeIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[LifeIndexCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    LifeModel *model = self.dataArr[indexPath.row];
    cell.titleLabel.text = model.brf;
    cell.desLabel.text = model.txt;
    return cell;
}

@end
