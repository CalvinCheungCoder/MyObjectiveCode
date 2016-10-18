//
//  OneViewController.m
//  MyWord
//
//  Created by CalvinCheung on 16/10/16.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) DatabaseManager *manger;

@property (nonatomic, strong) UITextField *word;

@property (nonatomic, strong) UITextField *desText;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(200, 200, 200);
    
    self.title = @"AddWord";
    
    self.manger = [[DatabaseManager alloc]init];
    
    [self setUpUI];
}

- (void)setUpUI{
 
    _word = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, ScreenWidth - 40, 46)];
//    word.background = [[UIImage imageNamed:@"liveRadioProvinceBg_Normal@2x"]imageWithRenderingMode:UIImageRenderingModeAutomatic];
    _word.backgroundColor = [UIColor whiteColor];
    _word.layer.cornerRadius = 5;
    _word.placeholder = @"请输入单词";
    _word.font = [UIFont fontWithName:@"Arial" size:16.0f];
    _word.textColor = [UIColor redColor];
    _word.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 再次编辑就清空
    _word.clearsOnBeginEditing = YES;
    _word.textAlignment = NSTextAlignmentLeft;
    _word.keyboardType = UIKeyboardTypeDefault;
    _word.delegate = self;
    [self.view addSubview:_word];
    
    
    _desText = [[UITextField alloc]initWithFrame:CGRectMake(20, 160, ScreenWidth - 40, 46)];
    //    word.background = [[UIImage imageNamed:@"liveRadioProvinceBg_Normal@2x"]imageWithRenderingMode:UIImageRenderingModeAutomatic];
    _desText.backgroundColor = [UIColor whiteColor];
    _desText.layer.cornerRadius = 5;
    _desText.placeholder = @"请输入单词释义";
    _desText.font = [UIFont fontWithName:@"Arial" size:16.0f];
    _desText.textColor = [UIColor redColor];
    _desText.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 再次编辑就清空
    _desText.clearsOnBeginEditing = YES;
    _desText.textAlignment = NSTextAlignmentLeft;
    _desText.keyboardType = UIKeyboardTypeDefault;
    _desText.delegate = self;
    [self.view addSubview:_desText];
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, ScreenHeight - 70, ScreenWidth - 60, 60)];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"whiteBtn@3x"] forState:UIControlStateNormal];
    [closeBtn setTitle:@"Add Word" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor colorWithHex:0x0d87cd] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeThePage) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.titleEdgeInsets = UIEdgeInsetsMake(-18, 0, 0, 0);
    [self.view addSubview:closeBtn];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_word resignFirstResponder];
    [_desText resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_word resignFirstResponder];
    [_desText resignFirstResponder];
    return YES;
}

- (void)closeThePage{
    
    UserData *data = [[UserData alloc] init];
    data.word = _word.text;
    data.des = _desText.text;
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[_manger findAllData]];
    for (UserData *temp in arr) {
        
        if ([_word.text isEqualToString:temp.word]) {
            
            return;
        }
    }
    [self.manger insertCollecInformation:data];
    MyLog(@"数据插入成功");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
