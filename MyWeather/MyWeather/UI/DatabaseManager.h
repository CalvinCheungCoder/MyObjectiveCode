//
//  DatabaseManager.h
//  Cook
//
//  Created by CalvinCheung on 16/10/8.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "UserData.h"

// 数据库在沙盒中的位置
#define DatabasePath [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",DatabaseName]]

// 数据库的文件名称
#define DatabaseName @"MyCity.db"

@interface DatabaseManager : NSObject

{   // 声明一个数据库管理者
    FMDatabase *_dataBase;
}

// 单例的方法
+ (DatabaseManager *)manager;

// 添加数据
- (void)insertCollecInformation:(UserData *)data;

// 查找全部数据
- (NSArray *)findAllData;

// 删除指定的元素(叫name的全删掉)
- (void)deleteObject:(NSString *)City;

// 刷新数据
- (void)updateDataWith:(UserData *)data;

@end
