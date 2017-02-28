//
//  ZZLightAnimation.m
//  ZZStringAnimation
//
//  Created by zz on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZLightAnimation.h"
#import "UIView+ZZStringAnimation.h"
#import <CoreGraphics/CoreGraphics.h>


@interface ZZLightAnimation ()

@property (nonatomic,weak  ) UIView *view;

@property (nonatomic,strong) UIView *animationView;

@end

@implementation ZZLightAnimation
@synthesize view = _view;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _animationView = [UIView new];
        _angle = 0.0;
        _color = [UIColor whiteColor];
        _alpha = 0.7;
        _animationViewWidth = 10;
        
        _animationView.backgroundColor = _color;
        _animationView.alpha = _alpha;
        
    }
    return self;
}

- (void)zz_startAnimationWithView:(UIView *)pView{
    
    _view = pView;

    [self fireTimerKeepAlive];
}

- (void)onTimer{
    NSString *viewText = [self.view zz_viewText];
    if (viewText == nil) {
        return;
    }
    CGRect stringFrame = [self.view zz_viewTextFrame];
    _animationView.frame = CGRectMake(0, stringFrame.origin.y, _animationViewWidth, stringFrame.size.height);
    
    [self.view addSubview:_animationView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:_animationView.bounds];
    [maskPath fill];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _animationView.bounds;
    maskLayer.path = maskPath.CGPath;
    _animationView.layer.mask = maskLayer;
    //        CGAffineTransform tran = CGAffineTransformMakeRotation(_angle);
    //        _animationView.transform = tran;
    
    [UIView animateWithDuration:self.duration animations:^{
        CGRect rect = _animationView.frame;
        rect.origin.x = stringFrame.size.width - _animationView.frame.size.width;
        _animationView.frame = rect;
    } completion:^(BOOL finished) {
        [_animationView removeFromSuperview];
        if (!self.repeat) {
            [self stopTimerResignAlive];
        }
    }];
}

- (void)setAngle:(CGFloat)angle{
    _angle = angle;
}

- (void)setColor:(UIColor *)color{
    _color = color;
    _animationView.backgroundColor = color;
}
@end
