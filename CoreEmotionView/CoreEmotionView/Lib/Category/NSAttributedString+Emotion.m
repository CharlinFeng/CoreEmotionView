//
//  NSAttributedString+Emotion.m
//  CoreEmotionView
//
//  Created by 冯成林 on 15/4/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "NSAttributedString+Emotion.h"
#import "EmotionAttachment.h"
#import "EmotionModel.h"

@implementation NSAttributedString (Emotion)




/*
 *  带有样式的文字对应的普通文本
 */
-(NSString *)emotionNormalText{
    
    NSMutableString *fullText = [NSMutableString string];
    
    // 遍历所有的属性文字（图片、emoji、普通文字）
    [self enumerateAttributesInRange:NSMakeRange(0, self.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        // 如果是图片表情
        EmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) { // 图片
            [fullText appendString:attch.emotionModel.chs];
        } else { // emoji、普通文本
            // 获得这个范围内的文字
            NSAttributedString *str = [self attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    
    return fullText;
}














@end
