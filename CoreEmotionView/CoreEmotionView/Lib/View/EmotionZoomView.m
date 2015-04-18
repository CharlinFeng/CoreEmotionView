//
//  EmotionZoomView.m
//  CoreEmotionView
//
//  Created by 冯成林 on 15/4/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "EmotionZoomView.h"
#import "EmotionModel.h"
#import "NSString+EmotionExtend.h"
#import "NSString+Emoji.h"



@interface EmotionZoomView ()


/*
 *  放大图片的控件
 */
@property (weak, nonatomic) IBOutlet UIImageView *zooImageV;



@property (weak, nonatomic) IBOutlet UILabel *zoomLabel;



@end




@implementation EmotionZoomView


/*
 *  快速实例化
 */
+(instancetype)zoomView{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}




-(void)setItemBtn:(EmotionItemBtn *)itemBtn{
    
    _itemBtn = itemBtn;
    
    //实时显示位置
    [self showWithItemBtn:itemBtn];
}



/**
 *  实时显示位置
 *
 *  @param itemBtn 选中的表情按钮
 */
-(void)showWithItemBtn:(EmotionItemBtn *)itemBtn{
    
    if(itemBtn.emotionModel.code==nil){
        //显示图片
        self.zooImageV.image = [UIImage imageNamed:itemBtn.emotionModel.png.emotionPath];
        self.zoomLabel.text=nil;
    }else{
        
        self.zoomLabel.text = itemBtn.emotionModel.code.emoji;
        self.zooImageV.image=nil;
    }
    
    //坐标系转换
    CGRect frame_selectedItemBtn_convert = [itemBtn convertRect:itemBtn.bounds toView:itemBtn.window];
    
    //得到之前的frame
    CGRect frame_zoomView =self.bounds;
    
    frame_zoomView.origin.x = frame_selectedItemBtn_convert.origin.x + (frame_selectedItemBtn_convert.size.width - frame_zoomView.size.width) * .5f;
    frame_zoomView.origin.y = frame_selectedItemBtn_convert.origin.y + frame_selectedItemBtn_convert.size.height -self.bounds.size.height-5.0f;
    
    self.frame = frame_zoomView;
}


@end
