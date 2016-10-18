//
//  SearchViewController.m
//  MyWord
//
//  Created by CalvinCheung on 16/10/17.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "SearchViewController.h"
#import "MyHelper.h"

@interface SearchViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *search;

@property (nonatomic, copy) NSString *url;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RandomColor;
    
    [self setUpUI];
}


-(void)setUpUI{
    
    _search = [[UITextField alloc]initWithFrame:CGRectMake(20, 30, ScreenWidth - 60, 35)];
    _search.backgroundColor = [UIColor whiteColor];
    _search.layer.cornerRadius = 4;
    _search.placeholder = @"请输入单词";
    _search.font = [UIFont fontWithName:@"Arial" size:14.0f];
    _search.textColor = [UIColor redColor];
    _search.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 再次编辑就清空
    _search.clearsOnBeginEditing = YES;
    _search.textAlignment = NSTextAlignmentLeft;
    _search.keyboardType = UIKeyboardTypeDefault;
    _search.returnKeyType = UIReturnKeySearch;
    _search.delegate = self;
    [self.view addSubview:_search];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_search resignFirstResponder];
    
    NSString *str = _search.text;
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    _url = [NSString stringWithFormat:@"%@%@%@",searchOne,_search.text,searchTwo];
    [Networking requestDataByURL:self.url Parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MyLog(@"请求链接 == %@",self.url);
        NSDictionary *ecDict = responseObject[@"ec"];
        NSDictionary *wordDict = ecDict[@"word"];
        MyLog(@"wordDict == %@",wordDict);
//        NSString *usphone = [wordDict objectForKey:@"usphone"];
//        NSString *ukphone = [NSString stringWithFormat:@"%@",wordDict[@"ukphone"]];
//        MyLog(@"usphone == %@",usphone);
//        MyLog(@"ukphone == %@",ukphone);
//        for (NSDictionary *dict in wordDict[@"trs"]) {
//            NSDictionary *tr = dict[@"tr"];
//            NSDictionary *l = tr[@"l"];
//            NSString *wordStr = l[@"i"];
//            MyLog(@"wordStr == %@",wordStr);
//        }
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
