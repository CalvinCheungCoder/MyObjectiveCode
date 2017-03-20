//
//  ViewController.m
//  DHFoldTableView
//
//  Created by 张丁豪 on 2017/2/24.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "ViewController.h"
#import "MySection.h"
#import "OneTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSIndexPath *selectedIndexPath;
@property (nonatomic) NSMutableArray *sections;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.sections = [[NSMutableArray alloc]init];
    [self initData];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置每组之间的距离为0
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 0;
    
    [self.view addSubview:self.tableView];
    
}

//初始化数据
- (void)initData
{
    for (int i = 0; i < 6; i++) {
        MySection *section = [[MySection alloc]init];
        section.name = [NSString stringWithFormat:@"分组%i",i + 1];
        [self.sections addObject:section];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MySection *theSection = self.sections[section];
    //根据分组开关状态和数据源动态改变每组row的个数
    if (theSection.isOpen) {
        return [theSection.dataArray count];
    }else{
        return 1;
    }
}

//分组数目
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //从数据源数组中取出当前cell对应的对象
    MySection *section = self.sections[indexPath.section];
    //如果row为0，则为标题
    if (indexPath.row == 0) {
        
        OneTableViewCell *cellOne = [[OneTableViewCell alloc]init];
        cellOne.OneLabel.text = section.name;
        cellOne.TwoLabel.text = section.name;
        cellOne.ThreeLabel.text = section.name;
        cellOne.FourLabel.text = section.name;
        
        return cellOne;
        
    }else{
        
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        //为每组中cell赋值
        cell.textLabel.text = section.dataArray[indexPath.row - 1];
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySection *section = self.sections[indexPath.section];
    //选中标题cell，且对应的组没有打开
    if (!section.isOpen) {
        NSLog(@"section：%@ open!",section.name);
        section.isOpen = YES;
        
        NSMutableArray *a = [[NSMutableArray alloc]init];
        
        for (int i = 1; i < [section.dataArray count]; i++) {
            NSIndexPath *addIndexPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [a addObject:addIndexPath];
        }
        
        [self.tableView beginUpdates];
        
        [self.tableView insertRowsAtIndexPaths:a withRowAnimation:UITableViewRowAnimationNone];
        
        [self.tableView endUpdates];
    }else if (indexPath.row == 0){
        //选中的cell对应的组已经打开，且选中的是row0
        NSLog(@"section：%@ close!",section.name);
        section.isOpen = !section.isOpen;
        
        NSMutableArray *b = [[NSMutableArray alloc]init];
        
        for (int i = 1; i < [section.dataArray count]; i++) {
            NSIndexPath *redIndexPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [b addObject:redIndexPath];
        }
        [self.tableView beginUpdates];
        
        [self.tableView deleteRowsAtIndexPaths:b withRowAnimation:UITableViewRowAnimationTop];
        
        [self.tableView endUpdates];
    }
}

//判断是否为标题cell设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0) {
        return 40;
    }else{
        return 44;
    }
}


@end
