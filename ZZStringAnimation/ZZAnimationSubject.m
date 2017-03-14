//
//  ZZStringSubject.m
//  ZZStringAnimation
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZAnimationSubject.h"

static NSMutableArray * ZZAnimations() {
    
    static NSMutableArray *_ZZAnimations = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ZZAnimations = [NSMutableArray arrayWithCapacity:1];
    });
    
    return _ZZAnimations;
}

@interface ZZAnimationSubject ()
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation ZZAnimationSubject

- (instancetype)init{
    if (self = [super init]) {
        _duration = 1;
        _repeat = NO;
        _repeatTimeInterval = 1;
    }
    return self;
}

- (void)zz_startAnimationWithView:(UIView *)targetView{
    NSCAssert(NO, @"This method must be overridden by subclasses");
}

- (void)onTimer{
}

- (void)fireTimerKeepAlive{
    
    if (_timer) return;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_duration+_repeatTimeInterval target:self selector:@selector(onTimer) userInfo:nil repeats:_repeat];
    [_timer fire];
}

- (void)stopTimerResignAlive{
    
    if (_timer == nil) return;
    [_timer invalidate];
    _timer = nil;
}


@end
