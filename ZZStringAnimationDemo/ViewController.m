//
//  ViewController.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ViewController.h"
#import "ZZStringAnimation.h"
#import "ZZMicroscopeView.h"

@interface ViewController ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 50, 50, 50);
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(50, 100, 300, 100);
    label.text = @"dsflajdflsdajfl;djslfjsdafl";
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    _label = label;
    
    UILabel *textF = [UILabel new];
    textF.frame = CGRectMake(50, 200, 300, 100);
    textF.text = @"dsflajdflsdajfl;djslfjsdaf";
    textF.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textF];
    _textField = textF;
    
}

- (void)click {
    
    ZZLightAnimation *lightAnimation = [[ZZLightAnimation alloc] init];
    lightAnimation.duration = 2;
    lightAnimation.angle = M_PI_4*0.5;
    [_label zz_startAnimation:lightAnimation];
    
    ZZMicroscopeAnimation *lightAnimation2 = [[ZZMicroscopeAnimation alloc] init];
    lightAnimation2.duration = 5;
    lightAnimation2.lineWidth = 2;
    lightAnimation2.lineColor = [UIColor redColor];
    [_textField zz_startAnimation:lightAnimation2];

}

@end
