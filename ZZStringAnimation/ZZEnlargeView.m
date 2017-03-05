//
//  ZZEnlargeView.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/2.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZEnlargeView.h"
#import "UIColor+ZZStringAnimation.h"
#import "UIView+ZZStringAnimation.h"

@interface ZZEnlargeView ()

@property (nonatomic,weak  ) UIView *targetView;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,strong) CADisplayLink *link;
@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,strong) CAShapeLayer *maskLayer;

@property (nonatomic,assign) CGFloat moveSliceDistance;
@property (nonatomic,assign) CGFloat sliceDistance;

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
        self.frame = targetView.zz_viewTextFrame;
        self.targetView = targetView;
        
        self.backgroundColor = [[NSString stringWithFormat:@"%@",targetView.backgroundColor] isEqualToString:@"UIExtendedGrayColorSpace 0 0"]?[UIColor whiteColor]:targetView.backgroundColor;
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
        _maskLayer = [[CAShapeLayer alloc] init];
        _maskLayer.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        _maskLayer.path = path.CGPath;
        self.layer.mask = _maskLayer;
        UIGraphicsEndImageContext();
        
    }
    return self;
}

+ (instancetype)enlargeView:(UIView *)targetView{
    return [[ZZEnlargeView alloc] initWithView:targetView];
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
    CGRect rect = _maskLayer.frame;
    self.moveSliceDistance += self.sliceDistance;
    if (self.moveSliceDistance > self.frame.size.width) {
        return;
    }
    rect.origin.x = self.moveSliceDistance;
    _maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:rect].CGPath;
}

- (void)startAnimationWithDuration:(CGFloat)duration completion:(void (^)(BOOL finished))completion{
    
    self.duration = duration;
    self.sliceDistance = self.frame.size.width/(duration*60);
    [self startDisplay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self disposeDisplay];
        self.moveSliceDistance = 0;
        if(completion)completion(YES);
    });
}

- (void)setEnlarge:(CGFloat)enlarge{
    _enlarge = enlarge;
    self.transform = CGAffineTransformMakeScale(enlarge, enlarge);
}

- (void)drawRect:(CGRect)rect{
    
    NSDictionary *attar = @{
                            NSFontAttributeName:self.font,
                            NSForegroundColorAttributeName:self.textColor
                            };
    [self.text drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attar context:nil];
}

@end
