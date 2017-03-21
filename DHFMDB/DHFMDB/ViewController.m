//
//  ViewController.m
//  DHFMDB
//
//  Created by 张丁豪 on 2017/3/21.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "ViewController.h"
#import "DHFMDB.h"
#import "News.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DHFMDB *newFMDB = [DHFMDB shareDatabase];
    [newFMDB dh_createTable:@"News" dicOrModel:[News class]];
    
    News *news = [[News alloc] init];
    news.newsID = @"1";
    news.newsUrl = @"www.baidu.com";
    
    // 向user表中插入一条数据
    [newFMDB dh_insertTable:@"News" dicOrModel:news];
    
    if ([newFMDB dh_isExistTable:@"News"]) {
        
        NSLog(@"%d",[newFMDB dh_tableItemCount:@"News"]);
    }else{
        NSLog(@"没有表");
    }
    
    
    UIWebView *webView = [[UIWebView alloc]init];
    NSString *str = @"";
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString * path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)[str hash]]];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    if (!(htmlString == nil || [htmlString isEqualToString:@""])) {
        [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:str]];
    }else{
        NSURL *url = [NSURL URLWithString:str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        [self writeToCache];
    }
}

/**
 * 网页缓存写入文件
 */
- (void)writeToCache
{
    NSString *url = @"";
    NSString *htmlResponseStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:url]encoding:NSUTF8StringEncoding error:Nil];
    // 创建文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    // 获取document路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    
    [fileManager createDirectoryAtPath:[cachesPath stringByAppendingString:@"/Caches"] withIntermediateDirectories:YES  attributes:nil error:nil];
    // 写入路径
    NSString *path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu.html",(unsigned long)[url hash]]];
    [htmlResponseStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}






@end
