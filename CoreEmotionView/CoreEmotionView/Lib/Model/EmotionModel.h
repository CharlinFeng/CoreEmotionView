//
//  EmotionModel.h
//  CoreEmotionView
//
//  Created by 成林 on 15/4/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum{
    
    //最近
    EmotionModelTypeRecent=0,
    
    //默认
    EmotionModelTypeDefault,
    
    //Emoji
    EmotionModelTypeEmoji,
    
    //浪小化
    EmotionModelTypeLxh
    
}EmotionModelType;



@interface EmotionModel : NSObject


@property (nonatomic,copy) NSString *chs,*cht,*git,*png,*code;

@property (nonatomic,assign) NSInteger type;



/*
 *  最近
 */
+(NSArray *)emotions_recent;
+(NSArray *)emotions_recent_subArray;



/*
 *  默认
 */
+(NSArray *)emotions_default;
+(NSArray *)emotions_default_subArray;


/*
 *  Emoji
 */
+(NSArray *)emotions_emoji;
+(NSArray *)emotions_emoji_subArray;


/*
 *  浪小花
 */
+(NSArray *)emotions_lxh;
+(NSArray *)emotions_lxh_subArray;







/*
 *  处理过的多维表情数组
 */
+(NSArray *)emotionsPageArray;


/**
 *  计算range
 *
 *  @param type 类型
 *
 *  @return range
 */
+(NSRange)rangeForEmotionWithType:(EmotionModelType)type;




/**
 *  对应page页码是否处于对应的range中
 *
 *  @param page 页码
 *  @param type 类型
 *
 *  @return 结果
 */
+(BOOL)page:(NSUInteger)page InRange:(EmotionModelType)type;


/**
 *  保存
 *
 *  @param emotionModel 模型
 *
 *  @return 保存结果
 */
+(void)save:(EmotionModel *)emotionModel;


/*
 *  读取
 */
+(NSArray *)read;


@end
