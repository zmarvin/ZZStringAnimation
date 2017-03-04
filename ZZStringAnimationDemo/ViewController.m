//
//  ViewController.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ViewController.h"
#import "ZZStringAnimation.h"
#import <CoreText/CoreText.h>

@interface ViewController ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 50, 50, 50);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(50, 100, 300, 100);
    label.text = @"一缕光light，一缕光light";
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    _label = label;
    
    UILabel *label2 = [UILabel new];
    label2.frame = CGRectMake(80, 200, 300, 100);
    label2.text = @"现在字体放大了，字体放大";
    label2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label2];
    _label2 = label2;
    
}

- (void)click {
    
    ZZLightAnimation *lightAnimation = [[ZZLightAnimation alloc] init];
    lightAnimation.color = [UIColor whiteColor];
    lightAnimation.angle = M_PI_4;
    lightAnimation.duration = 1;
    lightAnimation.repeat = YES;
    [_label zz_startAnimation:lightAnimation];
    
    ZZEnlargeAnimation *enlargeAnimation = [[ZZEnlargeAnimation alloc] init];
    enlargeAnimation.duration = 5;
    enlargeAnimation.enlargeMultiple = 2;
    [_label2 zz_startAnimation:enlargeAnimation];
}

@end
