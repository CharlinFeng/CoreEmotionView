//
//  EmotionAttachment.h
//  CoreEmotionView
//
//  Created by 冯成林 on 15/4/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmotionModel;

@interface EmotionAttachment : NSTextAttachment


/*
 *  表情模型
 */
@property (nonatomic,strong) EmotionModel *emotionModel;

@end
