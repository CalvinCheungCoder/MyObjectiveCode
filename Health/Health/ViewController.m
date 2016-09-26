//
//  ViewController.m
//  Health
//
//  Created by CalvinCheung on 16/9/26.
//  Copyright © 2016年 CalvinCheung. All rights reserved.
//

#import "ViewController.h"
#import "HealthKitManage.h"

@interface ViewController (){
    
    UILabel *stepLabel;
    UILabel *distanceLabel;
}

@property (nonatomic, strong) HKHealthStore *healthStore;

@property (nonatomic, assign) float bushu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpUI];
    
    self.healthStore = [[HKHealthStore alloc] init];
}

-(void)setUpUI{
    
    NSArray *arr = [NSArray arrayWithObjects:@"展示步数",@"展示距离",@"增加 100 步",@"增加 500 步",@"增加 1000 步",@"增加 2000 步", nil];
    
    for (int i = 0; i < 6; i ++) {
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(50, 70 * (i + 1), [UIScreen mainScreen].bounds.size.width - 100, 46);
        btn.backgroundColor = [UIColor grayColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTintColor:[UIColor whiteColor]];
        btn.tag = i;
        btn.layer.cornerRadius = 6;
        [btn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 120, [UIScreen mainScreen].bounds.size.width - 100, 40)];
    stepLabel.backgroundColor = [UIColor grayColor];
    stepLabel.textAlignment = NSTextAlignmentCenter;
    [stepLabel setTextColor:[UIColor whiteColor]];
    stepLabel.layer.cornerRadius = 6;
    [self.view addSubview:stepLabel];
    
    distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 60, [UIScreen mainScreen].bounds.size.width - 100, 40)];
    [distanceLabel setTextColor:[UIColor whiteColor]];
    distanceLabel.backgroundColor = [UIColor grayColor];
    distanceLabel.textAlignment = NSTextAlignmentCenter;
    distanceLabel.layer.cornerRadius = 6;
    [self.view addSubview:distanceLabel];
    
}


-(void)jibu{
    
    HealthKitManage *manage = [HealthKitManage shareInstance];
    [manage authorizeHealthKit:^(BOOL success, NSError *error) {
        
        if (success) {
            NSLog(@"success");
            [manage getStepCount:^(double value, NSError *error) {
                NSLog(@"1count-->%.0f", value);
                NSLog(@"1error-->%@", error.localizedDescription);
                dispatch_async(dispatch_get_main_queue(), ^{
                    stepLabel.text = [NSString stringWithFormat:@"步数：%.0f步", value];
                });
                
            }];
        }
        else {
            NSLog(@"fail");
        }
    }];
}

- (void)distance
{
    HealthKitManage *manage = [HealthKitManage shareInstance];
    [manage authorizeHealthKit:^(BOOL success, NSError *error) {
        
        if (success) {
            NSLog(@"success");
            [manage getDistance:^(double value, NSError *error) {
                NSLog(@"2count-->%.2f", value);
                NSLog(@"2error-->%@", error.localizedDescription);
                dispatch_async(dispatch_get_main_queue(), ^{
                    distanceLabel.text = [NSString stringWithFormat:@"公里数：%.2f公里", value];
                });
                
            }];
        }
        else {
            NSLog(@"fail");
        }
    }];
}

-(void)BtnClicked:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            // 记步
            [self jibu];
            
            break;
        case 1:
            // distance
            [self distance];
            
            break;
        case 2:
            // 增加 100 步
            self.bushu = 100;
            [self addBushu];
            
            break;
        case 3:
            // 增加 500 步
            self.bushu = 500;
            [self addBushu];
            
            break;
        case 4:
            // 增加 1000 步
            self.bushu = 1000;
            [self addBushu];
            
            break;
        case 5:
            // 增加 2000 步
            self.bushu = 2000;
            [self addBushu];
            
            break;
            
        default:
            break;
    }
    

}

-(void)addBushu{
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        // block会在子线程中执行
        NSLog(@"%@", [NSThread currentThread]);
        
        // 数据看类型为步数.
        HKQuantityType *quantityTypeIdentifier = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        
        // 表示步数的数据单位的数量
        HKQuantity *quantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:_bushu];
        
        // 数量样本.
        HKQuantitySample *temperatureSample = [HKQuantitySample quantitySampleWithType:quantityTypeIdentifier quantity:quantity startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
        
        

        
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_sync(queue, ^{
            // block一定会在主线程执行
            NSLog(@"%@", [NSThread currentThread]);
            
            
            // 保存
            [self.healthStore saveObject:temperatureSample withCompletion:^(BOOL success, NSError *error) {
                if (success) {
                    // 保存成功
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"步数增加成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alert show];
                    
                }else {
                    // 保存失败
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"步数增加失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alert show];
                }
            }];
            
        });
    });
    NSLog(@"------------");
    
    
    
    
    
    
    

}


@end
