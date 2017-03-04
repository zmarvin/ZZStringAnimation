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

@interface ZZLightAnimation ()<CAAnimationDelegate>

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
    
    NSString *viewText = [self.view zz_viewText];
    if (viewText == nil) {
        return;
    }
    CGRect stringFrame = [self.view zz_viewTextFrame];
    _animationView.frame = CGRectMake(0, stringFrame.origin.y, _animationViewWidth, stringFrame.size.height);
    
    [self.view addSubview:_animationView];
    
    UIGraphicsBeginImageContextWithOptions(_animationView.frame.size, NO, 0.0);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:_animationView.bounds];
    [maskPath fill];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _animationView.bounds;
    maskLayer.path = maskPath.CGPath;
    _animationView.layer.mask = maskLayer;
    UIGraphicsEndImageContext();
    
        CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
        gradientLayer.colors = [NSArray arrayWithObjects:
                                (id)[[_color colorWithAlphaComponent:0.2] CGColor],
                                (id)[[_color colorWithAlphaComponent:1] CGColor],
                                (id)[[_color colorWithAlphaComponent:1] CGColor],
                                (id)[[_color colorWithAlphaComponent:0.2] CGColor],
                                nil];
    
        gradientLayer.locations = [NSArray arrayWithObjects:
                                     [NSNumber numberWithFloat:0.0],
                                   [NSNumber numberWithFloat:0.3],
                                   [NSNumber numberWithFloat:0.7],
                                     [NSNumber numberWithFloat:1.0],
         nil];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1,1);
        gradientLayer.frame = _animationView.bounds;
        [_animationView.layer addSublayer:gradientLayer];
    
    CGFloat offset = stringFrame.size.width - _animationView.frame.size.width;
    CGPoint toPoint = CGPointMake(0.5*_animationView.frame.size.width+offset, self.animationView.layer.position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:self.animationView.layer.position];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.duration = self.duration;
    if(self.repeat){
        animation.repeatCount = HUGE_VALF;
    }else{
        animation.repeatCount = 0;
    }
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [self.animationView.layer addAnimation:animation forKey:@"position"];
}

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.animationView.layer removeAllAnimations];
    [_animationView removeFromSuperview];
}

- (void)setAngle:(CGFloat)angle{
    _angle = angle;
    _animationView.transform = CGAffineTransformRotate(CGAffineTransformIdentity,_angle);
}

- (void)setColor:(UIColor *)color{
    _color = color;
    _animationView.backgroundColor = color;
}

@end
