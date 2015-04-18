//
//  NSMutableArray+EmotionExtend.m
//  test
//
//  Created by 成林 on 15/4/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "NSMutableArray+EmotionExtend.h"




@implementation NSMutableArray (EmotionExtend)


+(instancetype)arrayWithArray:(NSArray *)array maxCount:(NSUInteger)maxCount{
    
    NSMutableArray *arrM=[NSMutableArray arrayWithArray:array];
    
    if(arrM.count>=maxCount){
        NSArray *arr= [arrM subarrayWithRange:NSMakeRange(0, maxCount)];
        
        arrM = [NSMutableArray arrayWithArray:arr];
    }
    
    return arrM;
}


-(void)addRecentEmotionObj:(id)emotionObj maxCount:(NSUInteger)maxCount{
    
    [self removeObject:emotionObj];
    
    [self insertObject:emotionObj atIndex:0];
}







@end
