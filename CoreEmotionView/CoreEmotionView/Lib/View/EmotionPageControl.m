//
//  EmotionPageControl.m
//  CoreEmotionView
//
//  Created by 成林 on 15/4/12.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "EmotionPageControl.h"

@implementation EmotionPageControl



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //控件初始化
        [self pageControlPrepare];
    }
    
    return self;
}



-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //控件初始化
        [self pageControlPrepare];
    }
    
    return self;
}





/*
 *  控件初始化
 */
-(void)pageControlPrepare{
    
    //选中图片
    [self setValue:[UIImage imageNamed:@"EmotionIcons.bundle/img/compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
    [self setValue:[UIImage imageNamed:@"EmotionIcons.bundle/img/compose_keyboard_dot_normal"] forKey:@"pageImage"];
    
    //禁用交互
    self.userInteractionEnabled= NO;
    
    //如果只有1页，就自动隐藏
    self.hidesForSinglePage=YES;
}



@end
