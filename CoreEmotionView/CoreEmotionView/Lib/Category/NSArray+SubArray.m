//
//  NSArray+SubArray.m
//  CoreEmotionView
//
//  Created by 成林 on 15/4/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "NSArray+SubArray.h"
#import <UIKit/UIKit.h>

@implementation NSArray (SubArray)


/**
 *  数组切割
 *
 *  切割前数组为一维数组，切割后数组为二维数组
 *
 *  @param length 切割长度
 *
 *  @return 被切割的二维数组
 */
-(NSArray *)subArrayWithLength:(NSUInteger)length{
    
    NSUInteger count = self.count;
    
    //异常处理
    if(self==nil || count==0 || length ==0) return @[self];
    
    if(count <= length) return @[self];
    
    
    NSUInteger subArrayCount = count / length;
    
    if(subArrayCount * length < count) subArrayCount++;
    
    //创建新数组
    NSMutableArray *subArrayM = [NSMutableArray arrayWithCapacity:subArrayCount];

    for (NSInteger i=0; i<subArrayCount; i++) {
        
        NSUInteger loc = i * length;
        
        NSUInteger len = length;
        
        if(i == subArrayCount - 1){//最后一组
            
            len = count - length * (subArrayCount -1);
        }
        
        NSRange range = NSMakeRange(loc, len);
        
        NSArray *subArray_i = [self subarrayWithRange:range];
        
        [subArrayM addObject:subArray_i];
        
    }
    
    
    return subArrayM;
}



@end
