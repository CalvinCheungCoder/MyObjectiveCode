//
//  TwoNextViewController.m
//  Cook
//
//  Created by CalvinCheung on 16/10/7.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "TwoNextViewController.h"
#import "TwoNextCell.h"
#import "TwoNextModel.h"
#import "TwoNextDeatil.h"

@interface TwoNextViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,copy) UITableView *tableView;


@end

@implementation TwoNextViewController

-(instancetype)initWithID:(NSString *)ID{
    if (self) {
        self.ID2 = [ID copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [Factory createLabelWithTitle:@"列表" frame:CGRectMake(0, 0, 40, 40) textColor:[UIColor whiteColor] fontSize:16.f];
    self.navigationItem.titleView = label;
    
    [self createView];
    
    [self getNetData];
    
}

-(void)createView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)getNetData{
    
    _dataArr = [[NSMutableArray alloc]init];
    NSString *url = [NSString stringWithFormat:kZhuanTiMenu,self.ID2];
    [NetWorking requestDataByURL:url Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *tempArr = responseObject[@"tlist"];
        for (NSDictionary *dict2 in tempArr) {
            NSArray *arr2 = dict2[@"list"];
            for (NSDictionary *dict3 in arr2) {
                TwoNextModel *model1 = [[TwoNextModel alloc]init];
                model1.title = dict3[@"title"];
                model1.category = dict3[@"category"];
                model1.age = dict3[@"age"];
                model1.effect = dict3[@"effect"];
                model1.thumb = dict3[@"thumb"];
                model1.ID = dict3[@"ID"];
                
                [_dataArr addObject:model1];
            }
        }
        [self.tableView reloadData];
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource * UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ZDHZhuanTiMenuCell";
    
    TwoNextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TwoNextCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    TwoNextModel *model = _dataArr[indexPath.row];
    NSInteger x = model.title.length;
    NSInteger y = model.category.length;
    NSMutableAttributedString *titieStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@",model.title,model.category]];
    [titieStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.f] range:NSMakeRange(0, x)];
    [titieStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.29 green:0.45 blue:0.09 alpha:1] range:NSMakeRange(0, x)];
    
    [titieStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.f] range:NSMakeRange(x+2, y)];
    [titieStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(x+2, y)];
    
    cell.title.attributedText = titieStr;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    cell.age.text = model.age;
    cell.effect.text = model.effect;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TwoNextModel *model = _dataArr[indexPath.row];
    TwoNextDeatil *detail = [[TwoNextDeatil alloc]initWithNumber:model.ID title:model.title thumb:model.thumb];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
