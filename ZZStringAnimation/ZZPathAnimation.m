//
//  ZZPathAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/5.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZPathAnimation.h"
#import "UIView+ZZStringAnimation.h"
#import "UILabel+ZZStringAnimation.h"

@interface ZZPathAnimation ()<CAAnimationDelegate>

@property (nonatomic,weak  ) UIView *targetView;

@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) NSMutableArray *lineLabelsArray;
@property (nonatomic, strong) CAKeyframeAnimation *animation;
@end

@implementation ZZPathAnimation
@synthesize targetView = _targetView;

- (void)zz_startAnimationWithView:(UIView *)targetView{
    
    self.targetView = targetView;
    self.targetView.hidden = YES;
    
    CGRect frame = [self.targetView convertRect:self.targetView.zz_viewTextFrame toView:self.targetView.superview];
    
    _lineLabelsArray = [self.targetView zz_stringLabelsWithOrigin:frame.origin superview:targetView.superview];
    
    self.labelArray = [@[] mutableCopy];

    for (NSArray *labels in self.lineLabelsArray) {
        [self.labelArray addObjectsFromArray:labels];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = self.path.CGPath;
    animation.duration = self.duration;
    animation.autoreverses = YES;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    _animation = animation;
    
    CGFloat unitTime = self.duration/self.labelArray.count;
    
    int index = 0;
    num = 0;
    for (ZZCharacterLabel *label in self.labelArray) {
        
        [self performSelector:@selector(gradualShow:) withObject:label afterDelay:unitTime *index];
        
        index++;
    }
    
}

- (void)gradualShow:(ZZCharacterLabel *)label{
    [label.layer addAnimation:_animation forKey:@"pathAnimation"];
}

static int num = 0;
- (void)animationDidStart:(CAAnimation *)anim{

}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    num++;
    if (num == self.labelArray.count -1) {
        
        for (ZZCharacterLabel *label in self.labelArray) {
            [label removeFromSuperview];
        }
        
        [self.labelArray removeAllObjects];
        self.targetView.hidden = NO;
        num = 0;
    }
    
}


@end
