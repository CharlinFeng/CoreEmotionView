//
//  emotionContentView.h
//  CoreEmotionView
//
//  Created by 成林 on 15/4/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionPageView : UIView



/*
 *  表情模型数组
 */
@property (nonatomic,strong) NSArray *emotionModelArray;


/**
 *  根据切割的数组创建对应的视图
 *
 *  @param emotionSubArray 表情切割数组（二维）
 *
 *  @return 视图数组
 */
+(NSArray *)emotionPageViewsWithEmotionSubArray:(NSArray *)emotionSubArray;




/*
 *  一行有多少列
 */
+(NSUInteger)rowCount;



/*
 *  由pageView决定一页应该放多少个表情视图
 */
+(NSUInteger)pageNum;


/*
 *  刷新表情
 */
-(void)reloadEmotions;

@end
