//
//  RootViewController.m
//  DHTakePhoto
//
//  Created by 张丁豪 on 2017/3/21.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImageView *Img;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Take Photo";
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    Img = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-80, 80, 160, 160)];
    [self.view addSubview:Img];
    
    
    NSArray *titleArr = @[@"拍照",@"相册"];
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 280+i*60, [UIScreen mainScreen].bounds.size.width-40, 40)];
        btn.layer.cornerRadius = 3;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor orangeColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}

- (void)BtnClick:(UIButton *)Btn{
    
    if (Btn.tag == 0) {
        // 拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [UIImagePickerController new];
            picker.delegate = self;
            picker.allowsEditing = YES;
            // 摄像头
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
    }else{
        // 进入图库
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *picker = [UIImagePickerController new];
            picker.delegate = self;
            picker.allowsEditing = YES;
            // 打开相册
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
            
        }
    }
}

// 拍照完成或者相册选择图片后都会执行下面这个方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 得到图片
    UIImage *img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    Img.image = img;
    // 存入相册
//    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
