//
//  UITextField+Emotion.h
//  CoreEmotionView
//
//  Created by 冯成林 on 15/4/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmotionModel;

@interface UITextField (Emotion)



/**
 *  插入一个表情
 *
 *  @param emotionModel 表情模型
 */
-(void)insertEmotionWithModel:(EmotionModel *)emotionModel;



@end
