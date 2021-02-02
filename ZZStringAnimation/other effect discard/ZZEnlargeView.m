//
//  ZZEnlargeView.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/2.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZEnlargeView.h"
//#import "UIColor+ZZStringAnimation.h"
#import "UIView+ZZStringAnimation.h"

@interface ZZEnlargeView ()

@property (nonatomic,weak  ) UIView *targetView;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *backgroundColor;

@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,strong) CAShapeLayer *maskLayer;

@end

@implementation ZZEnlargeView

- (instancetype)initWithView:(UIView *)targetView
{
    self = [super init];
    if (self) {
        
        NSString *text = targetView.zz_viewText;
        NSAssert(text != nil, @"this view mast have text property");
        
        self.text = text;
        self.font = targetView.zz_viewTextFont;
        self.textColor = targetView.zz_viewTextColor;
        self.targetView = targetView;
        self.frame = _targetView.zz_viewTextFrame;

        self.backgroundColor = [[NSString stringWithFormat:@"%@",targetView.backgroundColor] isEqualToString:@"UIExtendedGrayColorSpace 0 0"]?[UIColor whiteColor]:targetView.backgroundColor;
        
        self.layer.backgroundColor = self.backgroundColor.CGColor;
        self.backgroundColor = self.backgroundColor;
        _maskLayer = [[CAShapeLayer alloc] init];
        _maskLayer.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
        _maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:_maskLayer.frame].CGPath;
        self.layer.mask = _maskLayer;
        
        
    }
    return self;
}

+ (instancetype)enlargeView:(UIView *)targetView{
    
    return [[ZZEnlargeView alloc] initWithView:targetView];
}

- (void)startAnimationWithDuration:(CGFloat)duration{
    
    self.duration = duration;
    
    CABasicAnimation * maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.duration = self.duration;
    maskLayerAnimation.fromValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithOvalInRect:_maskLayer.frame].CGPath);
    
    CGRect rect = _maskLayer.frame;
    rect.origin.x = self.targetView.zz_viewTextBounds.size.width - _maskLayer.frame.size.height;
    maskLayerAnimation.toValue = (__bridge id _Nullable)([UIBezierPath bezierPathWithOvalInRect:rect].CGPath);
    maskLayerAnimation.removedOnCompletion = NO;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [_maskLayer addAnimation:maskLayerAnimation forKey:@"path"];

}

- (void)setEnlarge:(CGFloat)enlarge{
    _enlarge = enlarge;
    self.layer.transform = CATransform3DMakeScale(enlarge, enlarge, 1);

}

- (void)drawRect:(CGRect)rect{
    
    NSDictionary *attar = @{
                            NSFontAttributeName:self.font,
                            NSForegroundColorAttributeName:self.textColor,
                            NSBackgroundColorAttributeName:self.backgroundColor
                            };
    [self.text drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attar context:nil];
}

@end
