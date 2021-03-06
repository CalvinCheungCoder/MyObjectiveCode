//
//  DatabaseManager.m
//  Cook
//
//  Created by CalvinCheung on 16/10/8.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "DatabaseManager.h"

static DatabaseManager *manager = nil;

@implementation DatabaseManager

+ (DatabaseManager *)manager
{
    @synchronized(self)
    {
        if (!manager){
            manager = [[DatabaseManager alloc]init];
        }
    }
    return manager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        //实例化一个数据库管理者
        _dataBase = [[FMDatabase alloc]initWithPath:DatabasePath];
        NSLog(@"%@",DatabasePath);
        //创建表
        [self createTable];
    }
    return self;
}

//创建表单
/*
 表单形式可以参考Excel，每一列都是一个字段，每一行都是一个数据元
 */
- (void)createTable
{   // 用字符串去写sql语句
    NSString * sql = @"create table if not exists MyCity(id integer primary key autoincrement, city);";
    // 打开数据库
    int result = [_dataBase open];
    // 如果打开不成功，直接返回
    if (result != YES) {
        return;
    }
    // 执行sql语句
    [_dataBase executeUpdate:sql];
    // 关闭数据库
    [_dataBase close];
}

// 插入信息，直接将信息的model传入
- (void)insertCollecInformation:(UserData *)data
{
    NSString * sql = @"insert into MyCity(city) values(?);";
    @synchronized (self)
    {
        int result = [_dataBase open];
        if (result != YES)
        {
            return;
        }
        [_dataBase executeUpdate:sql,data.city];
        [_dataBase close];
    }
}

// 找到所有数据
- (NSArray *)findAllData
{
    NSString * sql = @"select * from MyCity;";
    NSMutableArray * temp = [[NSMutableArray alloc]initWithCapacity:0];
    @synchronized (self)
    {
        int result = [_dataBase open];
        if (result != YES) {
            return nil;
        }
        FMResultSet * set = [_dataBase executeQuery:sql];
        while ([set next]) {
            UserData *model = [[UserData alloc]init];
            model.city = [set stringForColumn:@"city"];
            [temp addObject:model];
        }
        [_dataBase close];
    }
    return temp;
}

- (void)deleteObject:(NSString *)City
{
    NSString * sql = @"delete from MyCity where city = ?;";
    @synchronized (self)
    {
        int result = [_dataBase open];
        if (result != YES) {
            return;
        }
        [_dataBase executeUpdate:sql,City];
        [_dataBase close];
    }
}

- (void)updateDataWith:(UserData *)data
{
    NSString * sql = @"update MyCity set city = ?;";
    @synchronized (self)
    {
        int result = [_dataBase open];
        if (result != YES) {
            return;
        }
        [_dataBase executeUpdate:sql, data.city];
        [_dataBase close];
    }
}

@end
