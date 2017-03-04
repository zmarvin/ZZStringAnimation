//
//  ZZEnlargeAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/2/28.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZEnlargeAnimation.h"
#import "UIView+ZZStringAnimation.h"
#import "ZZEnlargeView.h"

@interface ZZEnlargeAnimation ()

@property (nonatomic,weak  ) UIView *view;

@property (nonatomic,strong) ZZEnlargeView *enlargeView;

@end

@implementation ZZEnlargeAnimation
@synthesize view = _view;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)zz_startAnimationWithView:(UIView *)view{
    _view = view;
    
    _enlargeView = [ZZEnlargeView enlargeViewWithView:self.view];
    _enlargeView.enlarge = _enlargeMultiple;
    _enlargeView.lineWidth = _lineWidth;
    _enlargeView.lineColor = _lineColor;
    [self.view addSubview:_enlargeView];
    
    [self fireTimerKeepAlive];
}

- (void)onTimer{
    
    NSString *viewText = [self.view zz_viewText];
    if (viewText == nil) return;
    
    if (self.enlargeView.superview == nil) {
        [self.view addSubview:_enlargeView];
    }
    
    __weak typeof(self) wSelf = self;
    [_enlargeView startAnimationWithDuration:self.duration completion:^(BOOL finished) {
        [wSelf.enlargeView removeFromSuperview];
        if (!wSelf.repeat) {
            [wSelf stopTimerResignAlive];
        }
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
