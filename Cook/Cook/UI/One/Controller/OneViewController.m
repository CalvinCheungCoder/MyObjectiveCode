//
//  OneViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "OneViewController.h"
#import "CaiPuListCell.h"
#import "CaiPuListModel.h"
#import "OneDetailViewController.h"

@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UILabel *label;

//用来做页面计数
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, assign) BOOL isLoadingMore;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _label = [Factory createLabelWithTitle:@"营养粥谱" frame:CGRectMake(0, 0, 40, 40) textColor:[UIColor whiteColor] fontSize:16.f];
    self.navigationItem.titleView = _label;
    
    _dataArr = [[NSMutableArray alloc]init];
    
    [self setTableView];
    
    [self getNetData];
    
    //将页码设置为第一页
    [self resetParame];
    
    [self createRefreshView];
}

//重置参数
- (void)resetParame {
    //将参数默认改为1，只拿第一页数据
    self.page = 1;
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

-(void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)getNetData{
    
    NSString *url = [NSString stringWithFormat:kCaiPuUrl,@"%E7%B2%A5",self.page];
    [NetWorking requestDataByURL:url Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            NSArray *resultsArr = responseObject[@"results"];
            for (NSDictionary *dict in resultsArr) {
                CaiPuListModel *model = [[CaiPuListModel alloc]init];
                model.ID = [NSString stringWithFormat:@"%@",dict[@"ID"]];
                model.title = [NSString stringWithFormat:@"%@",dict[@"title"]];
                model.thumb = [NSString stringWithFormat:@"%@",dict[@"thumb_2"]];
                
                [_dataArr addObject:model];
            }
            [self refreshView];
            [self.tableView reloadData];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
    
    CaiPuListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[CaiPuListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CaiPuListModel *model = self.dataArr[indexPath.row];
    cell.titleLabel.text = model.title;
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeholder_Phone"] completed:nil];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CaiPuListModel *model = [_dataArr objectAtIndex:indexPath.row];
    OneDetailViewController *detail = [[OneDetailViewController alloc]initWithNumber:model.ID title:model.title thumb:model.thumb];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190;
}


@end
