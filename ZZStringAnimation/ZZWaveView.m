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

@property (nonatomic, strong) NSArray *lineArray;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) NSMutableArray *lineLabelsArray;

@property (nonatomic,assign) CGFloat duration;
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

    UILabel *label = (UILabel *)self.targetView;
    _lineArray = [label linesForWidth:self.targetView.zz_viewTextBounds.size.width];
    
    self.waveHeight = CGRectGetHeight(self.bounds) * 0.5;
    self.waveWidth  = CGRectGetWidth(self.bounds);
    
    self.frequency = .5;
    self.phaseShift = 8;
    self.waveMid = self.waveWidth / 2.0f;
    self.maxAmplitude = self.waveHeight;
    
}
static CGFloat originHeight[];

- (void)createStringLabels
{
    CGPoint originPosition = self.frame.origin;
    
    UIFont *font = self.targetView.zz_viewTextFont;

    CGFloat xOffset = originPosition.x;
    CGFloat yOffset = originPosition.y;
    
    self.lineLabelsArray = [@[] mutableCopy];
    
    for (NSString* line in self.lineArray) {
        
        NSMutableArray *lineLabels = [@[] mutableCopy];
        
        if (self.targetView.zz_viewTextAlignment == NSTextAlignmentCenter) {
            CGSize lineSize = [line zz_sizeWithFont:self.targetView.zz_viewTextFont];
            xOffset = originPosition.x + ((self.targetView.zz_viewTextBounds.size.width - lineSize.width)/2) ;
        }else{
            xOffset = originPosition.x;
        }
        
        for (int i = 0; i < line.length; i++) {
            
            NSString*character = [[NSString stringWithFormat:@"%@",line] substringWithRange:NSMakeRange(i, 1)];
            CGSize characterSize = [character zz_sizeWithFont:font];
            
            UILabel *characterLabel = [[UILabel alloc] initWithFrame:CGRectMake(xOffset,
                                                                               yOffset,
                                                                               characterSize.width,
                                                                               characterSize.height)];
            
            [characterLabel setFont:font];
            [characterLabel setTextColor:self.targetView.zz_viewTextColor];
            [characterLabel setBackgroundColor:[UIColor clearColor]];
            [characterLabel setText:character];
            [lineLabels addObject:characterLabel];
            [self.targetView.superview addSubview:characterLabel];
            
            xOffset += characterSize.width;
        }
        
        [self.lineLabelsArray addObject:lineLabels];
        yOffset += font.pointSize;
    }
    
    self.labelArray = [@[] mutableCopy];

    for (NSArray *labels in self.lineLabelsArray) {
        [self.labelArray addObjectsFromArray:labels];
        NSUInteger index = [self.lineLabelsArray indexOfObject:labels];
        UILabel *label = (UILabel *)labels[0];
        originHeight[index] = label.frame.origin.y;
    }
    
}

- (UIBezierPath *)createWavePath
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat endX = 0;
    for (CGFloat x = 0; x < self.waveWidth + 1; x += 1) {
        endX = x;
        
        CGFloat y = self.maxAmplitude * sinf(360.0 / _waveWidth * (x  * M_PI / 180) * self.frequency + self.phase * M_PI/ 180) + self.maxAmplitude;
        
        if (x == 0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        } else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
        
    }
    
    CGFloat endY = CGRectGetHeight(self.bounds) + 10;
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    
    UIGraphicsEndImageContext();
    
    return wavePath;
}

- (void)zz_startAnimationWithDuration:(CGFloat)duration{
    
    [self createStringLabels];
    
    [self startDisplay];
    
//    CGPoint position = self.waveSinLayer.position;
//    position.y = position.y - self.bounds.size.height*0.5;
//    self.waveSinLayer.position = position;
}

- (void)zz_stopAnimation{
    
    [_link invalidate];
    _link = nil;
    self.lineArray = nil;
    while (self.labelArray.count>0) {
        
        UILabel *label = self.labelArray[0];
        [label removeFromSuperview];
        [self.labelArray removeObject:label];
    }
}

- (void)startDisplay{
    if (_link) return;
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(display)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)display{
    
    self.phase += self.phaseShift;
    int index = 0;
    CGFloat LabelOriginHeight = 0;
    for (NSArray *array in self.lineLabelsArray) {
        
        LabelOriginHeight = originHeight[index];
        
        for (UILabel*character in array) {
            CGFloat y = self.maxAmplitude * sinf(360.0 / _waveWidth * (character.center.x  * M_PI / 180) * self.frequency + self.phase * M_PI/ 180) + self.maxAmplitude + LabelOriginHeight;
            character.center = CGPointMake(character.center.x,y);
        }
        
        index++;
    }
    
    
}

@end
