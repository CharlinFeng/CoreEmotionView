
    Charlin出框架的目标：简单、易用、实用、高度封装、绝对解耦！

# CoreEmotionView
    表情键盘，一丝淡淡的忧伤~
<br />
####框架特性：<br />
>1.高仿新浪微博表情键盘，他有的功能我都有。


<br />


####使用代码：<br />
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






<br /><br />


-----
    CoreEmotionView 表情键盘，一丝淡淡的忧伤~
-----

<br /><br />

#### 版权说明 RIGHTS <br />
作品说明：本框架由iOS开发攻城狮Charlin制作。<br />
作品时间： 2015.04.18 22:52<br />


#### 关于Chariln INTRODUCE <br />
作者简介：Charlin-四川成都华西都市报旗下华西都市网络有限公司技术部iOS工程师！<br /><br />


#### 联系方式 CONTACT <br />
Q    Q：1761904945（请注明缘由）<br />
Mail：1761904945@qq.com<br />
成都iOS开发群：163865401（Charlin创建与维护）
