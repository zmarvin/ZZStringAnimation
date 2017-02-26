//
//  ViewController.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ViewController.h"
#import "ZZStringAnimation.h"

@interface ViewController ()

@property (nonatomic,strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 100, 375, 100);
    label.text = @"lfdjlfasdlfjljdfsadfsdfasfdsf";
    [self.view addSubview:label];
    _label = label;
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 50, 50, 50);
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];

}

- (void)click {
    
    ZZLightAnimation *lightAnimation = [[ZZLightAnimation alloc] init];
    [_label zz_startAnimation:lightAnimation];
}

@end
