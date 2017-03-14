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

@interface ZZEnlargeAnimation ()<CAAnimationDelegate>

@property (nonatomic,weak  ) UIView *targetView;

@property (nonatomic,strong) ZZEnlargeView *enlargeView;

@end

@implementation ZZEnlargeAnimation
@synthesize targetView = _targetView;

- (void)zz_startAnimationWithView:(UIView *)targetView{
    
    _targetView = targetView;
    
    ZZEnlargeView *enlargeView = [ZZEnlargeView enlargeView:targetView];
    enlargeView.enlarge = _enlargeMultiple;
    _enlargeView = enlargeView;
    [self.targetView addSubview:enlargeView];
    
    if (self.enlargeView.superview == nil) {
        [self.targetView addSubview:_enlargeView];
    }
    CGRect enlargeFrame = _enlargeView.frame;
    enlargeFrame.origin.x = -_enlargeView.frame.size.height * 0.5;
    enlargeFrame.size.width = _enlargeView.frame.size.width + 5;
    _enlargeView.frame = enlargeFrame;
    
    [_enlargeView startAnimationWithDuration:self.duration];
    
    [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect endframe = _enlargeView.frame;
        endframe.origin.x = self.targetView.zz_viewTextBounds.size.width - endframe.size.width + _enlargeView.frame.size.height*0.5;
        _enlargeView.frame = endframe;
    } completion:^(BOOL finished) {
        [self.enlargeView.layer removeAllAnimations];
        [self.enlargeView removeFromSuperview];
    }];
}

- (void)setEnlargeMultiple:(CGFloat)enlargeMultiple{
    _enlargeMultiple = enlargeMultiple;
    _enlargeView.enlarge = _enlargeMultiple;
}

@end
