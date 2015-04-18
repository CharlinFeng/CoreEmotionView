//
//  EmotionScrollView.m
//  CoreEmotionView
//
//  Created by 成林 on 15/4/12.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "EmotionScrollView.h"
#import "EmotionPageView.h"

@interface EmotionScrollView ()<UIScrollViewDelegate>


/*
 *  记录页码数量，方便屏幕旋转时监听
 */
@property (nonatomic,assign) NSUInteger num;

/*
 *  是否在滚动
 */
@property (nonatomic,assign) BOOL isScroll;



/*
 *  页码
 */
@property (nonatomic,assign) NSUInteger page;




@end


@implementation EmotionScrollView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}



/*
 *  视图准备
 */
-(void)viewPrepare{
    
    self.showsHorizontalScrollIndicator=NO;
    self.showsVerticalScrollIndicator=NO;
    
    //监听屏幕旋转
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceRotation) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //开启分页
    self.pagingEnabled=YES;
    
    //设置代理
    self.delegate=self;
}

-(void)dealloc{
    
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)deviceRotation{
    [self contentSizeMakeSure:_num];
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if(_isScroll) return;
    
    __block CGRect frame = self.bounds;
    
    CGFloat width = frame.size.width;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        frame.origin.x = idx * width;
        
        subView.frame= frame;
    }];
}




/*
 *  根据子视图的数量确定contentSize
 */
-(void)contentSizeMakeSure:(NSUInteger)num{
    
    _num = num;
    
    CGRect bounds = self.bounds;
    
    bounds.size.width=[UIScreen mainScreen].bounds.size.width;
    
    CGFloat width = bounds.size.width * num;
    
    CGSize contentSize = CGSizeMake(width,0);
    
    self.contentSize = contentSize;
}




/*
 *  代理方法专区
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.isScroll = YES;
    
    //计算页码
    NSUInteger page = (scrollView.contentOffset.x / self.bounds.size.width) + .5f;
    
    self.page = page;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.isScroll=NO;
}

-(void)setIsScroll:(BOOL)isScroll{
    
    if(_isScroll == isScroll) return;
    
    _isScroll = isScroll;
}






-(void)setPage:(NSUInteger)page{
    
    if(_page == page) return;
    
    _page = page;
    
    if(_scrollViewPageChangedBlock!=nil) _scrollViewPageChangedBlock(page);
}




/*
 *  滚动到指定的页码
 */
-(void)scrollToPage:(NSUInteger)page{
    
    //计算contentOffsetX
    CGFloat contentOffseX = page * self.bounds.size.width;
    
    CGPoint offset = CGPointMake(contentOffseX, 0);

    self.contentOffset = offset;
}





/*
 *  屏幕旋转
 */
-(void)deviceRotate{
    
    dispatch_async(dispatch_get_main_queue(), ^{

        [self scrollToPage:self.page];
        [self layoutIfNeeded];
    });

}


/*
 *  表情刷新
 */
-(void)refreshEmotionsIfNeeded{
    
//    if(self.page!=0) return;
    
    EmotionPageView *pageView = (EmotionPageView *)self.pageViews.firstObject;
    
    [pageView reloadEmotions];
    
}


@end
