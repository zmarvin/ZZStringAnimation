//
//  ZZStringSubject.h
//  ZZStringAnimation
//
//  Created by zmarvin on 2017/2/26.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZAnimationSubject : NSObject

@property (nonatomic,weak  ,readonly) UIView *targetView;

@property (nonatomic,assign) CGFloat duration;

@property (nonatomic,assign) CGFloat repeatTimeInterval;

@property (nonatomic,assign) BOOL repeat;

- (void)zz_startAnimationWithView:(UIView *)targetView;

- (void)fireTimerKeepAlive;

- (void)stopTimerResignAlive;

@end
