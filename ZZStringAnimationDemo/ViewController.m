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
@property (nonatomic,strong) ZZArcStringView *arcStringView;

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
    label.frame = CGRectMake(50, 100, 280, 100);
    label.text = @"一缕光light，一缕光light";
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    _label = label;
    
    UILabel *label2 = [UILabel new];
    label2.frame = CGRectMake(50, 200, 280, 100);
    label2.text = @"现在字体放大了，字体放大";
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor redColor];
    [self.view addSubview:label2];
    _label2 = label2;
    
    UILabel *label3 = [UILabel new];
    label3.frame = CGRectMake(50, 300, 280, 100);
    label3.text = @"现在字体出现，字体出现";
    label3.font = [UIFont systemFontOfSize:15];
    label3.textColor = [UIColor redColor];
    [self.view addSubview:label3];
    _label3 = label3;
    
    ZZArcStringView *arcStringView = [ZZArcStringView ArcStringView:label3];
    arcStringView.frame = CGRectMake(50, 400, 300, 300);
    arcStringView.radius = 170;
    [self.view addSubview:arcStringView];
}

- (void)click {
    
    ZZLightAnimation *lightAnimation = [ZZLightAnimation new];
    lightAnimation.color = [UIColor whiteColor];
    lightAnimation.angle = M_PI_4;
    lightAnimation.duration = 1;
    [_label zz_startAnimation:lightAnimation];
    
    ZZEnlargeAnimation *enlargeAnimation = [ZZEnlargeAnimation new];
    enlargeAnimation.duration = 5;
    enlargeAnimation.enlargeMultiple = 2;
    [_label2 zz_startAnimation:enlargeAnimation];
    
    ZZDrawAnimation *pathAnimation = [ZZDrawAnimation new];
    pathAnimation.duration = 5;
    [_label3 zz_startAnimation:pathAnimation];

}

@end
