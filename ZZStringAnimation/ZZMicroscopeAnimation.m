//
//  ZZMicroscopeAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/2/28.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZMicroscopeAnimation.h"
#import "ZZMicroscopeView.h"
#import "UIView+ZZStringAnimation.h"

@interface ZZMicroscopeAnimation ()

@property (nonatomic,weak  ) UIView *view;

@property (nonatomic,strong) ZZMicroscopeView *microscopeView;

@end

@implementation ZZMicroscopeAnimation
@synthesize view = _view;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _microscopeView = [ZZMicroscopeView new];
        _microscopeView.backgroundColor = [UIColor clearColor];
        _lineWidth = _microscopeView.lineWidth;
    }
    return self;
}

- (void)zz_startAnimationWithView:(UIView *)view{
    _view = view;
    
    [self fireTimerKeepAlive];
}

- (void)onTimer{
    NSString *viewText = [self.view zz_viewText];
    if (viewText == nil) {
        return;
    }
    CGRect stringFrame = [self.view zz_viewTextFrame];
    _microscopeView.frame = CGRectMake(0, stringFrame.origin.y, stringFrame.size.height, stringFrame.size.height);
    [self.view addSubview:_microscopeView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:_microscopeView.bounds];
    [maskPath fill];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _microscopeView.bounds;
    maskLayer.path = maskPath.CGPath;
    _microscopeView.layer.mask = maskLayer;
    //        CGAffineTransform tran = CGAffineTransformMakeRotation(_angle);
    //        _animationView.transform = tran;
    
    [UIView animateWithDuration:self.duration animations:^{
        CGRect rect = _microscopeView.frame;
        rect.origin.x = stringFrame.size.width - _microscopeView.frame.size.width;
        _microscopeView.frame = rect;
    } completion:^(BOOL finished) {
        [_microscopeView removeFromSuperview];
        if (!self.repeat) {
            [self stopTimerResignAlive];
        }
    }];
}

- (void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    _microscopeView.lineWidth = lineWidth;
}
- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _microscopeView.lineColor = lineColor;
}
@end
