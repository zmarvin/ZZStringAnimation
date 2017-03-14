//
//  NSString+ZZStringAnimation.m
//  ZZStringAnimation
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "UILabel+ZZStringAnimation.h"
#import <CoreText/CoreText.h>

@implementation UILabel (ZZStringAnimation)

- (void)zz_startAnimation:(ZZAnimationSubject *)animation{
    
    [animation zz_startAnimationWithView:self];
}

- (NSArray*)zz_linesForWidth:(CGFloat)width
{
    
    UIFont *font = self.font;
    CGRect rect = self.frame;
    
    NSMutableAttributedString *attStr;
    if (self.attributedText) {
        attStr = [self.attributedText mutableCopy];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attStr length])];
    } else {
        attStr = [[NSMutableAttributedString alloc] initWithString:self.text];
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
    
    if (self.attributedText) {
        for (id line in lines)
        {
            CTLineRef lineRef = (__bridge CTLineRef )line;
            CFRange lineRange = CTLineGetStringRange(lineRef);
            NSRange range = NSMakeRange(lineRange.location, lineRange.length);
            NSAttributedString *lineString = [self.attributedText attributedSubstringFromRange:range];
            [linesArray addObject:lineString];
        }
    }else{
        for (id line in lines)
        {
            CTLineRef lineRef = (__bridge CTLineRef )line;
            CFRange lineRange = CTLineGetStringRange(lineRef);
            NSRange range = NSMakeRange(lineRange.location, lineRange.length);
            NSString *lineString = [self.text substringWithRange:range];
            [linesArray addObject:lineString];
        }
    }
    
    return (NSArray *)linesArray;
}

@end
