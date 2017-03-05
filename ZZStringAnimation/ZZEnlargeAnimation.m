//
//  ZZEnlargeAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/2/28.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZEnlargeAnimation.h"
#import "UIView+ZZStringAnimation.h"
#import "ZZEnlargeView.h"

@interface ZZEnlargeAnimation ()

@property (nonatomic,weak  ) UIView *targetView;

@property (nonatomic,strong) ZZEnlargeView *enlargeView;

@end

@implementation ZZEnlargeAnimation
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
    
    ZZEnlargeView *enlargeView = [ZZEnlargeView enlargeView:targetView];
    enlargeView.enlarge = _enlargeMultiple;
    enlargeView.lineWidth = _lineWidth;
    enlargeView.lineColor = _lineColor;
    [self.targetView addSubview:enlargeView];
    _enlargeView = enlargeView;
    
    [self fireTimerKeepAlive];
}

- (void)onTimer{
    
    if (self.enlargeView.superview == nil) {
        [self.targetView addSubview:_enlargeView];
    }
    CGRect enlargeFrame = _enlargeView.frame;
    enlargeFrame.origin.x = -_enlargeView.frame.size.height * 0.5;
    enlargeFrame.size.width = _enlargeView.frame.size.width + 5;
    _enlargeView.frame = enlargeFrame;

    __weak typeof(self) wSelf = self;
    [_enlargeView startAnimationWithDuration:wSelf.duration completion:^(BOOL finished) {
        [wSelf.enlargeView removeFromSuperview];
        if (!wSelf.repeat) {
            [wSelf stopTimerResignAlive];
        }
    }];
    
    [UIView animateWithDuration:self.duration animations:^{
        
        CGRect enlargeFrame = _enlargeView.frame;
        enlargeFrame.origin.x = wSelf.targetView.zz_viewTextBounds.size.width - enlargeFrame.size.width + _enlargeView.frame.size.height*0.5;
        _enlargeView.frame = enlargeFrame;
    
    }];
    
}

- (void)setEnlargeMultiple:(CGFloat)enlargeMultiple{
    _enlargeMultiple = enlargeMultiple;
    _enlargeView.enlarge = _enlargeMultiple;
}

- (void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    _enlargeView.lineWidth = lineWidth;
}
- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _enlargeView.lineColor = lineColor;
}



@end
