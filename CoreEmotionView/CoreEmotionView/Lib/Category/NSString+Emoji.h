//
//  NSString+Emoji.h
//  黑马微博
//
//  Created by MJ Lee on 14/7/12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)

/*
 *  16进制字符串转emoji字符串
 */
@property (nonatomic,copy,readonly) NSString *emoji;


/**
 *  是否为emoji字符
 */
@property (nonatomic,assign,readonly) BOOL isEmoji;



@end
