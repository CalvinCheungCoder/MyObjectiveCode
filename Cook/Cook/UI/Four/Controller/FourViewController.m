//
//  FourViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/8.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "FourViewController.h"
#import "DatabaseManager.h"
#import "UserData.h"
#import "CaiPuListCell.h"
#import "OneDetailViewController.h"

@interface FourViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DatabaseManager *manger;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UIImageView *image;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [Factory createLabelWithTitle:@"收藏" frame:CGRectMake(0, 0, 40, 40) textColor:[UIColor whiteColor] fontSize:18.f];
    self.navigationItem.titleView = label;
    
    [self createView];
}

- (void)addTouchAction {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"initData" object:nil];
}

- (void)initData {
    
    _manger = [DatabaseManager manager];
    _dataArr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
    if (_dataArr.count == 0) {
        
        self.image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tishi.jpg"]];
        self.image.frame = CGRectMake(10, 70, ScreenWidth - 20, (ScreenWidth - 20)*0.65);
        [self.view addSubview:self.image];
        
    }else{
        
        [self.tableView reloadData];
    }
}

- (void)createView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 190;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"SpecialCell";
    
    CaiPuListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[CaiPuListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UserData *data = _dataArr[indexPath.row];
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:data.thumb] placeholderImage:[UIImage imageNamed:@"placeholder_Phone"] completed:nil];
    cell.titleLabel.text = data.title;
    
    return cell;
}


// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserData *model =_dataArr[indexPath.row];
    OneDetailViewController *detail = [[OneDetailViewController alloc] initWithNumber:model.idcollect title:model.title thumb:model.thumb];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

// editing Delete
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UserData *model = _dataArr[indexPath.row];
        [_manger deleteObject:model.title];
        [_dataArr removeObject:model];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self initData];
}


@end
