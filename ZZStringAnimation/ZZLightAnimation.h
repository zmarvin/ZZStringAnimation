//
//  ZZLightAnimation.h
//  ZZStringAnimation
//
//  Created by zz on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZAnimationSubject.h"

@interface ZZLightAnimation : ZZAnimationSubject

@property (nonatomic,assign) CGFloat alpha;

@property (nonatomic,assign) CGFloat duration;

@property (nonatomic,assign) BOOL repeat; // 0 is infinity repeat，default 1，

@property (nonatomic,assign) CGFloat animationViewWidth;

@property (nonatomic,strong) UIColor *color;

@end
