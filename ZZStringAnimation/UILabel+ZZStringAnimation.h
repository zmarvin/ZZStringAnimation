//
//  NSString+ZZStringAnimation.h
//  ZZStringAnimation
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZAnimationSubject.h"

@interface UILabel (ZZStringAnimation)

- (void)zz_startAnimation:(ZZAnimationSubject *)animation;

- (NSArray*)linesForWidth:(CGFloat)width;

@end
