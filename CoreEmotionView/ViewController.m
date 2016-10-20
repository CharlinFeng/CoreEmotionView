//
//  ViewController.m
//  CoreEmotionView
//
//  Created by 成林 on 15/4/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "ViewController.h"
#import "CoreEmotionView.h"
#import "NSArray+SubArray.h"
#import "EmotionModel.h"
#import "NSString+EmotionExtend.h"



@interface ViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *switchBtn;

@property (nonatomic,strong) CoreEmotionView *emotionView;






@property (nonatomic,assign) NSUInteger curve;

@property (nonatomic,assign) CGFloat time;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //视图准备
    [self viewPrepare];
    
    //事件
    [self event];
}


/*
 *  事件
 */
-(void)event{
    
    //删除按钮点击事件
    __weak typeof(self) weakSelf=self;
    self.emotionView.deleteBtnClickBlock=^(){
      
        [weakSelf.textField deleteBackward];
    };
}





/*
 *  视图准备
 */
-(void)viewPrepare{
    
    self.emotionView.textView=self.textView;
    
    self.textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth=.5f;
    
    //设置代理
    _textField.delegate=self;
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNoti:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}


/*
 *  响应通知
 */
-(void)keyboardWillChangeFrameNoti:(NSNotification *)noti{
    
    NSDictionary *dict=noti.userInfo;
    
    //获取时间
    if(_time==0){
        NSTimeInterval time=[dict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        _time=time;
    }

    //动画曲线
    if(_curve==0){
        NSUInteger curve=[dict[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        _curve=curve;
    }

    
    //键盘高度
    CGFloat keyboardH=[dict[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //执行动画
    [UIView animateWithDuration:_time animations:^{
        
        //曲线
        [UIView setAnimationCurve:_curve];
        
        _bottomView.transform=CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
}


/*
 *  键盘即将退下
 */
-(void)keyboardWillHide{
    
    //执行动画
    [UIView animateWithDuration:_time animations:^{
        
        //曲线
        [UIView setAnimationCurve:_curve];
        
        _bottomView.transform=CGAffineTransformIdentity;
    }];
}



- (IBAction)switchBtnClick:(id)sender {
    
    [self.textView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.textView.inputView=self.textView.inputView?nil:self.emotionView;
        [self.textView becomeFirstResponder];
    });
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(CoreEmotionView *)emotionView{
    
    if(_emotionView==nil){
        _emotionView = [CoreEmotionView emotionView];
    }
    
    return _emotionView;
}



- (IBAction)sendAction:(id)sender {
    
    self.textView.text = self.textField.text;
    
    self.textField.text=@"";
}


- (IBAction)textBtnClick:(id)sender {
    
    NSLog(@"---%@,---%@",self.textView.text,self.textView.attributedText);
}



@end
