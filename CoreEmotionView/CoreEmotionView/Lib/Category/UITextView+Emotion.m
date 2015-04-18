//
//  UITextView+Emotion.m
//  CoreEmotionView
//
//  Created by 冯成林 on 15/4/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "UITextView+Emotion.h"
#import "EmotionModel.h"
#import "NSString+EmotionExtend.h"
#import "EmotionAttachment.h"
#import "NSString+Emoji.h"


@implementation UITextView (Emotion)

/**
 *  插入一个表情
 *
 *  @param emotionModel 表情模型
 */
-(void)insertEmotionWithModel:(EmotionModel *)emotionModel{
    
    //取出code
    NSString *code = emotionModel.code;
    
    if(code !=nil){//Emoji
        
        [self insertText:code.emoji];
        
    }else{//普通表情
        
        //新建可变字符串
        NSMutableAttributedString *maStr = [[NSMutableAttributedString alloc] init];
        
        //添加之前的
        [maStr appendAttributedString:self.attributedText];
        
        //新建附件
        EmotionAttachment *attachment = [[EmotionAttachment alloc] init];
        
        //新建图片
        UIImage *image = [UIImage imageNamed:emotionModel.png.emotionPath];
        
        //设置附件
        attachment.image = image;
        
        //记录模型
        attachment.emotionModel=emotionModel;
        
        //设置大小
        CGFloat fontLineHeight = self.font.lineHeight * .9f;
        CGFloat top = -.19f * fontLineHeight;
        attachment.bounds = CGRectMake(0, top, fontLineHeight, fontLineHeight);
        
        //新建附件对应的样式字符串
        NSAttributedString *attachStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        //插入表情附件
        [maStr replaceCharactersInRange:self.selectedRange withAttributedString:attachStr];
        
        //设置字体
        [maStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, maStr.length)];
        
        //设置光标的位置
        NSRange range = self.selectedRange;
        NSUInteger loc = range.location + 1;
        NSUInteger length = 0;
        
        //赋值
        self.attributedText = maStr;
        
        self.selectedRange = NSMakeRange(loc, length);
    }
}


@end
