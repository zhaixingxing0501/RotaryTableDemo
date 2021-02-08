//
//  ViewController.m
//  RotaryTableDemo
//
//  Created by zhaixingxing on 2021/2/2.
//

#import "ViewController.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kcolorRandom  [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]

@interface ViewController ()<CAAnimationDelegate>
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, assign) BOOL isAnimation;
@property (nonatomic, assign) NSInteger circleAngle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
}

#pragma mark 初始化View
- (void)initView {
    //转盘背景
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 50, SCREEN_WIDTH - 50)];
    _bgImageView.center = self.view.center;
    _bgImageView.image = [UIImage imageNamed:@"123png.png"];
    _bgImageView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_bgImageView];

    //添加GO按钮图片
    UIImageView *btnimage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, SCREEN_HEIGHT / 2 - 70, 100, 118)];
//    btnimage.image = [UIImage imageNamed:@"bt.jpeg"];
    [self.view addSubview:btnimage];

    _bgImageView.userInteractionEnabled = YES;
    btnimage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick)];
    [btnimage addGestureRecognizer:tap];

    //添加文字
    NSArray *_prizeArray = @[@"谢谢参与", @"一等奖", @"谢谢参与", @"二等奖", @"谢谢参与", @"三等奖", @"谢谢参与", @"特等奖"];

    for (int i = 0; i < 8; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, M_PI * CGRectGetHeight(_bgImageView.frame) / 8, CGRectGetHeight(_bgImageView.frame) * 3 / 5)];
        label.layer.anchorPoint = CGPointMake(0.5, 1.0);
        label.center = CGPointMake(CGRectGetHeight(_bgImageView.frame) / 2, CGRectGetHeight(_bgImageView.frame) / 2);
        label.text = [NSString stringWithFormat:@"%@", _prizeArray[i]];
        label.textColor = kcolorRandom;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:14];
        CGFloat angle = M_PI * 2 / 8 * i;
        label.transform = CGAffineTransformMakeRotation(angle);
        [_bgImageView addSubview:label];
    }
}

#pragma mark 点击Go按钮
- (void)btnClick {
    NSLog(@"点击Go");

    //判断是否正在转
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;

    //控制概率[0,80)
    NSInteger lotteryPro = arc4random() % 80;
    //设置转圈的圈数
    NSInteger circleNum = 6;

    if (lotteryPro < 10) {
        _circleAngle = 0;
    } else if (lotteryPro < 20) {
        _circleAngle = 45;
    } else if (lotteryPro < 30) {
        _circleAngle = 90;
    } else if (lotteryPro < 40) {
        _circleAngle = 135;
    } else if (lotteryPro < 50) {
        _circleAngle = 180;
    } else if (lotteryPro < 60) {
        _circleAngle = 225;
    } else if (lotteryPro < 70) {
        _circleAngle = 270;
    } else if (lotteryPro < 80) {
        _circleAngle = 315;
    }

    CGFloat perAngle = M_PI / 180.0;

    NSLog(@"turnAngle = %ld", (long)_circleAngle);

    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:_circleAngle * perAngle + 360 * perAngle * circleNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;

    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [_bgImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"动画停止");
    NSString *title;
    self.isAnimation = NO;
    if (_circleAngle == 0) {
        title = @"谢谢参与!";
    } else if (_circleAngle == 45) {
        title = @"恭喜你，获得特等奖！";
    } else if (_circleAngle == 90) {
        title = @"谢谢参与!";
    } else if (_circleAngle == 135) {
        title = @"恭喜你，获得三等奖！";
    } else if (_circleAngle == 180) {
        title = @"谢谢参与!";
    } else if (_circleAngle == 225) {
        title = @"恭喜你，获得二等奖！";
    } else if (_circleAngle == 270) {
        title = @"谢谢参与!";
    } else if (_circleAngle == 315) {
        title = @"恭喜你，获得一等奖！";
    }
    NSLog(@"%@", title);
}

@end
