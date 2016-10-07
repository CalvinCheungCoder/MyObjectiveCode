//
//  NetInterface.h
//  Cook
//
//  Created by 张丁豪 on 15/9/17.
//  Copyright (c) 2015年 张丁豪. All rights reserved.
//



#ifndef Cook_NetInterface_h
#define Cook_NetInterface_h

//菜谱接口：
#define kCaiPuUrl @"http://ibaby.ipadown.com/api/food/food.show.list.php?keywords=%@&p=%ld&pagesize=20&from=com.ipadown.yyzp&version=3.0"

//菜谱详情页：
#define kCaiPuDetail @"http://ibaby.ipadown.com/api/food/food.show.detail.php?id=%@"

//专题主页：
#define kZhuanTiUrl @"http://ibaby.ipadown.com/api/food/food.topic.list.php?p=%ld&pagesize=20&order=addtime"

//专题目录页：
#define  kZhuanTiMenu @"http://ibaby.ipadown.com/api/food/food.topic.detail.php?id=%@"

//专题详情页：
#define kZhuanTiDeatail @"http://ibaby.ipadown.com/api/food/food.show.detail.php?id=%@"

//小知识主页：
#define kKnowledgeUrl @"http://ibaby.ipadown.com/api/food/food.tips.list.php?keywords=%@&p=%ld&pagesize=20&from=com.ipadown.yyzp&version=3.0"
//%E7%B2%A5&p

//小知识详情页：
#define kKnowledgeDetail @"http://ibaby.ipadown.com/api/food/food.tips.detail.php?id=%@"




/*
菜谱接口：
#define kCaiPuUrl @"http://ibaby.ipadown.com/api/food/food.show.list.php?keywords=%E7%B2%A5&p=1&pagesize=20&from=com.ipadown.yyzp&version=3.0"
 
菜谱详情页：
#define kCaiPuDetail @"http://ibaby.ipadown.com/api/food/food.show.detail.php?id=1032"
 
专题主页：
#define kZhuanTiUrl @"http://ibaby.ipadown.com/api/food/food.topic.list.php?p=1&pagesize=20&order=addtime"
 
专题目录页：
#define  kZhuanTiMenu @"http://ibaby.ipadown.com/api/food/food.topic.detail.php?id=3"
 
 小知识主页：
 #define kKnowledgeUrl @"http://ibaby.ipadown.com/api/food/food.tips.list.php?keywords=%E7%B2%A5&p=1&pagesize=20&from=com.ipadown.yyzp&version=3.0"
 
 小知识详情页：
 #define kKnowledgeDetail @"http://ibaby.ipadown.com/api/food/food.tips.detail.php?id=7"
 
 专题详情页：
 #define kZhuanTiDeatail @"http://ibaby.ipadown.com/api/food/food.show.detail.php?id=321"
 
 */
#endif
