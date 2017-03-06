//
//  ZZGradientAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/3/6.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZGradualAnimation.h"
#import "UIView+ZZStringAnimation.h"
#import <CoreText/CoreText.h>

@interface ZZGradualAnimation ()

@property (nonatomic,weak  ) UIView *targetView;
@property (nonatomic,strong) NSMutableArray *numArr;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) CATextLayer *textLayer;
@property (nonatomic,assign) CGFloat timeInterval;

@end

@implementation ZZGradualAnimation
@synthesize targetView = _targetView;

- (void)zz_startAnimationWithView:(UIView *)targetView{
    self.targetView = targetView;
    
    targetView.hidden = YES;
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = [self.targetView.layer convertRect:targetView.zz_viewTextFrame toLayer:targetView.superview.layer];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    NSString *alignmentMode = kCAAlignmentLeft;
    
    switch (targetView.zz_viewTextAlignment) {
        case NSTextAlignmentLeft:
            alignmentMode = kCAAlignmentLeft;
            break;
        case NSTextAlignmentCenter:
            alignmentMode = kCAAlignmentCenter;

            break;
        case NSTextAlignmentRight:
            alignmentMode = kCAAlignmentRight;

            break;
        case NSTextAlignmentJustified:
            alignmentMode = kCAAlignmentJustified;

            break;
        case NSTextAlignmentNatural:
            alignmentMode = kCAAlignmentNatural;

            break;
    }
    textLayer.alignmentMode = alignmentMode;
    textLayer.wrapped = NO;
    _textLayer = textLayer;
    [self.targetView.superview.layer addSublayer:textLayer];

    UIFont *font = self.targetView.zz_viewTextFont;
    NSString *str = self.targetView.zz_viewText;
    
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:str];
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor whiteColor].CGColor,
                              (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                              };
    [string setAttributes:attribs range:NSMakeRange(0, str.length)];
    
    _dataArr = [NSMutableArray arrayWithObjects:(__bridge id _Nonnull)(fontRef),attribs,string,str,textLayer, nil];
    _numArr = [NSMutableArray array];
    
    _timeInterval = self.duration/(CGFloat)str.length;
    for (int i = 0; i < str.length; i++) {
        [_numArr addObject:[NSNumber numberWithInt:i]];
        [self performSelector:@selector(gradualShow) withObject:nil afterDelay:_timeInterval * i];
    }
    CFRelease(fontRef);
}

- (void)gradualShow{
    
    CTFontRef fontRef = (__bridge CTFontRef)(_dataArr[0]);
    NSMutableAttributedString *string = _dataArr[2];
    NSNumber *num = [_numArr firstObject];
    int y = [num intValue];
    NSDictionary *attribs = _dataArr[1];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName:(__bridge id)self.targetView.zz_viewTextColor.CGColor,
                (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(y, 1)];
    if (_numArr.count >= 1) {
        [_numArr removeObjectAtIndex:0];
    }
    CATextLayer *textLayer = [_dataArr lastObject];
    textLayer.string = string;

    if (self.numArr.count == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_textLayer removeFromSuperlayer];
            _targetView.hidden = NO;
        });

    }
}


@end
