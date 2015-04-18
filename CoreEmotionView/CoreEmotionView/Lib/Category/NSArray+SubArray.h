//
//  NSArray+SubArray.h
//  CoreEmotionView
//
//  Created by 成林 on 15/4/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SubArray)




/**
 *  数组切割
 *
 *  切割前数组为一维数组，切割后数组为二维数组
 *
 *  @param length 切割长度
 *
 *  @return 被切割的二维数组
 */
-(NSArray *)subArrayWithLength:(NSUInteger)length;



@end
