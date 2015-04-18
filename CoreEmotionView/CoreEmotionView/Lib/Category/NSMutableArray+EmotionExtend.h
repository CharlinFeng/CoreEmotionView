//
//  NSMutableArray+EmotionExtend.h
//  test
//
//  Created by 成林 on 15/4/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (EmotionExtend)

+(instancetype)arrayWithArray:(NSArray *)array maxCount:(NSUInteger)maxCount;

-(void)addRecentEmotionObj:(id)emotionObj maxCount:(NSUInteger)maxCount;


@end
