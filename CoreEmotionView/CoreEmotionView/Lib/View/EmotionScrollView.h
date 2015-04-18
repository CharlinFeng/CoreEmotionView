//
//  EmotionScrollView.h
//  CoreEmotionView
//
//  Created by 成林 on 15/4/12.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionScrollView : UIScrollView



@property (nonatomic,copy) void(^scrollViewPageChangedBlock)(NSUInteger page);

@property (nonatomic,strong) NSArray *pageViews;


/*
 *  根据子视图的数量确定contentSize
 */
-(void)contentSizeMakeSure:(NSUInteger)num;



/*
 *  滚动到指定的页码
 */
-(void)scrollToPage:(NSUInteger)page;


/*
 *  屏幕旋转
 */
-(void)deviceRotate;



/*
 *  表情刷新
 */
-(void)refreshEmotionsIfNeeded;

@end
