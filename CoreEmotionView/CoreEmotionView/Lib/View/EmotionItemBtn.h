//
//  EmotionItemBtn.h
//  CoreEmotionView
//
//  Created by 成林 on 15/4/12.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmotionModel;

@interface EmotionItemBtn : UIButton

/*
 *  按钮与模型绑定
 */
@property (nonatomic,strong) EmotionModel *emotionModel;

@end
