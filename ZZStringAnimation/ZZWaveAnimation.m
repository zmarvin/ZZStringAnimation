//
//  ZZWaveAnimation.m
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/4.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import "ZZWaveAnimation.h"

@interface ZZWaveAnimation ()

@property (nonatomic,strong) CADisplayLink *link;

@end

@implementation ZZWaveAnimation

- (void)zz_startAnimationWithView:(UIView *)targetView{
    
    
}

- (void)startDisplay{
    if (_link) return;
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(display)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)disposeDisplay{
    [_link invalidate];
    _link = nil;
}


@end
