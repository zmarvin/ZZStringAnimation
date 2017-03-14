//
//  UIView+ZZStringAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "UIView+ZZStringAnimation.h"
#import <objc/objc-runtime.h>
#import <CoreText/CoreText.h>


@implementation UIView (ZZStringAnimation)

- (NSString *)zz_viewText{
    if ([self respondsToSelector:@selector(text)]) {
        return ((NSString *(*)(id, SEL))(void *) objc_msgSend)(self,@selector(text));
    }else{
        NSLog(@"not suport this view");
        return nil;
    }
}

- (UIFont *)zz_viewTextFont{
    if ([self respondsToSelector:@selector(font)]) {
        return ((UIFont *(*)(id, SEL))(void *) objc_msgSend)(self,@selector(font));
    }else{
        return nil;
    }
}

- (UIColor *)zz_viewTextColor{
    if ([self respondsToSelector:@selector(textColor)]) {
        return ((UIColor *(*)(id, SEL))(void *) objc_msgSend)(self,@selector(textColor));
    }else{
        return nil;
    }
}

- (CGRect)zz_viewTextBounds{
    
    NSString *viewText = [self zz_viewText];
    if (viewText == nil) return CGRectZero;
    UIFont *font = [self zz_viewTextFont];
    if (font == nil) return CGRectZero;
    NSDictionary *attr = @{NSFontAttributeName:font};
    
    return [viewText boundingRectWithSize:CGSizeMake(self.frame.size.width?:MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:attr context:nil];
}

- (NSTextAlignment)zz_viewTextAlignment{
    NSTextAlignment stringAlignment;
    if ([self respondsToSelector:@selector(textAlignment)]) {
        stringAlignment = ((NSTextAlignment (*)(id, SEL))(void *) objc_msgSend)(self,@selector(textAlignment));
    }else{
        stringAlignment = NSTextAlignmentNatural;
    }
    return stringAlignment;
}

- (CGRect)zz_viewTextFrame{
    
    NSString *viewText = [self zz_viewText];
    if (viewText == nil) return CGRectZero;
    CGRect stringBounds = [self zz_viewTextBounds];
    
    if (CGRectEqualToRect(CGRectZero, stringBounds)) return CGRectZero;
    
    NSTextAlignment stringAlignment = self.zz_viewTextAlignment;
    
    CGFloat stringX = 0;
    CGFloat stringH = stringBounds.size.height;
    CGFloat stringY = (self.frame.size.height - stringH)*0.5;
    CGFloat stringW = stringBounds.size.width;
    
    switch (stringAlignment) {
        case NSTextAlignmentNatural:
        case NSTextAlignmentLeft:
        case NSTextAlignmentJustified:
            stringX = 0;
            break;
        case NSTextAlignmentCenter:
            stringX = (self.frame.size.width - stringW)*0.5;
            break;
        case NSTextAlignmentRight:
            stringX = self.frame.size.width - stringW;
            break;
    }
    
    return CGRectMake(stringX, stringY, stringW, stringH);
}

- (BOOL)isSupportZZAnimation{
    
    NSString *viewText = [self zz_viewText];
    UIFont *viewTextFont = [self zz_viewTextFont];
    UIColor *viewTextColor = [self zz_viewTextColor];
    
    if (viewText && viewTextFont && viewTextColor) {
        return YES;
    }
    return NO;
}

- (CGRect)zz_viewTextFrame1{
    
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    NSDictionary *attar = @{
                            NSFontAttributeName:self.zz_viewTextFont,
                            NSForegroundColorAttributeName:self.zz_viewTextColor,
                            };
    NSAttributedString * atString = [[NSAttributedString alloc] initWithString:self.zz_viewText attributes:attar];

    // layout master
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(
                                                                           (CFAttributedStringRef)atString);
    CGMutablePathRef Path = CGPathCreateMutable();
    
    //坐标点在左下角
    CGPathAddRect(Path, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    CFArrayRef Lines = CTFrameGetLines(frame);
    
    CFIndex linecount = CFArrayGetCount(Lines);
    
    CGPoint origins[linecount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    NSInteger lineIndex = 0;
    
    CTLineRef firstLine = CFArrayGetValueAtIndex(Lines, 0);
    
    CGPoint firstOriginPoint = origins[0];
    CGRect lineBounds = CTLineGetImageBounds((CTLineRef)firstLine, ctx);
    
    CGRect result = CGRectMake(firstOriginPoint.x, firstOriginPoint.y - lineBounds.size.height, lineBounds.size.width, lineBounds.size.height);
    
    for (id oneLine in (__bridge NSArray *)Lines)
    {
        CGRect lineBounds = CTLineGetImageBounds((CTLineRef)oneLine, ctx);
        
        lineBounds.origin.x += origins[lineIndex].x;
        lineBounds.origin.y += origins[lineIndex].y;
        
        lineIndex++;
        //画长方形
        
        //设置颜色，仅填充4条边
        CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
        //设置线宽为1
        CGContextSetLineWidth(ctx, 1.0);
        //设置长方形4个顶点
        CGPoint poins[] = {
            CGPointMake(lineBounds.origin.x, lineBounds.origin.y),
            CGPointMake(lineBounds.origin.x+lineBounds.size.width, lineBounds.origin.y),
            CGPointMake(lineBounds.origin.x+lineBounds.size.width, lineBounds.origin.y+lineBounds.size.height),
            CGPointMake(lineBounds.origin.x, lineBounds.origin.y+lineBounds.size.height)
        };
        
        CGContextAddLines(ctx,poins,4);
        CGContextClosePath(ctx);
        CGContextStrokePath(ctx);
        
    }
    
    CTFrameDraw(frame,ctx);
    CGPathRelease(Path);
    CFRelease(framesetter);
    
    UIGraphicsEndImageContext();
    return result;
}

@end
