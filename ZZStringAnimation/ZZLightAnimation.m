//
//  ZZLightAnimation.m
//  ZZStringAnimation
//
//  Created by zz on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZLightAnimation.h"
#import <objc/objc-runtime.h>

@interface ZZLightAnimation ()

@property (nonatomic,strong) UIView *animationView;

@end

@implementation ZZLightAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animationView = [UIView new];
        _color = [UIColor redColor];
        _alpha = 0.4;
        _duration = 1;
        
        _animationView.backgroundColor = _color;
        _animationView.alpha = _alpha;
        
    }
    return self;
}

- (void)zz_startAnimationWithView:(UIView *)view{
    
    NSString *viewText;
    UIFont *font;
    CGRect stringBounds;
    
    if ([view respondsToSelector:@selector(text)]) {
        viewText = ((NSString *(*)(id, SEL))(void *) objc_msgSend)(view,@selector(text));
    }else{
        NSLog(@"not suport this view");
        return;
    }
    
    if ([view respondsToSelector:@selector(font)]) {
        font = ((UIFont *(*)(id, SEL))(void *) objc_msgSend)(view,@selector(font));
    }else{
        font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    NSDictionary *attr = @{NSFontAttributeName:font};
    stringBounds = [viewText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    _animationView.frame = [self adjustStringFrameWithView:view viewString:viewText stringBounds:stringBounds];
    [view addSubview:_animationView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:_animationView.bounds];
    [maskPath fill];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _animationView.bounds;
    maskLayer.path = maskPath.CGPath;
    _animationView.layer.mask = maskLayer;
    
    [UIView animateWithDuration:_duration animations:^{
        _animationView.frame = CGRectMake(stringBounds.size.width - _animationView.frame.size.width, _animationView.frame.origin.y, _animationView.frame.size.width, _animationView.frame.size.height);
    } completion:^(BOOL finished) {
        [_animationView removeFromSuperview];
    }];
    
}

- (CGRect)adjustStringFrameWithView:(UIView *)view viewString:(NSString *)viewText stringBounds:(CGRect)stringBounds{
    
    NSTextAlignment stringAlignment;
    
    if ([view respondsToSelector:@selector(textAlignment)]) {
        stringAlignment = ((NSTextAlignment (*)(id, SEL))(void *) objc_msgSend)(view,@selector(textAlignment));
    }else{
        stringAlignment = NSTextAlignmentLeft;
    }
    
    CGFloat stringX = 0;
    CGFloat stringY = 0;
    CGFloat stringW = 15;
    CGFloat stringH = stringBounds.size.height + 10;

    switch (stringAlignment) {
        case NSTextAlignmentNatural:
        case NSTextAlignmentLeft:
        case NSTextAlignmentJustified:
            stringX = 0;
            stringY = (view.frame.size.height - stringH)*0.5;
            break;
        case NSTextAlignmentCenter:
            stringX = (view.frame.size.width - stringW)*0.5;
            stringY = (view.frame.size.height - stringH)*0.5;
            break;
        case NSTextAlignmentRight:
            stringX = view.frame.size.width - stringW;
            stringY = (view.frame.size.height - stringH)*0.5;
            break;
    }
    
    return CGRectMake(stringX, stringY, stringW, stringH);
}

@end
