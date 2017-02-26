//
//  ZZLightAnimation.m
//  ZZStringAnimation
//
//  Created by zz on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZLightAnimation.h"
#import "UIView+ZZStringAnimation.h"

@interface ZZLightAnimation ()

@property (nonatomic,strong) UIView *animationView;

@property (nonatomic,strong) NSTimer *timer;


@end

@implementation ZZLightAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _animationView = [UIView new];
        _color = [UIColor whiteColor];
        _alpha = 0.7;
        _duration = 1.5;
        _animationViewWidth = 14;
        _repeat = YES;
        
        _animationView.backgroundColor = _color;
        _animationView.alpha = _alpha;
        
    }
    return self;
}

- (void)fireTimerKeepAlive{
    if (_timer) return;
    SEL selector = @selector(zz_startAnimationWithView:);
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    _timer = [NSTimer timerWithTimeInterval:_duration invocation:invocation repeats:_repeat];
    
    [_timer fire];
}
- (void)stopTimerResignAlive{
    
    if (_timer == nil) return;
    [_timer invalidate];
    _timer = nil;
}
- (void)setRepeat:(BOOL)repeat{
    _repeat = repeat;
    [self stopTimerResignAlive];
    [self fireTimerKeepAlive];
}

- (void)zz_startAnimationWithView:(UIView *)view{
    
    NSString *viewText = [view viewText];
    if (viewText == nil) {
        NSLog(@"not suport this view");
        return;
    }
    CGRect stringBounds = [view viewTextBounds];
    CGRect stringFrame = [view viewTextFrame];
    
    _animationView.frame = CGRectMake(0, stringFrame.origin.y, _animationViewWidth, stringFrame.size.height);
    
    [view addSubview:_animationView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:_animationView.bounds];
    [maskPath fill];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _animationView.bounds;
    maskLayer.path = maskPath.CGPath;
    _animationView.layer.mask = maskLayer;
    
    if (_repeat) {
        [self fireTimerKeepAlive];
    }
    [UIView animateWithDuration:_duration animations:^{
        _animationView.frame = CGRectMake(stringBounds.size.width - _animationView.frame.size.width, _animationView.frame.origin.y, _animationView.frame.size.width, _animationView.frame.size.height);
    } completion:^(BOOL finished) {
        [_animationView removeFromSuperview];
    }];
    
}


@end
