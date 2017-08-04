//
//  RegiestViewController.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "RegiestViewController.h"

@interface RegiestViewController ()

@end

@implementation RegiestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.navigationController setNavigationBarHidden:NO];
    [[self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag] removeFromSuperview];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    contentView.backgroundColor = [UIColor clearColor];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:LOADIMAGE(@"arrowleftred", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -10;//这个值可以根据自己需要自己调整
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, barButtonItem];
    
    // Do any additional setup after loading the view.
    
    
    
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[ UISwipeGestureRecognizer alloc ] initWithTarget : self action : @selector (handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
    
    recognizer = [[ UISwipeGestureRecognizer alloc ] initWithTarget : self action : @selector (handleSwipeFrom:)];
    [recognizer setDirection :( UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer :recognizer];
    
    [self initview];
    // Do any additional setup after loading the view.
}

-(void)initview
{
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = COLORNOW(240, 240, 240);
    
    self.title = @"手机号注册";
    UIColor* color = [UIColor blackColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
    
    UIView *viewtop = [self topbanview:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:viewtop];
    
}

//注册账号按钮上
-(UIView *)topbanview:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIView *viewwhite = [[UIView alloc] initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-40, 50)];
    viewwhite.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
    viewwhite.layer.borderWidth = 1.0f;
    viewwhite.backgroundColor = [UIColor whiteColor];
    [view addSubview:viewwhite];
    
    UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 0.7, 30)];
    imageline1.backgroundColor = COLORNOW(220, 220, 220);
    [viewwhite addSubview:imageline1];
    
    UILabel *label86 = [[UILabel alloc] initWithFrame:CGRectMake(0, 15,40, 20)];
    label86.text = @"+86";
    label86.font = FONTN(16.0f);
    label86.textAlignment = NSTextAlignmentCenter;
    label86.textColor = COLORNOW(128, 128, 128);
    [viewwhite addSubview:label86];
    
    textfieldphone = [[UITextField alloc] initWithFrame:CGRectMake(XYViewRight(imageline1)+5, 10,150, 30)];
    textfieldphone.backgroundColor = [UIColor clearColor];
    textfieldphone.delegate = self;
    textfieldphone.font = FONTN(15.0f);
    textfieldphone.placeholder = @"请输入手机号码";
    [viewwhite addSubview:textfieldphone];
    
    //验证码密码
    UIView *viewwhite1 = [[UIView alloc] initWithFrame:CGRectMake(20, XYViewBottom(viewwhite)+10, SCREEN_WIDTH-40, 100)];
    viewwhite1.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
    viewwhite1.layer.borderWidth = 1.0f;
    viewwhite1.backgroundColor = [UIColor whiteColor];
    [view addSubview:viewwhite1];
    
    UIImageView *imageline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, XYViewWidth(viewwhite), 0.7)];
    imageline2.backgroundColor = COLORNOW(220, 220, 220);
    [viewwhite1 addSubview:imageline2];
    
    textfieldcode = [[UITextField alloc] initWithFrame:CGRectMake(5, 10,viewwhite1.frame.size.width-100, 30)];
    textfieldcode.backgroundColor = [UIColor clearColor];
    textfieldcode.delegate = self;
    textfieldcode.font = FONTN(15.0f);
    textfieldcode.placeholder = @"请输入验证码";
    [viewwhite1 addSubview:textfieldcode];
    
    UIImageView *imageline3 = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewWidth(viewwhite)-101, 10, 0.7, 30)];
    imageline3.backgroundColor = COLORNOW(220, 220, 220);
    [viewwhite1 addSubview:imageline3];
    
    UIButton *buttonforget = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonforget.frame = CGRectMake(XYViewWidth(viewwhite)-100, 5, 100, 40);
    [buttonforget setTitle:@"发送验证码" forState:UIControlStateNormal];
    [buttonforget setTitleColor:COLORNOW(72, 72, 72) forState:UIControlStateNormal];
    buttonforget.titleLabel.font = FONTN(15.0f);
    buttonforget.tag = EnGetVerCodeBtTag;
    [buttonforget addTarget:self action:@selector(clickgetcode:) forControlEvents:UIControlEventTouchUpInside];
    [viewwhite1 addSubview:buttonforget];
    
    textfieldpwd = [[UITextField alloc] initWithFrame:CGRectMake(5, 60, viewwhite1.frame.size.width-20, 30)];
    textfieldpwd.backgroundColor = [UIColor clearColor];
    textfieldpwd.delegate = self;
    textfieldpwd.secureTextEntry = YES;
    textfieldpwd.font = FONTN(15.0f);
    textfieldpwd.placeholder = @"请输入密码";
    [viewwhite1 addSubview:textfieldpwd];
    
    
   
    
    //登录按钮
    UIButton *buttonlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonlogin.frame = CGRectMake(20, XYViewBottom(viewwhite1)+30,XYViewWidth(viewwhite1), 50);
    [buttonlogin setTitle:@"提交" forState:UIControlStateNormal];
    [buttonlogin setBackgroundColor:COLORNOW(180, 180, 180)];
    buttonlogin.layer.cornerRadius = 3.0f;
    buttonlogin.clipsToBounds = YES;
    buttonlogin.titleLabel.font = FONTMEDIUM(16.0f);
    buttonlogin.tag = EnRegiestAccountBtTag;
    [buttonlogin addTarget:self action:@selector(clickgotoregiest:) forControlEvents:UIControlEventTouchUpInside];
    [buttonlogin setTitleColor:COLORNOW(120, 120, 120) forState:UIControlStateNormal];
    [view addSubview:buttonlogin];
    
    
    return view;
}

#pragma mark 滑动事件
- (void)handleSwipeFrom:( UISwipeGestureRecognizer *)sender
{
    DLog(@"UISwipeGestureRecognizerDirectionRight");
    
    if ((sender. direction == UISwipeGestureRecognizerDirectionRight))
    {
        [self returnback:nil];
    }
    else if((sender. direction == UISwipeGestureRecognizerDirectionLeft))
    {
        
    }
}

#pragma mark UItextfielddelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UIButton *button = [self.view viewWithTag:EnRegiestAccountBtTag];
    if([string length]>0)
    {
        [button setBackgroundColor:COLORNOW(232, 56, 47)];
        button.titleLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        [button setBackgroundColor:COLORNOW(180, 180, 180)];
        button.titleLabel.textColor = COLORNOW(80, 80, 80);
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark IBAction

-(void)clickgotoregiest:(id)sender
{
    if(([textfieldphone.text length]==0)||([textfieldcode.text length]==0)||([textfieldpwd.text length]==0))
    {
        [MBProgressHUD showError:@"请填写完整信息" toView:app.window];
    }
    else if(![AddInterface isValidateMobile:textfieldphone.text])
    {
        [MBProgressHUD showError:@"请填写正确的电话格式" toView:app.window];
    }
    else
    {
        [self clickregiestdone];
    }
    
}

-(void)clickgetcode:(id)sender
{
    if([textfieldphone.text length]==0)
    {
        [MBProgressHUD showError:@"请填写电话" toView:app.window];
    }
    else if(![AddInterface isValidateMobile:textfieldphone.text])
    {
        [MBProgressHUD showError:@"请填写正确的电话格式" toView:app.window];
    }
    else
    {
        [self gotovercode];
        getyanzhengcodeflag = 1;
        timerone= [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updasecond:) userInfo:nil repeats:YES];
    }

}

-(void)updasecond:(id)sender
{
    UIButton *button = (UIButton *)[self.view viewWithTag:EnGetVerCodeBtTag];
    NSString *strtemp = [button currentTitle];
    if([strtemp length]== 5)
    {
        [button setTitle:@"重新获取(60)" forState:UIControlStateNormal];
    }
    else
    {
        NSString *strsecond = [strtemp substringFromIndex:5];
        strsecond = [strsecond substringToIndex:[strsecond length]-1];
        int second = [strsecond intValue];
        [button setTitle:[NSString stringWithFormat:@"重新获取(%d)",second-1] forState:UIControlStateNormal];
        if(second > 1)
        {
            
            button.enabled = NO;
        }
        else
        {
            getyanzhengcodeflag = 0;
            [button setTitle:@"发送验证码" forState:UIControlStateNormal];
            button.enabled = YES;
            [timerone invalidate];
            timerone = nil;
        }
    }
}

-(void)returnback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 接口
//获取验证码
-(void)gotovercode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tel"] = textfieldphone.text;
    [RequestInterface doGetJsonWithParametersForUser:params App:app ReqUrl:InterfaceUserVerifyCode ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

//获取商城token
-(void)getstoretoken
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cw_user_id"] = app.userinfo.userid;
    
    
    [RequestInterface doGetJsonWithParametersForStore:params App:app ReqUrl:InterfaceStoreGetToken ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setValue:app.Gstoretoken forKey:DefaultStoreToken];
            [userDefaults synchronize];
            app.Gstoretoken = [dic objectForKey:@"auth_token"];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

//注册
-(void)clickregiestdone
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tel"] = textfieldphone.text;
    params[@"passwd"] = textfieldpwd.text;
    params[@"code"] = textfieldcode.text;
    
    [RequestInterface doGetJsonWithParametersForUser:params App:app ReqUrl:InterfaceUserRegiest ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSDictionary *tempdic = [dic objectForKey:@"data"];
            NSString *userid = [tempdic objectForKey:@"user_id"];
            NSString *username = [tempdic objectForKey:@"name"];
            NSString *userheader = [tempdic objectForKey:@"head_pic_path"];
            NSString *userheaderbg = [tempdic objectForKey:@"bg_pic_path"];
            NSString *tel = [tempdic objectForKey:@"tel"];
            NSDictionary *userdic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid, username,userheader,userheaderbg,tel,@"1", nil] forKeys:[NSArray arrayWithObjects:@"userid", @"username", @"head_pic_path",@"bg_pic_path", @"usertel", @"userstate", nil]];
            app.userinfo.userid = userid;
            app.userinfo.username = username;
            app.userinfo.userheader = userheader;
            app.userinfo.usertel = tel;
            app.userinfo.userstate = @"1";
            
            [self getstoretoken];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:userdic forKey:DefaultUserInfo];
            [userDefaults synchronize];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
