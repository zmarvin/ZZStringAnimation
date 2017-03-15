//
//  UIView+ZZStringAnimation.h
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZCharacterLabel.h"

@interface UIView (ZZStringAnimation)

- (BOOL)isSupportZZAnimation;

- (NSString *)zz_viewText;
- (NSAttributedString *)zz_viewAttributedText;
- (UIFont *)zz_viewTextFont;
- (CGRect)zz_viewTextBounds;
- (CGRect)zz_viewTextFrame;
- (UIColor *)zz_viewTextColor;
- (NSTextAlignment)zz_viewTextAlignment;
- (NSMutableArray *)zz_linesForWidth:(CGFloat)width;
- (NSMutableArray <ZZCharacterLabel *>*)zz_stringLabelsWithOrigin:(CGPoint)origin  superview:(UIView *)superview;

@end
