//
//  ZZStringPathAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/3/3.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZPathAnimation.h"

@interface ZZPathAnimation ()

@property (nonatomic,weak  ) UIView *view;

@end

@implementation ZZPathAnimation
@synthesize view = _view;

- (void)zz_startAnimationWithView:(UIView *)view{
    _view = view;
    
    [self fireTimerKeepAlive];
}

- (void)onTimer{
    
    
    
}

@end
