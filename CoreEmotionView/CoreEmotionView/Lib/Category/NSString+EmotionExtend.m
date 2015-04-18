//
//  NSString+EmotionExtend.m
//  CoreEmotionView
//
//  Created by 冯成林 on 15/4/15.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "NSString+EmotionExtend.h"
#import "EmotionViewConst.h"



@implementation NSString (EmotionExtend)



/*
 *  图片资源的全路径
 */
-(NSString *)emotionPath{
    
    NSString *folederName = EmotionDefaultFolder;
    
    if([self hasPrefix:EmotionLxhFolder]) folederName = EmotionLxhFolder;
   
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",EmotionBundelName,folederName,self];
    
    return [path copy];
}



/*
 *  删除按钮
 */
-(NSString *)deletePath{
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",EmotionBundelName,EmotionImgFolder,self];
    
    return [path copy];
}


@end
