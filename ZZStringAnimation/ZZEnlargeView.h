//
//  ZZEnlargeView.h
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/2.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZEnlargeView : UIView

+ (instancetype)enlargeView:(UIView *)targetView;

@property (nonatomic,assign) CGFloat enlarge;

- (void)startAnimationWithDuration:(CGFloat)duration;

@end
