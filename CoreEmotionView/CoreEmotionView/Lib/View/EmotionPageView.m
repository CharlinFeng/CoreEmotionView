//
//  emotionContentView.m
//  CoreEmotionView
//
//  Created by 成林 on 15/4/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "EmotionPageView.h"
#import "EmotionItemBtn.h"
#import "EmotionDeleteBtn.h"
#import "EmotionViewConst.h"
#import "EmotionZoomView.h"
#import "EmotionModel.h"



#define ramdomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0f])

#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f || [UIScreen mainScreen].bounds.size.height==320.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f || [UIScreen mainScreen].bounds.size.height==320.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f || [UIScreen mainScreen].bounds.size.height==375.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)

//顶部边距
const CGFloat topInset = 12.f;

//左右边距
const CGFloat left_RightInset = 8.f;




@class EmotionModel;


@interface EmotionPageView ()

/*
 *  提示类label
 */
@property (nonatomic,weak) UILabel *msgLabel;


/*
 *  删除按钮
 */
@property (nonatomic,weak) EmotionDeleteBtn *deleteBtn;



/*
 *  选中的itemBtn
 */
@property (nonatomic,weak) EmotionItemBtn *selectedItemBtn;


/*
 *  放大的view
 */
@property (nonatomic,strong) EmotionZoomView *zoomView;




@property (nonatomic,assign) BOOL isLongPressed;

@end



@implementation EmotionPageView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //视图准备
        [self pageViewPrepare];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //视图准备
        [self pageViewPrepare];
        
    }
    
    return self;
}

/*
 *  视图准备
 */
-(void)pageViewPrepare{
    
    //label
    [self labelPrepare];
    
    //deleteBtn
    [self deleteBtnPrepare];
    
    //事件
    [self event];
}



/*
 *  事件
 */
-(void)event{
    
    //长按手势
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
}


-(void)longPress:(UILongPressGestureRecognizer *)lp{
    
    switch (lp.state) {
            
        //手势开始
        case UIGestureRecognizerStateBegan:
            
            
        //手势移动
        case UIGestureRecognizerStateChanged:
            {
                
                
                //拿到当前的点
                CGPoint location = [lp locationInView:self];
                
                //拿到btn
                EmotionItemBtn *itemBtn = [self itemBtnWithLocation:location];
                
                self.selectedItemBtn = itemBtn;
                
                _isLongPressed = YES;
            }
            
            break;
            
        //手势其他状态
        default:{
            
            _isLongPressed = NO;
            
            //隐藏放大控件
            [self dismissZoomView];
        }
            break;
    }
    
}


/*
 *  根据当前的点计算对应的btn
 */
-(EmotionItemBtn *)itemBtnWithLocation:(CGPoint)location{
   
    __block EmotionItemBtn *itemBtn = nil;
    
    //直接遍历
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        if([self isItemBtn:subView]){
            
            if(CGRectContainsPoint(subView.frame, location)){
                itemBtn = (EmotionItemBtn *)subView;
                *stop = YES;
            }
        }
    }];
    
    return itemBtn;
}









/*
 *  label
 */
-(void)labelPrepare{
    
    UILabel *msgLabel = [[UILabel alloc] init];
    //记录
    self.msgLabel = msgLabel;
    
    msgLabel.text=@"暂无最近使用的表情~";
    
    //字体
    msgLabel.font = [UIFont systemFontOfSize:14.0f];
    //颜色
    msgLabel.textColor =[UIColor darkGrayColor];
    
    //居中
    msgLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:msgLabel];
}




/*
 *  deleteBtn
 */
-(void)deleteBtnPrepare{
    
    EmotionDeleteBtn *deleteBtn = [EmotionDeleteBtn deleteBtn];
    self.deleteBtn=deleteBtn;
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
}


/*
 *  点击了删除按钮
 */
-(void)deleteBtnClick:(EmotionDeleteBtn *)btn{
   
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:EmotionDeleteBtnClickNotification object:btn];
}


/**
 *  根据切割的数组创建对应的视图
 *
 *  @param emotionSubArray 表情切割数组（二维）
 *
 *  @return 视图数组
 */
+(NSArray *)emotionPageViewsWithEmotionSubArray:(NSArray *)emotionSubArray{
    
    NSMutableArray *viewsArrayM = [NSMutableArray array];
    
    //此为切割数组，非能用方法，所以不必做异常判断，直接使用即可。
    [emotionSubArray enumerateObjectsUsingBlock:^(NSArray *switchArray, NSUInteger idx1, BOOL *stop) {
        
        [switchArray enumerateObjectsUsingBlock:^(NSArray *emotionModelArray, NSUInteger idx2, BOOL *stop) {
            
            EmotionPageView *emotionPageView = [[EmotionPageView alloc] init];
           
            //随机色
//            emotionPageView.backgroundColor=ramdomColor;
            
//            emotionPageView.layer.borderColor=[UIColor brownColor].CGColor;
//            emotionPageView.layer.borderWidth=1.0f;
            
            if(emotionSubArray!=nil) emotionPageView.emotionModelArray = emotionModelArray;
            
            [viewsArrayM addObject:emotionPageView];
        }];
    }];
    
    return viewsArrayM;
}


-(void)setEmotionModelArray:(NSArray *)emotionModelArray{
    
    _emotionModelArray = emotionModelArray;
    
    
    if(emotionModelArray.count == 0){
        
        [self.deleteBtn removeFromSuperview];
        
        return;
    }
    
    //子视图准备
    [self subViewsPrepare];
}



/*
 *  子视图准备
 */
-(void)subViewsPrepare{
    
    //移除旧视图
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        if(![subView isKindOfClass:[EmotionDeleteBtn class]]){
            [subView removeFromSuperview];
        }
    }];
    
    //重新添加
    [_emotionModelArray enumerateObjectsUsingBlock:^(EmotionModel *emotionModel, NSUInteger idx, BOOL *stop) {
        
        EmotionItemBtn *itemBtn =[EmotionItemBtn buttonWithType:UIButtonTypeCustom];
        
        itemBtn.emotionModel = emotionModel;
        
        //添加事件
        [itemBtn addTarget:self action:@selector(emotionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //添加
        [self addSubview:itemBtn];
    }];
}




-(void)emotionBtnClick:(EmotionItemBtn *)itemBtn{
   
    [self postNotiWithItemBtn:itemBtn];
}


-(void)postNotiWithItemBtn:(EmotionItemBtn *)itemBtn{
    
    if(itemBtn == nil) return;
    
    //定制内容
    NSDictionary *userInfo = @{EmotionItemBtnClickNotificationKey : itemBtn.emotionModel};
    
    //发通知
    [[NSNotificationCenter defaultCenter] postNotificationName:EmotionItemBtnClickNotification object:itemBtn userInfo:userInfo];
}









-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger rowCount = [EmotionPageView rowCount];
    
    //调整位置,设置frame
    CGFloat btnH = (self.bounds.size.height - topInset) / 3.0f;
    CGFloat btnW =(self.bounds.size.width - left_RightInset * 2) / rowCount;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        if([subView isKindOfClass:[UILabel class]]){//提示类label
            subView.frame = self.bounds;
            
        }else if ([subView isKindOfClass:[EmotionDeleteBtn class]]){//删除类按钮
            
            [self calFrameWithView:subView rowCount:rowCount btnH:btnH btnW:btnW idx:(rowCount * EmotionRowCount-1)];

        }else if([subView isKindOfClass:[EmotionZoomView class]]){//放大类按钮
            
        }else{
            
            [self calFrameWithView:subView rowCount:rowCount btnH:btnH btnW:btnW idx:idx -1];
        }
    }];
}


-(void)calFrameWithView:(UIView *)subView rowCount:(NSUInteger)rowCount btnH:(CGFloat)btnH btnW:(CGFloat)btnW idx:(NSUInteger)idx{
    
    NSUInteger row = idx % rowCount;
    
    NSUInteger col = idx / rowCount;
    
    CGFloat btnX = row * btnW + left_RightInset;
    
    CGFloat btnY = col * btnH + topInset;
    
    //得到frame
    CGRect frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    subView.frame=frame;
}




/*
 *  由pageView决定一页应该放多少个表情视图
 */
+(NSUInteger)pageNum{

    return [self rowCount] * EmotionRowCount - 1;
}



/*
 *  一行有多少列
 */
+(NSUInteger)rowCount{
   
    //普通屏幕: 一排7个
    NSUInteger rowCount = 7;
    
    //iPhone6: 一排8个
    if(iphone6_4_7) rowCount = 8;
    
    //iPhone 6P: 一排10个
    if(iphone6Plus_5_5) rowCount = 10;
    
    return rowCount;
}




-(void)setSelectedItemBtn:(EmotionItemBtn *)selectedItemBtn{
    
    if(_selectedItemBtn == selectedItemBtn && _isLongPressed) return;
    
    _selectedItemBtn = selectedItemBtn;
    
    //显示放大按钮
    [self showZoomView];
}


/*
 *  显示放大控件
 */
-(void)showZoomView{
    
    if(_selectedItemBtn ==nil){
        [self dismissZoomView];return;
    }
    
    [self.window addSubview:self.zoomView];
    
    self.zoomView.itemBtn = _selectedItemBtn;
}


/*
 *  隐藏放大控件
 */
-(void)dismissZoomView{
    
    [self.zoomView removeFromSuperview];
    
    [self postNotiWithItemBtn:_selectedItemBtn];
}



-(EmotionZoomView *)zoomView{
    
    if(_zoomView == nil){
        
        _zoomView = [EmotionZoomView zoomView];
    }
    
    return _zoomView;
}



-(BOOL)isItemBtn:(UIView *)subView{
    return !([subView isKindOfClass:[UILabel class]] || [subView isKindOfClass:[EmotionDeleteBtn class]] || [subView isKindOfClass:[EmotionZoomView class]]);
}



/*
 *  刷新表情
 */
-(void)reloadEmotions{
    self.emotionModelArray = [EmotionModel emotions_recent];
}

@end
