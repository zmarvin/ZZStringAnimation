//
//  NSString+ZZStringAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/6.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "NSString+ZZStringAnimation.h"

@implementation NSString (ZZStringAnimation)

- (CGSize)zz_sizeWithFont:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}

@end
