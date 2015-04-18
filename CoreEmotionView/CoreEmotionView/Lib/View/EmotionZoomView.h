//
//  EmotionZoomView.h
//  CoreEmotionView
//
//  Created by 冯成林 on 15/4/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionItemBtn.h"


@interface EmotionZoomView : UIView


@property (nonatomic,strong) EmotionItemBtn *itemBtn;





/*
 *  快速实例化
 */
+(instancetype)zoomView;




@end
