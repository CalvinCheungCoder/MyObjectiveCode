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
    _search.keyboardType = UIKeyboardTypeWebSearch;
    _search.delegate = self;
    [self.view addSubview:_search];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
