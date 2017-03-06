//
//  UIView+ZZStringAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "UIView+ZZStringAnimation.h"
#import <objc/objc-runtime.h>

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
    
    return [viewText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
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

- (BOOL)isSupportAnimation{
    
    NSString *viewText = [self zz_viewText];
    UIFont *viewTextFont = [self zz_viewTextFont];
    UIColor *viewTextColor = [self zz_viewTextColor];
    
    if (viewText && viewTextFont && viewTextColor) {
        return YES;
    }
    return NO;
}

@end
