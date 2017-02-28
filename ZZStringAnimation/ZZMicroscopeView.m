//
//  ZZMicroscopeView.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/2/28.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZMicroscopeView.h"
#import "UIColor+ZZStringAnimation.h"

@implementation ZZMicroscopeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineWidth = 5;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat r = [self.lineColor zz_red];
    CGFloat b = [self.lineColor zz_blue];
    CGFloat g = [self.lineColor zz_green];

    CGContextRef tex = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(tex,_lineWidth);//线宽
    CGContextSetRGBStrokeColor(tex,r/250,g/250,b/250,1);//颜色
    
    CGContextAddEllipseInRect(tex,CGRectMake(0.5*_lineWidth,0.5*_lineWidth,rect.size.width-_lineWidth,rect.size.height-_lineWidth));

    CGContextStrokePath(tex);
    
//    CGContextAddEllipseInRect(tex,CGRectMake(_lineWidth,_lineWidth,rect.size.width,rect.size.height));
//    CGContextSetRGBFillColor(tex,100.0/250,200.0/250,100.0/250,0);
//    CGContextFillPath(tex);
}

@end
