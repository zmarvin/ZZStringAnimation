//
//  ZZCharacterLabel.h
//  ZZStringAnimationDemo
//
//  Created by zmarvin on 2017/3/15.
//  Copyright © 2017年 zmarvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZCharacterLabel : UILabel

@property (nonatomic,assign) CGRect originFrame;

@property (nonatomic,assign) int lineNumber;

@property (nonatomic,strong) ZZCharacterLabel *next;

@end
