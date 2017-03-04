//
//  ZZEnlargeView.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/3/2.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZEnlargeView.h"
#import "UIColor+ZZStringAnimation.h"
#import "UIView+ZZStringAnimation.h"

@interface ZZEnlargeView ()

@property (nonatomic,weak  ) UIView *backupView;

@property (nonatomic,strong) NSString *text;

@property (nonatomic,strong) UIFont *font;

@property (nonatomic,strong) CADisplayLink *link;

@property (nonatomic,assign) CGFloat duration;

@property (nonatomic,assign) CGRect microscopeViewPostion;

@property (nonatomic,strong) CAShapeLayer *maskLayer;

@property (nonatomic,assign) CGFloat moveSliceDistance;
@property (nonatomic,assign) CGFloat sliceDistance;

@property (nonatomic,copy ) void (^displayBlock)(CAShapeLayer *maskLayer);
@end

@implementation ZZEnlargeView

+ (instancetype)enlargeViewWithView:(UIView *)view{
    
    NSString *text = view.zz_viewText;
    NSAssert(text != nil, @"this view mast have text property");
    
    ZZEnlargeView *enlargeView = [[ZZEnlargeView alloc] init];
    enlargeView.text = text;
    enlargeView.font = view.zz_viewTextFont;
    enlargeView.frame = view.zz_viewTextFrame;
    enlargeView.backupView = view;
    enlargeView.backgroundColor = [UIColor whiteColor];
    
    [enlargeView setUp];
    
    return enlargeView;
}

- (void)setUp{
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    _maskLayer = [[CAShapeLayer alloc] init];
    _maskLayer.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 3, self.frame.size.height, self.frame.size.height-3)];
    [path fill];
    path.lineWidth = 0;
    [[UIColor redColor] set];
    _maskLayer.path = path.CGPath;
    self.layer.mask = _maskLayer;
    UIGraphicsEndImageContext();
    
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
    if (self.moveSliceDistance>self.frame.size.width) {
        return;
    }
    rect.origin.x = self.moveSliceDistance;
    _maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:rect].CGPath;
}

- (void)startAnimationWithDuration:(CGFloat)duration completion:(void (^)(BOOL finished))completion{
    
    self.duration = duration;
    self.sliceDistance = self.frame.size.width/(duration*35);
    [self startDisplay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self disposeDisplay];
        self.moveSliceDistance = 0;
        if(completion)completion(YES);
    });
}

- (void)drawRect:(CGRect)rect{
    
    NSDictionary *attar = @{NSFontAttributeName:self.font};
    [self.text drawInRect:rect withAttributes:attar];
    
}

- (void)setEnlarge:(CGFloat)enlarge{
    _enlarge = enlarge;
    self.transform = CGAffineTransformMakeScale(enlarge, enlarge);
}

@end
