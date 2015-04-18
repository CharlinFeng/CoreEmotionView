//
//  EmotionItemBtn.m
//  CoreEmotionView
//
//  Created by 成林 on 15/4/12.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "EmotionItemBtn.h"
#import "EmotionModel.h"
#import "NSString+EmotionExtend.h"
#import "NSString+Emoji.h"





@implementation EmotionItemBtn



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //自定义
        [self emotionItemBtnPrepare];
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //自定义
        [self emotionItemBtnPrepare];
    }
    
    return self;
}


/*
 *  自定义
 */
-(void)emotionItemBtnPrepare{
    
    //字体大小
    self.titleLabel.font=[UIFont systemFontOfSize:32.f];
    
    //禁止调整样式
    self.adjustsImageWhenHighlighted=NO;
}



-(void)setEmotionModel:(EmotionModel *)emotionModel{
    
    _emotionModel = emotionModel;
 
    //填充数据
    [self fillData];
}


/*
 *  填充数据
 */
-(void)fillData{
    
    NSString *code = _emotionModel.code;
    
    if(code == nil){//普通图片
        
        //获取图片名
        NSString *imgPath = _emotionModel.png.emotionPath;
        
        //设置图片
        UIImage *image = [UIImage imageNamed:imgPath];
        
        [self setImage:image forState:UIControlStateNormal];
        
    }else{
        
        [self setTitle:code.emoji forState:UIControlStateNormal];
    }
    
}








@end
