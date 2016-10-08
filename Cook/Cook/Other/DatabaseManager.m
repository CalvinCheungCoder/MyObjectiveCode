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
        /*
         FMDatabase 是 数据库管理者的第三方库FMDB的核心类
         本质上是FMDB这个库的管理者
         【使用说明】
         1. 获取沙盒路径，因为数据库文件要存储在沙盒中
         2. 在沙盒中指定数据库文件路径
         3. 新建FMDB对象并调用initWithPath关联数据库文件
         4.    打开数据库创建表
         5.    增，删，查，改
         */
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
    NSString * sql = @"create table if not exists Collect(id integer primary key autoincrement, title, thumb, idcollect);";
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
    NSString * sql = @"insert into Collect(title, thumb, idcollect) values(?,?,?);";
    @synchronized (self)
    {
        int result = [_dataBase open];
        if (result != YES)
        {
            NSLog(@"打开数据库失败");
            return;
        }
        [_dataBase executeUpdate:sql,data.title, data.thumb, data.idcollect];
        NSLog(@"插入数据成功");
        [_dataBase close];
    }
}

// 找到所有数据
- (NSArray *)findAllData
{
    NSString * sql = @"select * from Collect;";
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
            model.thumb = [set stringForColumn:@"thumb"];
            model.title = [set stringForColumn:@"title"];
            model.idcollect = [set stringForColumn:@"idcollect"];
            [temp addObject:model];
        }
        [_dataBase close];
    }
    return temp;
}

- (void)deleteObject:(NSString *)name
{
    NSString * sql = @"delete from Collect where title = ?;";
    @synchronized (self)
    {
        int result = [_dataBase open];
        if (result != YES) {
            return;
        }
        [_dataBase executeUpdate:sql, name];
        [_dataBase close];
    }
}

- (void)updateDataWith:(UserData *)data
{
    NSString * sql = @"update Collect set title = ?, thumb = ?, idcollect = ?;";
    @synchronized (self)
    {
        int result = [_dataBase open];
        if (result != YES) {
            return;
        }
        [_dataBase executeUpdate:sql, data.title, data.thumb, data.idcollect];
        [_dataBase close];
    }
}


@end
