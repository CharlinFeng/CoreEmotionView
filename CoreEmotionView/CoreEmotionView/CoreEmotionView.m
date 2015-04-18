//
//  CoreEmotionView.m
//  CoreEmotionView
//
//  Created by 沐汐 on 15-4-11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CoreEmotionView.h"
#import "EmotionTabBtn.h"
#import "EmotionModel.h"
#import "EmotionPageView.h"
#import "UIView+EmotionExtend.h"
#import "EmotionScrollView.h"
#import "EmotionPageControl.h"
#import "EmotionViewConst.h"
#import "UITextView+Emotion.h"
#import "UITextField+Emotion.h"




@interface CoreEmotionView ()

@property (weak, nonatomic) IBOutlet EmotionTabBtn *recentBtn;

@property (weak, nonatomic) IBOutlet EmotionTabBtn *defalutBtn;

@property (weak, nonatomic) IBOutlet EmotionTabBtn *emojiBtn;

@property (weak, nonatomic) IBOutlet EmotionTabBtn *lxhBtn;

@property (weak, nonatomic) IBOutlet EmotionScrollView *emotionScrollView;

@property (weak, nonatomic) IBOutlet EmotionPageControl *pageControl;

@property (nonatomic,weak) EmotionTabBtn *selectedBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;



@end




@implementation CoreEmotionView

+(instancetype)emotionView{
    
    CoreEmotionView *emotionView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;

    return emotionView;
}


-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    //视图准备
    [self viewPrepre];
    
    //按钮处理
    [self btnPrepare];
    
    //表情数组处理
    [self emotionsArrayPrepare];
    
    //事件处理
    [self event];
}

/*
 *  视图准备
 */
-(void)viewPrepre{
 
    _heightConstraint.constant= .5f;
}


/*
 *  事件处理
 */
-(void)event{
    
    //scrollView页码改变事件处理
    _emotionScrollView.scrollViewPageChangedBlock = ^(NSUInteger page){
      
        //选中最近
        if([EmotionModel page:page InRange:EmotionModelTypeRecent]) [self switchBtnClick:_recentBtn type:EmotionModelTypeRecent];
       
        EmotionModelType type = EmotionModelTypeRecent;
        
        //选中默认
        if([EmotionModel page:page InRange:EmotionModelTypeDefault]){
            
            [self switchBtnClick:_defalutBtn type:EmotionModelTypeDefault];
            
            type = EmotionModelTypeDefault;
        }
        
        //选中Emoji
        if([EmotionModel page:page InRange:EmotionModelTypeEmoji]){
            
            [self switchBtnClick:_emojiBtn type:EmotionModelTypeEmoji];
            
            type = EmotionModelTypeEmoji;
        }
        
        //选中浪小花
        if([EmotionModel page:page InRange:EmotionModelTypeLxh]){
            
            [self switchBtnClick:_lxhBtn type:EmotionModelTypeLxh];
            
            type = EmotionModelTypeLxh;
        }
        
        //计算pageControl的page信息
        if(page == 0 || EmotionModelTypeRecent == type) return;
        
        NSRange range = [EmotionModel rangeForEmotionWithType:type];
        
        NSUInteger pageControlPage = page - range.location;
        
        self.pageControl.currentPage = pageControlPage;
    };

    //监听屏幕旋转
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //监听删除按钮点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCharctor) name:EmotionDeleteBtnClickNotification object:nil];
    
    //点击了表情按钮
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionItemBtnClickAction:) name:EmotionItemBtnClickNotification object:nil];
}


/*
 *  点击了表情按钮
 */
-(void)emotionItemBtnClickAction:(NSNotification *)noti{
    
    //取出模型对象
    EmotionModel *emotionModel =noti.userInfo[EmotionItemBtnClickNotificationKey];
    
    if(_emotionItemBtnClickBlock != nil) _emotionItemBtnClickBlock(emotionModel);
    
    //响应表情键盘点击事件
    [self responseEmotionKeyBoardClick:emotionModel];
    
    //保存表情模型数据
    [EmotionModel save:emotionModel];
    
    //刷新表情
    [self.emotionScrollView refreshEmotionsIfNeeded];
}



-(void)deleteCharctor{
    
    if(self.textView != nil) [self.textView deleteBackward];
    
    if(_deleteBtnClickBlock != nil) _deleteBtnClickBlock();
}

-(void)dealloc{
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)deviceRotate{
    
    //告诉scrollView即可
    [self.emotionScrollView deviceRotate];
}




/*
 *  表情数组处理
 */
-(void)emotionsArrayPrepare{
    
    //获取切割的多维表情数组
    NSArray *subEmotionArray=[EmotionModel emotionsPageArray];
    
    //使用表情数组创建一组视图
    NSArray *views = [EmotionPageView emotionPageViewsWithEmotionSubArray:subEmotionArray];
    
    //确定scrollView的contentSize
    [_emotionScrollView contentSizeMakeSure:views.count];
    
    //记录pageViews
    _emotionScrollView.pageViews=views;
    
    //将这些视图全部添加在scrollView中
    [_emotionScrollView addSubviewsWithArray:views];
}




/*
 *  按钮处理
 */
-(void)btnPrepare{
    
    //按钮公共事件区
    [self recentBtnClick:_recentBtn];
    
    
}




/*
 *  btn点击事件
 */

/*
 *  最近
 */
- (IBAction)recentBtnClick:(EmotionTabBtn *)btn{
    
    //按钮公共事件区
    [self switchBtnClick:btn type:EmotionModelTypeRecent];
    
    //scrollView跳转
    [self scrollViewScrollToEmotionRangeLocWithRange:[EmotionModel rangeForEmotionWithType:EmotionModelTypeRecent]];
    
    //刷新表情键盘数据
    [_emotionScrollView refreshEmotionsIfNeeded];
}

/*
 *  默认
 */
- (IBAction)defaultBtnClick:(EmotionTabBtn *)btn{
    
    //按钮公共事件区
    [self switchBtnClick:btn type:EmotionModelTypeDefault];
    
    //scrollView跳转
    [self scrollViewScrollToEmotionRangeLocWithRange:[EmotionModel rangeForEmotionWithType:EmotionModelTypeDefault]];
}

/*
 *  emoji
 */
- (IBAction)emojiBtnClick:(EmotionTabBtn *)btn{
    
    //按钮公共事件区
    [self switchBtnClick:btn type:EmotionModelTypeEmoji];
    
    //scrollView跳转
    [self scrollViewScrollToEmotionRangeLocWithRange:[EmotionModel rangeForEmotionWithType:EmotionModelTypeEmoji]];
}

/*
 *  浪小花
 */
- (IBAction)lxhBtnClick:(EmotionTabBtn *)btn{
    
    //按钮公共事件区
    [self switchBtnClick:btn type:EmotionModelTypeLxh];
    
    //scrollView跳转
    [self scrollViewScrollToEmotionRangeLocWithRange:[EmotionModel rangeForEmotionWithType:EmotionModelTypeLxh]];
}


/*
 *  按钮公共事件区
 */
-(void)switchBtnClick:(EmotionTabBtn *)btn type:(EmotionModelType)type{

    //选中按钮
    [self selectBtn:btn];
    
    NSUInteger page = 0;
    
    if(EmotionModelTypeRecent == type) page=1;
    
    if(EmotionModelTypeDefault == type) page = [EmotionModel emotions_default_subArray].count;
    
    if(EmotionModelTypeEmoji == type) page = [EmotionModel emotions_emoji_subArray].count;
    
    if(EmotionModelTypeLxh == type) page = [EmotionModel emotions_lxh_subArray].count;
    
    _pageControl.numberOfPages = page;
}



/*
 *  选中按钮
 */
-(void)selectBtn:(EmotionTabBtn *)btn{
    
    _selectedBtn.selected=NO;
    
    _selectedBtn=btn;
    
    _selectedBtn.selected=YES;
}





/*
 *  点击按钮，scrollView需要跳转到对应的表情range的loc位置
 */
-(void)scrollViewScrollToEmotionRangeLocWithRange:(NSRange)range{
    
    //取出页码
    NSUInteger page = range.location;
    
    [self.emotionScrollView scrollToPage:page];
}






/*
 *  响应表情键盘点击事件
 */
-(void)responseEmotionKeyBoardClick:(EmotionModel *)emotionModel{

    if(self.textView != nil) [self.textView insertEmotionWithModel:emotionModel];
    
    if(self.textField != nil) [self.textField insertEmotionWithModel:emotionModel];
}













@end
