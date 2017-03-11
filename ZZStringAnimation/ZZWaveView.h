//
//  ZZWaveView.h
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/3/12.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZWaveView : UIView

+ (instancetype)waveView:(UIView *)targetView;
- (void)zz_startAnimationWithDuration:(CGFloat)duration;
- (void)zz_stopAnimation;
@end
