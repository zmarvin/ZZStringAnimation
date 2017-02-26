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
@property (nonatomic,strong) UITextField *textField;

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
    
    UITextField *textF = [UITextField new];
    textF.frame = CGRectMake(30, 200, 300, 100);
    textF.text = @"dsflajdflsdajfl;djslfjsdafl,fdsafljsdlafjdslfjsldfjdsalfjslkf";
    textF.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textF];
    _textField = textF;
    
}

- (void)click {
    
    ZZLightAnimation *lightAnimation = [[ZZLightAnimation alloc] init];
    lightAnimation.duration = 2;
    [_label zz_startAnimation:lightAnimation];
    
    ZZLightAnimation *lightAnimation2 = [[ZZLightAnimation alloc] init];
    [_textField zz_startAnimation:lightAnimation2];

}

@end
