//
//  DHStarView.m
//  DHStarView
//
//  Created by 张丁豪 on 2017/3/22.
//  Copyright © 2017年 张丁豪. All rights reserved.
//

#import "DHStarView.h"

typedef void(^completeBlock)(CGFloat currentStar);

@interface DHStarView()

@property (nonatomic,strong) completeBlock complete;
@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@end

@implementation DHStarView

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars currentStar:(CGFloat)currentStar rateStyle:(StarStyle)rateStyle isAnination:(BOOL)isAnimation andamptyImageName:(NSString *)amptyImageName fullImageName:(NSString *)fullImageName finish:(finishBlock)finish{
    self=[super initWithFrame:frame];
    if (self) {
        _currentStar=currentStar;
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = isAnimation;
        _amptyImageName=amptyImageName;
        _fullImageName=fullImageName;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

-(void)createStarView{
    self.foregroundStarView = [self createStarViewWithImage:self.fullImageName];
    self.backgroundStarView = [self createStarViewWithImage:self.amptyImageName];
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*self.currentStar/self.numberOfStars, self.bounds.size.height);
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self currentStarWithTouch:[touches anyObject]];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self currentStarWithTouch:[touches anyObject]];
}
-(void)currentStarWithTouch:(UITouch *)touch{
    CGPoint tapPoing=[touch locationInView:self];
    CGFloat offset =tapPoing.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    switch (_rateStyle) {
        case WholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case HalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case IncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
}
- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    switch (_rateStyle) {
        case WholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case HalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case IncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    __weak DHStarView *weakSelf = self;
    CGFloat animationTimeInterval = self.isAnimation ? 0.5 : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentStar/self.numberOfStars, weakSelf.bounds.size.height);
    }];
}
-(void)setCurrentScore:(CGFloat)currentScore {
    if (_currentStar == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _currentStar = 0;
    } else if (currentScore > _numberOfStars) {
        _currentStar = _numberOfStars;
    } else {
        _currentStar = currentScore;
    }
    if ([self.delegate respondsToSelector:@selector(starEvaluator:currentValue:)]) {
        [self.delegate starEvaluator:self currentValue:_currentStar];
    }
    if (self.complete) {
        _complete(_currentStar);
    }
    [self setNeedsLayout];
}

@end
