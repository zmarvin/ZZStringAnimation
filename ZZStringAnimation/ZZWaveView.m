//
//  ZZWaveView.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/3/12.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZWaveView.h"
#import "UIView+ZZStringAnimation.h"
@interface ZZWaveView ()

//波浪相关的参数
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveMid;
@property (nonatomic, assign) CGFloat maxAmplitude;
@property (nonatomic, assign) CGFloat phase;
@property (nonatomic, assign) CGFloat phaseShift;

@property (nonatomic, assign) CGFloat frequency;
@property (nonatomic, strong) CAShapeLayer *waveSinLayer;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic,weak  ) UIView *targetView;


@end

@implementation ZZWaveView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

+ (instancetype)waveView:(UIView *)targetView{
    
    return [[ZZWaveView alloc] initWithView:targetView];
}

- (instancetype)initWithView:(UIView *)targetView{
    self = [super init];
    if (self) {
        self.targetView = targetView;
        
        self.frame = _targetView.zz_viewTextFrame;
        
        self.waveSinLayer = [CAShapeLayer layer];
        _waveSinLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.waveSinLayer.fillColor = [[UIColor greenColor] CGColor];
        self.waveSinLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        self.layer.mask = _waveSinLayer;
        
        self.waveHeight = CGRectGetHeight(self.bounds) * 0.5;
        self.waveWidth  = CGRectGetWidth(self.bounds);
        self.frequency = .3;
        self.phaseShift = 8;
        self.waveMid = self.waveWidth / 2.0f;
        self.maxAmplitude = self.waveHeight * .3;
    }
    return self;
}

- (UIBezierPath *)createWavePath
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);

    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat endX = 0;
    for (CGFloat x = 0; x < self.waveWidth + 1; x += 1) {
        endX=x;
        CGFloat y = self.maxAmplitude * sinf(360.0 / _waveWidth * (x  * M_PI / 180) * self.frequency + self.phase * M_PI/ 180) + self.maxAmplitude;
        
        if (x == 0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        } else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    CGFloat endY = CGRectGetHeight(self.bounds) + 10;
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    UIGraphicsEndImageContext();
    return wavePath;
}
- (void)zz_startAnimationWithDuration:(CGFloat)duration{
    
    [self startDisplay];
    
    CGPoint position = self.waveSinLayer.position;
    position.y = position.y - self.bounds.size.height - 10;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:self.waveSinLayer.position];
    animation.toValue = [NSValue valueWithCGPoint:position];
    animation.duration = duration;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [self.waveSinLayer addAnimation:animation forKey:@"positionWave"];
    
}
- (void)zz_stopAnimation{
    [self disposeDisplay];
    
    [self.waveSinLayer removeAllAnimations];
    self.waveSinLayer.path = nil;
}
- (void)startDisplay{
    if (_link) return;
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(display)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)disposeDisplay{
    [_link invalidate];
    _link = nil;
}

- (void)display{
    self.phase += self.phaseShift;
    self.waveSinLayer.path = [self createWavePath].CGPath;
}


@end
