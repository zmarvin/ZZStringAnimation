//
//  UITextField+ZZStringAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "UITextField+ZZStringAnimation.h"

@implementation UITextField (ZZStringAnimation)

- (void)zz_startAnimation:(ZZAnimationSubject *)animation{
    
    [animation zz_startAnimationWithView:self];
}

@end
