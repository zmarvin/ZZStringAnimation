//
//  ViewController.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ViewController.h"
#import "ZZStringAnimation.h"
#import <CoreText/CoreText.h>

@interface ViewController ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;

//@property (nonatomic,strong) ZZArcStringView *arcStringView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(150, 80, 80, 25);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"黄鹤楼" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    CGPoint center = btn.center;
    center.x = self.view.center.x;
    btn.center = center;
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(50, 100, 280, 100);
    label.text = @"昔人已乘黄鹤去，此地空余黄鹤楼。";
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    _label = label;
    center = label.center;
    center.x = self.view.center.x;
    label.center = center;
    
    UILabel *label2 = [UILabel new];
    label2.frame = CGRectMake(50, 150, 280, 100);
    label2.text = @"黄鹤一去不复返，白云千载空悠悠。";
    label2.textColor = [UIColor redColor];
    [self.view addSubview:label2];
    _label2 = label2;
    center = label2.center;
    center.x = self.view.center.x;
    label2.center = center;
    
    UILabel *label3 = [UILabel new];
    label3.frame = CGRectMake(50, 200, 280, 100);
    label3.text = @"晴川历历汉阳树，芳草萋萋鹦鹉洲。";
    label3.textColor = [UIColor redColor];
    [self.view addSubview:label3];
    _label3 = label3;
    center = label3.center;
    center.x = self.view.center.x;
    label3.center = center;
    
    UILabel *label4 = [UILabel new];
    label4.frame = CGRectMake(50, 250, 280, 100);
    label4.text = @"日暮乡关何处是，烟波江上使人愁。";
    label4.textColor = [UIColor redColor];
    [self.view addSubview:label4];
    _label4 = label4;
    center = label3.center;
    center.x = self.view.center.x;
    label3.center = center;
    
//    ZZArcStringView *arcStringView = [ZZArcStringView ArcStringView:label3];
//    arcStringView.frame = CGRectMake(50, 400, 300, 200);
//    arcStringView.radius = 120;
//    [self.view addSubview:arcStringView];
}

- (void)click {
    
    ZZLightAnimation *lightAnimation = [ZZLightAnimation new];
    lightAnimation.color = [UIColor whiteColor];
    lightAnimation.duration = 1;
    [_label zz_startAnimation:lightAnimation];
    
    ZZEnlargeAnimation *enlargeAnimation = [ZZEnlargeAnimation new];
    enlargeAnimation.duration = 5;
    enlargeAnimation.enlargeMultiple = 3;
    [_label2 zz_startAnimation:enlargeAnimation];
    
    ZZDrawAnimation *pathAnimation = [ZZDrawAnimation new];
    pathAnimation.duration = 5;
    [_label3 zz_startAnimation:pathAnimation];
    
    ZZGradualAnimation *gradualAnimation = [ZZGradualAnimation new];
    gradualAnimation.duration = 5;
    [_label4 zz_startAnimation:gradualAnimation];

}

@end
