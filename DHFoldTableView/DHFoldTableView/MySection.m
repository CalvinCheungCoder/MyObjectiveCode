//
//  MySection.m
//  DHFoldTableView
//
//  Created by 张丁豪 on 2017/2/26.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "MySection.h"

@implementation MySection

- (instancetype)init
{
    self = [super init];
    self.isOpen = false;
    self.name = @"分组";
    self.dataArray = [[NSMutableArray alloc]init];
    NSArray *arr = @[@"提现时间:20156283",@"提现时间:20156283",@"提现时间:20156283",@"提现时间:20156283",@"提现时间:20156283"];
    for (int i = 0; i < arr.count; i++) {
        [self.dataArray addObject:arr[i]];
    }
    
    return self;
}


@end
