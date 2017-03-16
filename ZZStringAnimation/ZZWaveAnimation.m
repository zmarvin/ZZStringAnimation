//
//  ZZWaveAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/4.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZWaveAnimation.h"
#import "ZZWaveView.h"
@interface ZZWaveAnimation ()

@property (nonatomic,strong) ZZWaveView *waveView;
@property (nonatomic,weak  ) UIView *targetView;

@end

@implementation ZZWaveAnimation
@synthesize targetView = _targetView;

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)zz_startAnimationWithView:(UIView *)targetView{
    _targetView = targetView;
    
    _waveView = [ZZWaveView waveView:_targetView];
    [targetView.superview addSubview:_waveView];
    _waveView.waveHeight = self.waveHeight;
    [_waveView zz_startAnimationWithDuration:self.duration];
    targetView.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_waveView zz_stopAnimation];
        [_waveView removeFromSuperview];
        _waveView = nil;
        _targetView.hidden = NO;
    });
}

- (void)setWaveHeight:(CGFloat)waveHeight{
    _waveHeight = waveHeight;
    _waveView.waveHeight = waveHeight;

}

@end
