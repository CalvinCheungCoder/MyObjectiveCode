//
//  TwoTableView.m
//  NavSegment
//
//  Created by 张丁豪 on 2017/3/20.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "TwoTableView.h"

@interface TwoTableView ()<UITableViewDelegate, UITableViewDataSource>

@end
static NSString * const TwoTableViewCellId = @"TwoTableViewCellId";

@implementation TwoTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor redColor];
        self.delegate = self;
        self.dataSource = self;
        //        self.bounces = NO;
    }
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TwoTableViewCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TwoTableViewCellId];
    }
    
    cell.textLabel.text = @"第二组";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}


@end
