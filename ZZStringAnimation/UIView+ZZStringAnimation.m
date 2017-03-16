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
#import "NSString+ZZStringAnimation.h"

@implementation UIView (ZZStringAnimation)

- (NSString *)zz_viewText{
    if ([self respondsToSelector:@selector(text)]) {
        return ((NSString *(*)(id, SEL))(void *) objc_msgSend)(self,@selector(text));
    }else{
        NSLog(@"not suport this view");
        return nil;
    }
}

- (NSAttributedString *)zz_viewAttributedText{
    if ([self respondsToSelector:@selector(attributedText)]) {
        return ((NSAttributedString *(*)(id, SEL))(void *) objc_msgSend)(self,@selector(attributedText));
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
    
    CGRect bounds = [viewText boundingRectWithSize:CGSizeMake(self.frame.size.width?:MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    return bounds;
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

- (NSMutableArray *)zz_linesForWidth:(CGFloat)width
{
    UIFont *font = self.zz_viewTextFont;
    CGRect rect = self.frame;
    
    NSMutableAttributedString *attStr;
    if (self.zz_viewAttributedText) {
        attStr = [self.zz_viewAttributedText mutableCopy];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attStr length])];
    } else {
        attStr = [[NSMutableAttributedString alloc] initWithString:self.zz_viewText];
        CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
        [attStr addAttribute:(NSString *)kCTFontAttributeName
                       value:(__bridge id)myFont
                       range:NSMakeRange(0, attStr.length)];
    }
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc] init];
    
    if (self.zz_viewAttributedText) {
        for (id line in lines)
        {
            CTLineRef lineRef = (__bridge CTLineRef )line;
            CFRange lineRange = CTLineGetStringRange(lineRef);
            NSRange range = NSMakeRange(lineRange.location, lineRange.length);
            NSAttributedString *lineString = [self.zz_viewAttributedText attributedSubstringFromRange:range];
            [linesArray addObject:lineString];
        }
    }else{
        for (id line in lines)
        {
            CTLineRef lineRef = (__bridge CTLineRef )line;
            CFRange lineRange = CTLineGetStringRange(lineRef);
            NSRange range = NSMakeRange(lineRange.location, lineRange.length);
            NSString *lineString = [self.zz_viewText substringWithRange:range];
            [linesArray addObject:lineString];
        }
    }
    
    return linesArray;
}

- (NSMutableArray *)zz_stringLabelsWithOrigin:(CGPoint)origin superview:(UIView *)superview
{
    UIFont *font = self.zz_viewTextFont;
    
    CGFloat xOffset = origin.x;
    CGFloat yOffset = origin.y;
    
    NSMutableArray *lineLabelsArray = [@[] mutableCopy];
    
    NSArray *lineArray = [self zz_linesForWidth:self.zz_viewTextBounds.size.width];
    
    for (NSString* line in lineArray) {
        
        NSMutableArray *lineLabels = [@[] mutableCopy];
        
        if (self.zz_viewTextAlignment == NSTextAlignmentCenter) {
            CGSize lineSize = [line zz_sizeWithFont:font];
            xOffset = origin.x + ((self.zz_viewTextBounds.size.width - lineSize.width)/2) ;
        }else{
            xOffset = origin.x;
        }
        
        for (int i = 0; i < line.length; i++) {
            
            NSString *character = [[NSString stringWithFormat:@"%@",line] substringWithRange:NSMakeRange(i, 1)];
            CGSize characterSize = [character zz_sizeWithFont:font];
            ZZCharacterLabel *characterLabel = [[ZZCharacterLabel alloc] initWithFrame:CGRectMake(xOffset,
                                                                                yOffset,
                                                                                characterSize.width,
                                                                                characterSize.height)];
            
            [characterLabel setFont:font];
            [characterLabel setTextColor:self.zz_viewTextColor];
            [characterLabel setBackgroundColor:[UIColor clearColor]];
            [characterLabel setText:character];
            [lineLabels addObject:characterLabel];
            [superview addSubview:characterLabel];
            
            xOffset += characterSize.width;
        }
        
        [lineLabelsArray addObject:lineLabels];
        yOffset += font.lineHeight;
    }
    
    int lineNumber = 0;

    for (NSArray *views in lineLabelsArray) {
        int number = 0;

        for (ZZCharacterLabel *characterLabel in views) {
            
            characterLabel.originFrame = characterLabel.frame;
            characterLabel.lineNumber = number;
            
            if (number < views.count) {
                characterLabel.next = views[number];
            }
            
            number++;

        }
#warning 未完成
        if (lineNumber == lineLabelsArray.count - 1) {
            ZZCharacterLabel *label = views.lastObject;
            label.next = lineLabelsArray[lineNumber][0];
        }
        
        lineNumber++;
        
    }
    
    return lineLabelsArray;
    
}

@end
