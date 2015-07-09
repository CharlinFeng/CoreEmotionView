
    Charlin出框架的目标：简单、易用、实用、高度封装、绝对解耦！

# CoreEmotionView
    表情键盘，一丝淡淡的忧伤~
<br />
####框架特性：<br />
>1.高仿新浪微博表情键盘，他有的功能我都有。


<br />

<br /><br />

组织信息 Charlin Feng：
===============
<br />
#### 特别群：请西部省市朋友实名加入组织。其他地区朋友请添加2-4群：谢谢。
<br />
【西部区域】西部大开发群号： 473185026  -追赶北上广！为振兴西部IT而努力！<br />
热烈欢迎中国西部各省市的从事iOS开发朋友实名进群！本群为是聚集西部零散开发者，大家齐心协力共进退！ <br /><br />

【全国可加】四群： 347446259<br />
新开，可加！欢迎全国朋友加入组织 <br /><br />

【全国可加】三群： 474377358<br />
新开，可加！欢迎全国朋友加入组织 <br /><br />

【全国可加】二群： 369870753<br />
可加<br /><br />

【全国可加】一群：163865401<br />
已爆满，加不上了<br /><br />

<br /><br />


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


