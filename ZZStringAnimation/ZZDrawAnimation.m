//
//  ZZDrawAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/3.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZDrawAnimation.h"
#import "UIView+ZZStringAnimation.h"
#import <CoreText/CoreText.h>

@interface ZZDrawAnimation ()<CAAnimationDelegate>

@property (nonatomic,weak  ) UIView *targetView;
@property (nonatomic,strong) CAShapeLayer *pathLayer;

@end

@implementation ZZDrawAnimation
@synthesize targetView = _targetView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pathLayer = [[CAShapeLayer alloc] init];
        self.duration = 2;
    }
    return self;
}

- (void)zz_startAnimationWithView:(UIView *)targetView{
    _targetView = targetView;
    
    UIBezierPath *path = [self bezierPathWithString:targetView.zz_viewText];
    _pathLayer.bounds = CGPathGetPathBoundingBox(path.CGPath);
    _pathLayer.frame = [targetView.layer convertRect:targetView.zz_viewTextFrame toLayer:targetView.superview.layer];
;

    _pathLayer.contentsScale = [UIScreen mainScreen].scale;
    _pathLayer.strokeColor = self.targetView.zz_viewTextColor.CGColor;
    _pathLayer.geometryFlipped = YES;
    _pathLayer.path = path.CGPath;
    _pathLayer.fillColor = nil;
    [_targetView.superview.layer addSublayer:_pathLayer];
  
    CABasicAnimation * textAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    textAnimation.duration = self.duration;
    textAnimation.fromValue = [NSNumber numberWithFloat:0];
    textAnimation.toValue = [NSNumber numberWithFloat:1];
    textAnimation.delegate = self;
    [_pathLayer addAnimation:textAnimation forKey:@"strokeEnd"];
}

- (void)animationDidStart:(CAAnimation *)anim{
    _targetView.hidden = YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_pathLayer removeAllAnimations];
    [_pathLayer removeFromSuperlayer];
    _targetView.hidden = NO;
}

- (UIBezierPath *)bezierPathWithString:(NSString *)string {
    
    CGMutablePathRef letters = CGPathCreateMutable();

    CTFontRef font = (__bridge CTFontRef)(self.targetView.zz_viewTextFont);
    
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           
                           (__bridge id)font, kCTFontAttributeName,
                           @-1,kCTStrokeWidthAttributeName,
                           self.targetView.zz_viewTextColor.CGColor,kCTStrokeColorAttributeName,
                           self.targetView.zz_viewTextColor.CGColor,kCTForegroundColorAttributeName,
                           nil];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    // for each run
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {
        // Get Font for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLyph in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) {
            // get Glyph & Glyph-data
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            // Get path of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    
    CFRelease(line);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    return path;
}

@end
