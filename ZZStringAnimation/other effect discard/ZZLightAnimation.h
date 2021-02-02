//
//  ZZLightAnimation.h
//  ZZStringAnimation
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZAnimation.h"

@interface ZZLightAnimation : ZZAnimation

@property (nonatomic,assign) CGFloat angle;

@property (nonatomic,assign) CGFloat alpha;

@property (nonatomic,assign) CGFloat animationViewWidth;

@property (nonatomic,strong) UIColor *color;

@end
