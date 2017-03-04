//
//  ZZEnlargeView.h
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/3/2.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZEnlargeView : UIView

+ (instancetype)enlargeViewWithView:(UIView *)view;

@property (nonatomic,assign) CGFloat enlarge;

@property (nonatomic,assign) CGFloat lineWidth;

@property (nonatomic,strong) UIColor *lineColor;

- (void)startAnimationWithDuration:(CGFloat)duration completion:(void (^)(BOOL finished))completion;


@end
