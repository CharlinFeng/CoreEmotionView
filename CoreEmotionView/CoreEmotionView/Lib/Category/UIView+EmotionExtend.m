//
//  UIView+EmotionExtend.m
//  CoreEmotionView
//
//  Created by 成林 on 15/4/12.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "UIView+EmotionExtend.h"

@implementation UIView (EmotionExtend)



/*
 *  添加一组视图
 */
-(void)addSubviewsWithArray:(NSArray *)views{
    
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        
        [self addSubview:view];
    }];
}


@end
