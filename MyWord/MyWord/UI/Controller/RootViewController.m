//
//  RootViewController.m
//  MyWord
//
//  Created by CalvinCheung on 16/10/16.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "RootViewController.h"
#import "MyWordCell.h"
#import "OneViewController.h"
#import "WordDetailViewController.h"
#import "UITableViewRowAction+JZExtension.h"
#import "WordEditerViewController.h"
#import "SearchViewController.h"

@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DatabaseManager *manger;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"JuneWordNote";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"initData" object:nil];
    
    [self createView];
    
    [self setUpRightBtn];
}

#pragma mark -- 设置右侧按钮
- (void)setUpRightBtn{
    
    UIImage *image = [[UIImage imageNamed:@"ic_plus@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    
    UIImage *leftImage = [[UIImage imageNamed:@"icon_search_h@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnClick)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

-(void)leftBtnClick{
    
    SearchViewController *search = [[SearchViewController alloc]init];
    [self presentViewController:search animated:YES completion:nil];
}

#pragma mark -- 添加单词
-(void)rightBtnClick{
    
    OneViewController *one = [[OneViewController alloc]init];
    [self.navigationController pushViewController:one animated:YES];
}

- (void)initData {
    
    _manger = [DatabaseManager manager];
    _dataArr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
    MyLog(@"%@",_dataArr);
    [self.tableView reloadData];
}

#pragma mark -- 创建TableView
- (void)createView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50;
//    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self initData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self initData];
}

#pragma mark - Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"MyWordCell";
    
    MyWordCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[MyWordCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UserData *data = _dataArr[indexPath.row];
    cell.wordLabel.text = data.word;
    cell.desLabel.text = data.des;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserData *data = _dataArr[indexPath.row];
    WordDetailViewController *detail = [[WordDetailViewController alloc]init];
    detail.data = data;
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:false animated:true];
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    void(^rowActionHandler)(UITableViewRowAction *, NSIndexPath *) = ^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        MyLog(@"action == %@", action.title);
        if ([action.title isEqualToString:@"删除"]) {
            
            UserData *model = _dataArr[indexPath.row];
            [_manger deleteObject:model.word des:model.des];
            [_dataArr removeObject:model];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }else{
            
            UserData *data = _dataArr[indexPath.row];
            WordEditerViewController *editer = [[WordEditerViewController alloc]init];
            editer.data = data;
            [self.navigationController pushViewController:editer animated:YES];
        }
        
        
        [self setEditing:false animated:true];
    };
    
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:rowActionHandler];
    
    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:rowActionHandler];
    
    return @[action2,action3];
}



@end
