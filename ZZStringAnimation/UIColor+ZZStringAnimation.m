//
//  UIColor+ZZStringAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/2/28.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "UIColor+ZZStringAnimation.h"

@implementation UIColor (ZZStringAnimation)
- (NSMutableArray *)zz_changeUIColorToRGB
{
    NSMutableArray *RGBStrValueArr = [[NSMutableArray alloc] init];
    NSString *RGBStr = nil;
    NSString *RGBValue = [NSString stringWithFormat:@"%@",self];
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    int r = [[RGBArr objectAtIndex:1] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",r];
    [RGBStrValueArr addObject:RGBStr];
    int g = [[RGBArr objectAtIndex:2] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",g];
    [RGBStrValueArr addObject:RGBStr];
    int b = [[RGBArr objectAtIndex:3] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",b];
    [RGBStrValueArr addObject:RGBStr];
    return RGBStrValueArr;
}
- (CGFloat)zz_red{
    NSString *RGBValue = [NSString stringWithFormat:@"%@",self];
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    CGFloat r = [[RGBArr objectAtIndex:1] floatValue] * 255;
    return r;
}
- (CGFloat)zz_green{
    NSString *RGBValue = [NSString stringWithFormat:@"%@",self];
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    CGFloat g = [[RGBArr objectAtIndex:2] floatValue] * 255;
    return g;
}
- (CGFloat)zz_blue{
    NSString *RGBValue = [NSString stringWithFormat:@"%@",self];
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    CGFloat b = [[RGBArr objectAtIndex:3] floatValue] * 255;
    return b;
}
@end
