//
//  ButtonViewController.m
//  DHCategory
//
//  Created by Calvin on 2017/7/11.
//  Copyright © 2017年 Calvin. All rights reserved.
//

#import "ButtonViewController.h"
#import "UIButton+ImageTitleStyle.h"

@interface ButtonViewController ()

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UIButton";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSArray *btntype = @[@"图左字右",@"图右字左",@"图上字下",@"图下字上",@"图居中字上"];
    NSArray *btntypeTwo = @[@"图居中字下",@"图居中字在图上",@"图居中字在图下",@"图右字左",@"图左字右"];
    for (int i = 0; i < btntype.count; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 70+i*90, 100, 80)];
        btn.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        [btn setImage:[UIImage imageNamed:@"img@2x"] forState:UIControlStateNormal];
        [btn setTitle:btntype[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i == 0) {
            [btn setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:3];
        }else if (i == 1){
            [btn setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:3];
        }else if (i == 2){
            [btn setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:3];
        }else if (i == 3){
            [btn setButtonImageTitleStyle:ButtonImageTitleStyleBottom padding:3];
        }else{
            [btn setButtonImageTitleStyle:ButtonImageTitleStyleCenterTop padding:3];
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        
        UIButton *btnTwo = [[UIButton alloc]initWithFrame:CGRectMake(130, 70+i*90, 100, 80)];
        btnTwo.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        [btnTwo setImage:[UIImage imageNamed:@"img@2x"] forState:UIControlStateNormal];
        [btnTwo setTitle:btntypeTwo[i] forState:UIControlStateNormal];
        btnTwo.titleLabel.font = [UIFont systemFontOfSize:12];
        [btnTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i == 0) {
            [btnTwo setButtonImageTitleStyle:ButtonImageTitleStyleCenterBottom padding:3];
        }else if (i == 1){
            [btnTwo setButtonImageTitleStyle:ButtonImageTitleStyleCenterUp padding:3];
        }else if (i == 2){
            [btnTwo setButtonImageTitleStyle:ButtonImageTitleStyleCenterDown padding:3];
        }else if (i == 3){
            [btnTwo setButtonImageTitleStyle:ButtonImageTitleStyleRightLeft padding:3];
        }else{
            [btnTwo setButtonImageTitleStyle:ButtonImageTitleStyleLeftRight padding:3];
        }
        btnTwo.tag = i;
        [btnTwo addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnTwo];
    }
}

- (void)leftBtnClicked:(UIButton *)btn
{
    
    NSLog(@"点击了 == %@",btn.titleLabel.text);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
