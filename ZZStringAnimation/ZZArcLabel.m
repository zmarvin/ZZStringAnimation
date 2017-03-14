//
//  ZZArcLabel.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/7.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZArcLabel.h"
#import <CoreText/CoreText.h>
#import <CoreText/CTFrame.h>
#import "UIView+ZZStringAnimation.h"

@implementation ZZArcLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    NSDictionary *attar = @{
                            NSFontAttributeName:self.font,
                            NSForegroundColorAttributeName:self.textColor,
                            NSBackgroundColorAttributeName:self.backgroundColor
                            };
//    CGFloat y = 0.5*(self.frame.size.height - self.zz_viewTextBounds.size.height);
//    [self.text drawInRect:CGRectMake(0, y, rect.size.width, rect.size.height) withAttributes:attar];
    
//    NSAttributedString *content = [[NSAttributedString alloc] initWithString:self.text attributes:attar];
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 320, 400)];
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)content);
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), [path CGPath] , NULL);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CTFrameDraw(frame, ctx);
    
//    [super drawRect:rect];
    
//    [self drawBounds];
    
    [self drawdfsd];
}

- (void)drawdfsd{
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Prepare font
    CGFloat s = 18;
    CTFontRef ctfont = CTFontCreateWithName(CFSTR("STHeitiSC-Medium"), 18, NULL);
    CGColorRef ctColor = [[UIColor greenColor] CGColor];
    
    // Create an attributed string
    CFStringRef keys[] = { kCTFontAttributeName,kCTForegroundColorAttributeName };
    CFTypeRef values[] = { ctfont,ctColor};
    CFDictionaryRef attr = CFDictionaryCreate(NULL, (const void **)&keys, (const void **)&values,
                                              sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    
    CFStringRef ctStr = CFStringCreateWithCString(nil, [self.text UTF8String], kCFStringEncodingUTF8);
    CFAttributedStringRef attrString = CFAttributedStringCreate(NULL,ctStr, attr);
    CTLineRef line = CTLineCreateWithAttributedString(attrString);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //CGContextSetTextMatrix(context, CGAffineTransformMakeRotation(3.14));
    //CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0)); //Use this one if the view's coordinates are flipped
    CGContextSetTextPosition(context, s, s);
    CTLineDraw(line, context);
    CFRelease(line);
    CFRelease(attrString);
    CFRelease(ctStr);
    
//    CFStringRef ctStr2 = CFStringCreateWithCString(nil, [@"sYfdasfsfsdfdf" UTF8String], kCFStringEncodingUTF8);
//    CFAttributedStringRef attrString2 = CFAttributedStringCreate(NULL,ctStr2, attr);
//    CTLineRef line2 = CTLineCreateWithAttributedString(attrString2);
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextSetTextPosition(context, s, 2*s);
//    CTLineDraw(line2, context);
    
//    CFRelease(line2);
//    CFRelease(attrString2);
//    CFRelease(ctStr2);
//    
//    CFStringRef ctStr3 = CFStringCreateWithCString(nil, [@"sZfajlfjdsklfajk" UTF8String], kCFStringEncodingUTF8);
//    CFAttributedStringRef attrString3 = CFAttributedStringCreate(NULL,ctStr3, attr);
//    CTLineRef line3 = CTLineCreateWithAttributedString(attrString3);
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextSetTextPosition(context, s, 3*s);
//    CTLineDraw(line3, context);
//    
//    CFRelease(line3);
//    CFRelease(attrString3);
//    CFRelease(ctStr3);
    
    // Clean up
    CFRelease(attr);
    CFRelease(ctfont);
}

-(void)drawBounds
{
    
    NSDictionary *attar = @{
                            NSFontAttributeName:self.font,
                            NSForegroundColorAttributeName:self.textColor,
                            NSBackgroundColorAttributeName:self.backgroundColor
                            };
    
    NSAttributedString * string = [[NSAttributedString alloc] initWithString:self.text attributes:attar];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(ctx , CGAffineTransformIdentity);
    
    //CGContextSaveGState(ctx);
    
    //x，y轴方向移动
    CGContextTranslateCTM(ctx , 0 ,self.bounds.size.height);
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(ctx, 1.0 ,-1.0);
    
    // layout master
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(
                                                                           (CFAttributedStringRef)string);
    CGMutablePathRef Path = CGPathCreateMutable();
    
    //坐标点在左下角
    CGPathAddRect(Path, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    CFArrayRef Lines = CTFrameGetLines(frame);
    
    CFIndex linecount = CFArrayGetCount(Lines);
    
    CGPoint origins[linecount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    NSInteger lineIndex = 0;
    
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
}




@end
