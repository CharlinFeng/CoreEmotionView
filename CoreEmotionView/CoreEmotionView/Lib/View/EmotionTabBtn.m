//
//  EmotionSwitchBtn.m
//  CoreEmotionView
//
//  Created by 沐汐 on 15-4-11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "EmotionTabBtn.h"


@implementation EmotionTabBtn


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //按钮初始化
        [self btPrepare];
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //按钮初始化
        [self btPrepare];
    }
    
    return self;
}



/*
 *  按钮初始化
 */
-(void)btPrepare{
    
    //背影色
    self.backgroundColorForNormal=rgb(239, 239, 239);
    self.backgroundColorForSelected=rgb(173, 173, 173);
    
    //文字颜色
    [self setTitleColor:rgb(105, 105, 105) forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    //字体大小
    self.titleLabel.font=[UIFont systemFontOfSize:15.0f];
}

-(void)setHighlighted:(BOOL)highlighted{}


@end
