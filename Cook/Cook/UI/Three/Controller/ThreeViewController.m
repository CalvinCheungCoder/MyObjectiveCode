//
//  ThreeViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "ThreeViewController.h"
#import "ThreeCell.h"
#import "ThreeModel.h"
#import "ThreeDetailViewController.h"

@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *tableView;

//用来做页面计数
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, assign) BOOL isLoadingMore;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [Factory createLabelWithTitle:@"小知识" frame:CGRectMake(0, 0, 40, 40) textColor:[UIColor whiteColor] fontSize:16.f];
    self.navigationItem.titleView = label;
    
    _dataArr = [[NSMutableArray alloc]init];
    [self resetParame];
    [self getNetData];
    [self createView];
    [self createRefreshView];
    
}

#pragma mark - 初始化数据
//重置参数
- (void)resetParame {
    //将参数默认改为1，只拿第一页数据
    self.page = 1;
}

#pragma mark - 获取网络数据
-(void)getNetData{
    
    NSString *url = [NSString stringWithFormat:kKnowledgeUrl,@"%E7%B2%A5",self.page];
    [NetWorking requestDataByURL:url Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *resultsArr = responseObject[@"results"];
        for (NSDictionary *dict in resultsArr) {
            ThreeModel *model = [[ThreeModel alloc]init];
            model.ID = [NSString stringWithFormat:@"%@",dict[@"ID"]];
            model.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
            model.tags = [NSString stringWithFormat:@"%@",dict[@"tags"]];
            
            [_dataArr addObject:model];
        }
        [self refreshView];
        [self.tableView reloadData];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createView{
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view  addSubview:_tableView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellID = @"ZDHKnowledgeCell";
    ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[ThreeCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    ThreeModel *model = _dataArr[indexPath.row];
    cell.detailLabel.text = model.title;
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ThreeModel *model = _dataArr[indexPath.row];
    ThreeDetailViewController *detail = [[ThreeDetailViewController alloc]initWithID:model.ID title:model.title];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

#pragma mark - 刷新
- (void)refreshView {
    if (_isRefresh) {
        _isRefresh = NO;
        [_tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (_isLoadingMore) {
        _isLoadingMore = NO;
        [_tableView footerEndRefreshing];
    }
    //专门刷新列表
    [_tableView reloadData];
}

- (void)createRefreshView {
    //将self改为弱引用
    __weak typeof(self) weakSelf = self;
    //添加头部
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isRefresh = YES;
        //刷新，获取当前的分类的最新数据
        [weakSelf resetParame];
        //调用请求
        [weakSelf getNetData];
    }];
    
    //添加底部
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.isLoadingMore = YES;
        //增加页码
        weakSelf.page ++;
        //获取网络请求
        [weakSelf getNetData];
    }];
}


@end
