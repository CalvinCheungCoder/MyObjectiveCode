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

@property (nonatomic, assign) NSInteger bushu;

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
        btn.frame = CGRectMake(20, 60 * (i + 1), [UIScreen mainScreen].bounds.size.width/2 - 30, 40);
        btn.backgroundColor = [UIColor grayColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTintColor:[UIColor whiteColor]];
        btn.tag = i;
        btn.layer.cornerRadius = 3;
        [btn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UIButton *btnTwo = [[UIButton alloc]init];
        btnTwo.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 60 * (i + 1), [UIScreen mainScreen].bounds.size.width/2 - 30, 40);
        btnTwo.backgroundColor = [UIColor grayColor];
        [btnTwo setTitle:arr[i] forState:UIControlStateNormal];
        [btnTwo setTintColor:[UIColor whiteColor]];
        btnTwo.tag = i+100;
        btnTwo.layer.cornerRadius = 3;
        [btnTwo addTarget:self action:@selector(BtnTwoClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnTwo];
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
            [manage getStepCount:^(double value, NSError *error) {
                MyLog(@"1count-->%.0f", value);
                MyLog(@"1error-->%@", error.localizedDescription);
                dispatch_async(dispatch_get_main_queue(), ^{
                    stepLabel.text = [NSString stringWithFormat:@"步数：%.0f步", value];
                });
                
            }];
        }
        else {
            MyLog(@"记步fail");
        }
    }];
}

- (void)distance
{
    HealthKitManage *manage = [HealthKitManage shareInstance];
    [manage authorizeHealthKit:^(BOOL success, NSError *error) {
        
        if (success) {
            [manage getDistance:^(double value, NSError *error) {
                MyLog(@"2count-->%.2f", value);
                MyLog(@"2error-->%@", error.localizedDescription);
                dispatch_async(dispatch_get_main_queue(), ^{
                    distanceLabel.text = [NSString stringWithFormat:@"公里数：%.2f公里", value];
                });
            }];
        }
        else {
            MyLog(@"公里数fail");
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
            self.bushu = arc4random()%80+20;
            [self addBushu];
            
            break;
        case 3:
            // 增加 500 步
            self.bushu = arc4random()%450+50;
            [self addBushu];
            
            break;
        case 4:
            // 增加 1000 步
            self.bushu = arc4random()%900+100;
            [self addBushu];
            
            break;
        case 5:
            // 增加 2000 步
            self.bushu = arc4random()%1900+100;
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
        MyLog(@"%@", [NSThread currentThread]);
        // 数据看类型为步数.
        HKQuantityType *quantityTypeIdentifier = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        // 表示步数的数据单位的数量
        HKQuantity *quantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:_bushu];
        // 数量样本.
        HKQuantitySample *temperatureSample = [HKQuantitySample quantitySampleWithType:quantityTypeIdentifier quantity:quantity startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
        
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_sync(queue, ^{
            // block一定会在主线程执行
            MyLog(@"%@", [NSThread currentThread]);
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
}

- (void)BtnTwoClicked:(UIButton *)Btn{
    
    switch (Btn.tag) {
        case 1000:
            // 记步
            [self jibu];
            
            break;
        case 101:
            // distance
            [self distance];
            
            break;
        case 102:
            // 增加 100 步
            self.bushu = arc4random()%80+20;
            [self addDistance];
            
            break;
        case 103:
            // 增加 500 步
            self.bushu = arc4random()%450+50;
            [self addDistance];
            
            break;
        case 104:
            // 增加 1000 步
            self.bushu = arc4random()%900+100;
            [self addDistance];
            
            break;
        case 105:
            // 增加 2000 步
            self.bushu = arc4random()%1900+100;
            [self addDistance];
            
            break;
            
        default:
            break;
    }
}

-(void)addDistance{
    
    // 数据看类型为步数.
    HKQuantityType *WalkingRunning = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    // 表示步数的数据单位的数量
    HKQuantity *running = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:4];
    // 数量样本.
    HKQuantitySample *runingSample = [HKQuantitySample quantitySampleWithType:WalkingRunning quantity:running startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
    
    [self.healthStore saveObject:runingSample withCompletion:^(BOOL success, NSError *error) {
        if (success) {
            MyLog(@"增加公里成功");
        }else {
            MyLog(@"增加公里失败");
        }
    }];
    
    
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_async(queue, ^{
//        // block会在子线程中执行
//        MyLog(@"%@", [NSThread currentThread]);
//        
//        
////        HKQuantitySample *runningSample = [HKQuantitySample quantitySampleWithType:WalkingRunning quantity:running startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
//        
//        dispatch_queue_t queue = dispatch_get_main_queue();
//        dispatch_sync(queue, ^{
//            // block一定会在主线程执行
//            MyLog(@"%@", [NSThread currentThread]);
//            
//        });
//    });
}


@end
