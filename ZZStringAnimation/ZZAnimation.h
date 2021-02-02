//
//  ZZAnimation.h
//  ZZStringAnimation
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZAnimation : NSObject

@property (nonatomic,weak  ,readonly) UIView *targetView;

@property (nonatomic,assign) NSTimeInterval duration;

@property (nonatomic,assign) NSTimeInterval delay;

@property (nonatomic,assign) CGFloat repeatTimeInterval;

@property (nonatomic,assign) BOOL repeat;

- (void)zz_startAnimationWithView:(UIView *)targetView;

@end
