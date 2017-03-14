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
#import "ZZArcStringView.h"
#import "ZZWaveView.h"

@interface ViewController ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;
@property (nonatomic,strong) UILabel *label5;

@property (nonatomic,strong) ZZArcStringView *arcStringView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [UIButton new];
    btn1.frame = CGRectMake(150, 80, 80, 25);
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitle:@"黄鹤楼" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(50, 100, 280, 100);
    label.text = @"昔人已乘黄鹤去，此地空余黄鹤楼。";
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    _label = label;

    
    UILabel *label2 = [UILabel new];
    label2.frame = CGRectMake(50, 150, 280, 100);
    label2.text = @"黄鹤一去不复返，白云千载空悠悠。";
    label2.textColor = [UIColor redColor];
    [self.view addSubview:label2];
    _label2 = label2;

    
    UILabel *label3 = [UILabel new];
    label3.frame = CGRectMake(50, 200, 280, 100);
    label3.text = @"晴川历历汉阳树，芳草萋萋鹦鹉洲。";
    label3.textColor = [UIColor redColor];
    [self.view addSubview:label3];
    _label3 = label3;

    
    UILabel *label4 = [UILabel new];
    label4.frame = CGRectMake(50, 250, 280, 100);
    label4.text = @"日暮乡关何处是，烟波江上使人愁。";
    label4.textColor = [UIColor redColor];
    [self.view addSubview:label4];
    _label4 = label4;

    
    UIButton *btn2 = [UIButton new];
    btn2.frame = CGRectMake(150, 355, 80, 25);
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 setTitle:@"将进酒" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label5 = [UILabel new];
    label5.frame = CGRectMake(30, 380, 355, 100);
    label5.text = @"君不见黄河之水天上来，奔流到海不复回。\n君不见高堂明镜悲白发，朝如青丝暮成雪。";
    label5.numberOfLines = 0;
    label5.textColor = [UIColor redColor];
    [self.view addSubview:label5];
    _label5 =label5;
    
    //    ZZArcStringView *arcStringView = [ZZArcStringView ArcStringView:label3];
    //    arcStringView.frame = CGRectMake(50, 380, 280, 150);
    //    arcStringView.radius = 120;
    //    arcStringView.backgroundColor = [UIColor orangeColor];
    //    arcStringView.showsGlyphBounds = YES;
    //    arcStringView.showsLineMetrics = YES;
    //    arcStringView.dimsSubstitutedGlyphs = NO;
    //    [self.view addSubview:arcStringView];
    
}

- (void)click1 {
    
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

- (void)click2 {
    
    ZZWaveAnimation *waveAnimation = [ZZWaveAnimation new];
    waveAnimation.duration = 5;
    [_label5 zz_startAnimation:waveAnimation];
}

@end
