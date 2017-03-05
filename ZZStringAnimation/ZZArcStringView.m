//
//  ZZArcStringView.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/3/5.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZArcStringView.h"
#import <CoreText/CoreText.h>
#import "UIView+ZZStringAnimation.h"

typedef struct GlyphArcInfo {
    CGFloat			width;
    CGFloat			angle;	// in radians
} GlyphArcInfo;

static void PrepareGlyphArcInfo(CTLineRef line, CFIndex glyphCount, GlyphArcInfo *glyphArcInfo)
{
    NSArray *runArray = (__bridge NSArray *)CTLineGetGlyphRuns(line);
    
    // Examine each run in the line, updating glyphOffset to track how far along the run is in terms of glyphCount.
    CFIndex glyphOffset = 0;
    for (id run in runArray) {
        CFIndex runGlyphCount = CTRunGetGlyphCount((__bridge CTRunRef)run);
        
        // Ask for the width of each glyph in turn.
        CFIndex runGlyphIndex = 0;
        for (; runGlyphIndex < runGlyphCount; runGlyphIndex++) {
            glyphArcInfo[runGlyphIndex + glyphOffset].width = CTRunGetTypographicBounds((__bridge CTRunRef)run, CFRangeMake(runGlyphIndex, 1), NULL, NULL, NULL);
        }
        
        glyphOffset += runGlyphCount;
    }
    
    double lineLength = CTLineGetTypographicBounds(line, NULL, NULL, NULL);
    
    CGFloat prevHalfWidth = glyphArcInfo[0].width / 2.0;
    glyphArcInfo[0].angle = (prevHalfWidth / lineLength) * M_PI;
    
    // Divide the arc into slices such that each one covers the distance from one glyph's center to the next.
    CFIndex lineGlyphIndex = 1;
    for (; lineGlyphIndex < glyphCount; lineGlyphIndex++) {
        CGFloat halfWidth = glyphArcInfo[lineGlyphIndex].width / 2.0;
        CGFloat prevCenterToCenter = prevHalfWidth + halfWidth;
        
        glyphArcInfo[lineGlyphIndex].angle = (prevCenterToCenter / lineLength) * M_PI;
        
        prevHalfWidth = halfWidth;
    }
}

@interface ZZArcStringView ()

@property (nonatomic,weak) UIView *targetView;

@end

@implementation ZZArcStringView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _radius = 150.0;
        _showsGlyphBounds = NO;
        _showsLineMetrics = NO;
        _dimsSubstitutedGlyphs = NO;
    }
    return self;
}

- (instancetype)initWithView:(UIView *)targetView{
    self = [super init];
    if (self) {
        _targetView = targetView;
        _string = targetView.zz_viewText;
        _font = targetView.zz_viewTextFont;
    }
    return self;
}

+ (instancetype)ArcStringView:(UIView *)targetView{
    return [[ZZArcStringView alloc] initWithView:targetView];
}

- (void)drawRect:(CGRect)rect {
    // Don't draw if we don't have a font or string
    if (self.font == NULL || self.string == NULL)
        return;
    
    // Initialize the text matrix to a known value
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Draw a white background
    [[UIColor whiteColor] set];
    UIRectFill(rect);
    
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedString);
    assert(line != NULL);
    
    CFIndex glyphCount = CTLineGetGlyphCount(line);
    if (glyphCount == 0) {
        CFRelease(line);
        return;
    }
    
    GlyphArcInfo *	glyphArcInfo = (GlyphArcInfo*)calloc(glyphCount, sizeof(GlyphArcInfo));
    PrepareGlyphArcInfo(line, glyphCount, glyphArcInfo);
    
    // Move the origin from the lower left of the view nearer to its center.
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMidX(rect), CGRectGetMidY(rect) - self.radius / 2.0);
    
    // Stroke the arc in red for verification.
    CGContextBeginPath(context);
    CGContextAddArc(context, 0.0, 0.0, self.radius, M_PI, 0.0, 1);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextStrokePath(context);
    
    // Rotate the context 90 degrees counterclockwise.
    CGContextRotateCTM(context, M_PI_2);
    
    /*
     Now for the actual drawing. The angle offset for each glyph relative to the previous glyph has already been calculated; with that information in hand, draw those glyphs overstruck and centered over one another, making sure to rotate the context after each glyph so the glyphs are spread along a semicircular path.
     */
    CGPoint textPosition = CGPointMake(0.0, self.radius);
    CGContextSetTextPosition(context, textPosition.x, textPosition.y);
    
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    CFIndex runCount = CFArrayGetCount(runArray);
    
    CFIndex glyphOffset = 0;
    CFIndex runIndex = 0;
    for (; runIndex < runCount; runIndex++) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CFIndex runGlyphCount = CTRunGetGlyphCount(run);
        Boolean	drawSubstitutedGlyphsManually = false;
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        /*
         Determine if we need to draw substituted glyphs manually. Do so if the runFont is not the same as the overall font.
         */
        if (self.dimsSubstitutedGlyphs && ![self.font isEqual:(__bridge UIFont *)runFont]) {
            drawSubstitutedGlyphsManually = true;
        }
        
        CFIndex runGlyphIndex = 0;
        for (; runGlyphIndex < runGlyphCount; runGlyphIndex++) {
            CFRange glyphRange = CFRangeMake(runGlyphIndex, 1);
            CGContextRotateCTM(context, -(glyphArcInfo[runGlyphIndex + glyphOffset].angle));
            
            // Center this glyph by moving left by half its width.
            CGFloat glyphWidth = glyphArcInfo[runGlyphIndex + glyphOffset].width;
            CGFloat halfGlyphWidth = glyphWidth / 2.0;
            CGPoint positionForThisGlyph = CGPointMake(textPosition.x - halfGlyphWidth, textPosition.y);
            
            // Glyphs are positioned relative to the text position for the line, so offset text position leftwards by this glyph's width in preparation for the next glyph.
            textPosition.x -= glyphWidth;
            
            CGAffineTransform textMatrix = CTRunGetTextMatrix(run);
            textMatrix.tx = positionForThisGlyph.x;
            textMatrix.ty = positionForThisGlyph.y;
            CGContextSetTextMatrix(context, textMatrix);
            
            if (!drawSubstitutedGlyphsManually) {
                CTRunDraw(run, context, glyphRange);
            }
            else {
                /*
                 We need to draw the glyphs manually in this case because we are effectively applying a graphics operation by setting the context fill color. Normally we would use kCTForegroundColorAttributeName, but this does not apply as we don't know the ranges for the colors in advance, and we wanted demonstrate how to manually draw.
                 */
                CGFontRef cgFont = CTFontCopyGraphicsFont(runFont, NULL);
                CGGlyph glyph;
                CGPoint position;
                
                CTRunGetGlyphs(run, glyphRange, &glyph);
                CTRunGetPositions(run, glyphRange, &position);
                
                CGContextSetFont(context, cgFont);
                CGContextSetFontSize(context, CTFontGetSize(runFont));
                CGContextSetRGBFillColor(context, 0.25, 0.25, 0.25, 0.5);
                CGContextShowGlyphsAtPositions(context, &glyph, &position, 1);
                
                CFRelease(cgFont);
            }
            
            // Draw the glyph bounds
            if ((self.showsGlyphBounds) != 0) {
                CGRect glyphBounds = CTRunGetImageBounds(run, context, glyphRange);
                
                CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
                CGContextStrokeRect(context, glyphBounds);
            }
            // Draw the bounding boxes defined by the line metrics
            if ((self.showsLineMetrics) != 0) {
                CGRect lineMetrics;
                CGFloat ascent, descent;
                
                CTRunGetTypographicBounds(run, glyphRange, &ascent, &descent, NULL);
                
                // The glyph is centered around the y-axis
                lineMetrics.origin.x = -halfGlyphWidth;
                lineMetrics.origin.y = positionForThisGlyph.y - descent;
                lineMetrics.size.width = glyphWidth; 
                lineMetrics.size.height = ascent + descent;
                
                CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
                CGContextStrokeRect(context, lineMetrics);
            }
        }
        
        glyphOffset += runGlyphCount;
    }
    
    CGContextRestoreGState(context);
    
    free(glyphArcInfo);
    CFRelease(line);	
}

- (NSAttributedString *)attributedString {
    // Create an attributed string with the current font and string.
    assert(self.font != nil);
    assert(self.string != nil);
    
    // Create our attributes.
    NSDictionary *attributes = @{NSFontAttributeName: self.font, NSLigatureAttributeName: @0};
    assert(attributes != nil);
    
    // Create the attributed string.
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.string attributes:attributes];
    return attrString;
}

@end
