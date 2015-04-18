//
//  EmotionDeleteBtn.m
//  CoreEmotionView
//
//  Created by 冯成林 on 15/4/15.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "EmotionDeleteBtn.h"
#import "NSString+EmotionExtend.h"
#import "EmotionViewConst.h"


@interface EmotionDeleteBtn ()

/*
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;

@end


@implementation EmotionDeleteBtn

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //按钮初始化
        [self emotionDeleteBtnPrepre];
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //按钮初始化
        [self emotionDeleteBtnPrepre];
    }
    
    return self;
}


/*
 *  按钮初始化
 */
-(void)emotionDeleteBtnPrepre{
    
    NSString *normalImagePath = @"compose_emotion_delete".deletePath;
    NSString *hlImagePath = @"compose_emotion_delete_highlighted".deletePath;
    
    [self setImage:[UIImage imageNamed:normalImagePath] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:hlImagePath] forState:UIControlStateHighlighted];
    
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
}


/*
 *  快速实例化
 */
+(instancetype)deleteBtn{
    
    EmotionDeleteBtn *deleteBtn = [EmotionDeleteBtn buttonWithType:UIButtonTypeCustom];
    
    return deleteBtn;
}



-(void)longPress:(UILongPressGestureRecognizer *)lp{
    
    if(UIGestureRecognizerStateBegan == lp.state){
        [self.timer fire];
    }else if(UIGestureRecognizerStateChanged == lp.state){
        
    }else{
        [_timer invalidate];
    }
}


-(NSTimer *)timer{
    
    if(YES){
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:.15f target:self selector:@selector(working) userInfo:nil repeats:YES];
        
        //加入主循环
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    
    return _timer;
}


-(void)working{
    //发通知
    [[NSNotificationCenter defaultCenter] postNotificationName:EmotionDeleteBtnClickNotification object:self userInfo:nil];
}

@end
