//
//  NSString+ZZStringAnimation.m
//  ZZStringAnimation
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "UILabel+ZZStringAnimation.h"

@implementation UILabel (ZZStringAnimation)

- (void)zz_startAnimation:(ZZAnimationSubject *)animation{
    
    [animation zz_startAnimationWithView:self];
}

@end
