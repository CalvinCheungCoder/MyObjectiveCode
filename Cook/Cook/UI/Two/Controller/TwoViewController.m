//
//  TwoViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "TwoViewController.h"
#import "TwoCell.h"
#import "TwoModel.h"
#import "TwoNextViewController.h"

@interface TwoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSMutableArray *dataArr;

@property (nonatomic,copy) UITableView *tableView;

//用来做页面计数
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL isRefresh;

//是加载更多
@property (nonatomic, assign) BOOL isLoadingMore;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"热门专题";
    _dataArr = [[NSMutableArray alloc]init];
    
    [self createView];
    [self getNetData];
    [self createRefreshView];
    [self resetParame];
}

#pragma mark - 初始化数据
//重置参数
- (void)resetParame {
    //将参数默认改为1，只拿第一页数据
    self.page = 1;
}

-(void)getNetData{

    NSString *url = [NSString stringWithFormat:kZhuanTiUrl,self.page];
    [NetWorking requestDataByURL:url Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *resultsArr = responseObject[@"results"];
        for (NSDictionary *dict in resultsArr) {
            TwoModel *model = [[TwoModel alloc]init];
            model.ID = [NSString stringWithFormat:@"%@",dict[@"ID"]];
            model.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
            model.thumb = [NSString stringWithFormat:@"%@",dict[@"thumb"]];
            model.views = [NSString stringWithFormat:@"%@",dict[@"views"]];
            model.likes = [NSString stringWithFormat:@"%@",dict[@"likes"]];
            
            [_dataArr addObject:model];
        }
        [self refreshView];
        [self.tableView reloadData];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
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
    
    static NSString *cellId = @"Cell";
    
    TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[TwoCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    TwoModel *model = self.dataArr[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.detailLabel.text = [NSString stringWithFormat:@"%@次浏览  %@次赞",model.views,model.likes];
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeholder_Phone"] completed:nil];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TwoModel *model = _dataArr[indexPath.row];
    TwoNextViewController *detail = [[TwoNextViewController alloc]initWithID:model.ID];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ScreenWidth/2;
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
