//
//  UITextField+Emotion.m
//  CoreEmotionView
//
//  Created by 冯成林 on 15/4/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "UITextField+Emotion.h"
#import "EmotionModel.h"
#import "NSString+Emoji.h"

@implementation UITextField (Emotion)




/**
 *  插入一个表情
 *
 *  @param emotionModel 表情模型
 */
-(void)insertEmotionWithModel:(EmotionModel *)emotionModel{

    if(emotionModel.code !=nil){//Emoji
        
        [self insertText:emotionModel.code.emoji];
        
    }else{//普通表情
        
        [self insertText:emotionModel.chs];
    }
}



@end
