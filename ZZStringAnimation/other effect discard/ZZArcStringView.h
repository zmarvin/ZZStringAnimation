//
//  ZZArcStringView.h
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/5.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZArcStringView : UIView

+ (instancetype)ArcStringView:(UIView *)targetView;
@property (nonatomic,strong) UIBezierPath *path;

@property (nonatomic) UIFont *font;
@property (nonatomic) NSString *string;
@property (readonly, nonatomic) NSAttributedString *attributedString;
@property (nonatomic) CGFloat radius;
@property (nonatomic) BOOL showsGlyphBounds;
@property (nonatomic) BOOL showsLineMetrics;
@property (nonatomic) BOOL dimsSubstitutedGlyphs;

@end
