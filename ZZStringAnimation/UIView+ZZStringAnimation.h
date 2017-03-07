//
//  UIView+ZZStringAnimation.h
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZZStringAnimation)

- (BOOL)isSupportAnimation;

- (NSString *)zz_viewText;
- (UIFont *)zz_viewTextFont;
- (CGRect)zz_viewTextBounds;
- (CGRect)zz_viewTextFrame;
- (UIColor *)zz_viewTextColor;
- (NSTextAlignment)zz_viewTextAlignment;

@end
