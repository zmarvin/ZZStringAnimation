//
//  ZZEnlargeAnimation.h
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/2/28.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZAnimationSubject.h"

@interface ZZEnlargeAnimation : ZZAnimationSubject

@property (nonatomic,assign) CGFloat enlargeMultiple;
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,strong) UIColor *lineColor;

@end
