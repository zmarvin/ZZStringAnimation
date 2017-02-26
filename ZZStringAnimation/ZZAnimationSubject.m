//
//  ZZStringSubject.m
//  ZZStringAnimation
//
//  Created by zz on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZAnimationSubject.h"

@interface ZZAnimationSubject ()

@end

@implementation ZZAnimationSubject

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (void)zz_startAnimationWithView:(UIView *)view{
    NSCAssert(NO, @"This method must be overridden by subclasses");
}

@end
