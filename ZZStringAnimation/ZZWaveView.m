//
//  ZZWaveView.m
//  ZZStringAnimationDemo
//
//  Created by zz on 2017/3/12.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZWaveView.h"
#import "UIView+ZZStringAnimation.h"
#import "UILabel+ZZStringAnimation.h"
#import "NSString+ZZStringAnimation.h"

@interface ZZWaveView ()

@property (nonatomic, assign) CGFloat frequency;
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveMid;
@property (nonatomic, assign) CGFloat maxAmplitude;
@property (nonatomic, assign) CGFloat phaseShift;
@property (nonatomic, assign) CGFloat phase;

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, weak  ) UIView *targetView;

@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) NSMutableArray *lineLabelsArray;

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) UIViewAnimationOptions options;

@end

@implementation ZZWaveView

+ (instancetype)waveView:(UIView *)targetView{
    
    return [[ZZWaveView alloc] initWithView:targetView];
}

- (instancetype)initWithView:(UIView *)targetView{
    self = [super init];
    
    if (self) {
        
        self.targetView = targetView;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    
    self.frame = [self.targetView convertRect:self.targetView.zz_viewTextFrame toView:self.targetView.superview];
    
    _lineLabelsArray = [self.targetView zz_stringLabelsWithOrigin:self.frame.origin superview:self.targetView.superview];
    
    self.labelArray = [@[] mutableCopy];
    
    for (NSArray *labels in self.lineLabelsArray) {
        [self.labelArray addObjectsFromArray:labels];
    }
    
    self.waveHeight = CGRectGetHeight(self.bounds) * 0.5;
    self.waveWidth  = CGRectGetWidth(self.bounds);
    
    self.frequency = .5;
    self.phaseShift = 8;
    self.waveMid = self.waveWidth / 2.0f;
    self.maxAmplitude = self.waveHeight;
    
}

- (void)zz_startAnimationWithDuration:(CGFloat)duration{
    
    if (_link) return;
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(display)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)zz_stopAnimation{
    
    [_link invalidate];
    _link = nil;

    while (self.labelArray.count>0) {
        
        UILabel *label = self.labelArray[0];
        [label removeFromSuperview];
        [self.labelArray removeObject:label];
    }
}

- (void)display{
    
    self.phase += self.phaseShift;
    int index = 0;
    CGFloat LabelOriginHeight = 0;
    for (NSArray *array in self.lineLabelsArray) {
        ZZCharacterLabel *label = array[index];
        LabelOriginHeight = label.originFrame.origin.y;

        for (UILabel*character in array) {
            
            CGFloat y = self.maxAmplitude * sinf(360.0 / _waveWidth * (character.center.x  * M_PI / 180) * self.frequency + self.phase * M_PI/ 180) + self.maxAmplitude + LabelOriginHeight;
            character.center = CGPointMake(character.center.x,y);
            
        }
        
        index++;

        
    }
    
    
}

@end
