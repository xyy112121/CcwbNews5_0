//
//  LoginViewController.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.navigationController setNavigationBarHidden:NO];
    [[self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag] removeFromSuperview];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    [button setImage:LOADIMAGE(@"arrowleftred", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    // Do any additional setup after loading the view.

   
    
//    UISwipeGestureRecognizer *recognizer;
//    recognizer = [[ UISwipeGestureRecognizer alloc ] initWithTarget : self action : @selector (handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [self.view addGestureRecognizer:recognizer];
//    
//    recognizer = [[ UISwipeGestureRecognizer alloc ] initWithTarget : self action : @selector (handleSwipeFrom:)];
//    [recognizer setDirection :( UISwipeGestureRecognizerDirectionLeft)];
//    [self.view addGestureRecognizer :recognizer];
    
    [self initview];
    // Do any additional setup after loading the view.
}

-(void)initview
{
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = COLORNOW(240, 240, 240);
    
    self.title = @"登录";
    UIColor* color = [UIColor blackColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
    
    UIView *viewtop = [self topbanview:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-64)/2)];
    [self.view addSubview:viewtop];
    
    UIView *viewunder = [self underbanview:CGRectMake(0, XYViewBottom(viewtop), SCREEN_WIDTH, (SCREEN_HEIGHT-64)/2)];
    [self.view addSubview:viewunder];
}

//注册账号按钮上
-(UIView *)topbanview:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIView *viewwhite = [[UIView alloc] initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH-40, 100)];
    viewwhite.layer.borderColor = COLORNOW(220, 220, 220).CGColor;
    viewwhite.layer.borderWidth = 1.0f;
    viewwhite.backgroundColor = [UIColor whiteColor];
    [view addSubview:viewwhite];
    
    UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, XYViewWidth(viewwhite), 0.7)];
    imageline1.backgroundColor = COLORNOW(220, 220, 220);
    [viewwhite addSubview:imageline1];
    
    textfieldphone = [[UITextField alloc] initWithFrame:CGRectMake(5, 10,XYViewWidth(viewwhite)-20, 30)];
    textfieldphone.backgroundColor = [UIColor clearColor];
    textfieldphone.delegate = self;
    textfieldphone.font = FONTN(15.0f);
    textfieldphone.placeholder = @"手机号码";
    [viewwhite addSubview:textfieldphone];
    
    textfieldpwd = [[UITextField alloc] initWithFrame:CGRectMake(5, 60, 100, 30)];
    textfieldpwd.backgroundColor = [UIColor clearColor];
    textfieldpwd.delegate = self;
    textfieldpwd.secureTextEntry = YES;
    textfieldpwd.font = FONTN(15.0f);
    textfieldpwd.placeholder = @"密码";
    [viewwhite addSubview:textfieldpwd];
    
    
    UIImageView *imageline2 = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewWidth(viewwhite)-101, 60, 0.7, 30)];
    imageline2.backgroundColor = COLORNOW(220, 220, 220);
    [viewwhite addSubview:imageline2];
    
    UIButton *buttonforget = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonforget.frame = CGRectMake(XYViewWidth(viewwhite)-100, 55, 100, 40);
    [buttonforget setTitle:@"找回密码" forState:UIControlStateNormal];
    [buttonforget setTitleColor:COLORNOW(72, 72, 72) forState:UIControlStateNormal];
    buttonforget.titleLabel.font = FONTN(15.0f);
    [buttonforget addTarget:self action:@selector(clickforgetpwd:) forControlEvents:UIControlEventTouchUpInside];
    [viewwhite addSubview:buttonforget];
    
    //登录按钮
    UIButton *buttonlogin = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonlogin.frame = CGRectMake(20, XYViewBottom(viewwhite)+20,XYViewWidth(viewwhite), 50);
    [buttonlogin setTitle:@"登录" forState:UIControlStateNormal];
    [buttonlogin setBackgroundColor:COLORNOW(180, 180, 180)];
    buttonlogin.layer.cornerRadius = 3.0f;
    buttonlogin.clipsToBounds = YES;
    [buttonlogin addTarget:self action:@selector(clicklogin:) forControlEvents:UIControlEventTouchUpInside];
    buttonlogin.titleLabel.font = FONTMEDIUM(16.0f);
    buttonlogin.tag = EnLoginAccountBtTag;
    [buttonlogin setTitleColor:COLORNOW(120, 120, 120) forState:UIControlStateNormal];
    [view addSubview:buttonlogin];
    
    //注册账号
    UIButton *buttonregiest = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonregiest.frame = CGRectMake(XYViewLeft(buttonlogin), XYViewBottom(buttonlogin)+20,XYViewWidth(viewwhite), 40);
    [buttonregiest setTitle:@"注册账号" forState:UIControlStateNormal];
    [buttonregiest setBackgroundColor:[UIColor clearColor]];
    buttonregiest.titleLabel.font = FONTMEDIUM(16.0f);
    [buttonregiest addTarget:self action:@selector(gotoregiest:) forControlEvents:UIControlEventTouchUpInside];
    [buttonregiest setTitleColor:COLORNOW(30, 135, 225) forState:UIControlStateNormal];
    [view addSubview:buttonregiest];
    
    return view;
}

//注册账号按钮下
-(UIView *)underbanview:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 0.7)];
    imageline1.backgroundColor = COLORNOW(220, 220, 220);
    [view addSubview:imageline1];
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10,200,20)];
    labeltitle.text = @"还可以选择以下方式登录";
    labeltitle.font = FONTN(13.0f);
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = COLORNOW(178, 178, 178);
    [view addSubview:labeltitle];
    
    float nowwidth=((SCREEN_WIDTH-40)-100)/3;
    for(int i=0;i<3;i++)
    {
        
        UIImage *imagetem;
        NSString *strtem;
        switch (i) {
            case 0:
                imagetem = LOADIMAGE(@"微信icon", @"png");
                strtem = @"微信登录";
                break;
            case 1:
                imagetem = LOADIMAGE(@"微博icon", @"png");
                strtem = @"微博登录";
                break;
            case 2:
                imagetem = LOADIMAGE(@"QQicon", @"png");
                strtem = @"QQ登录";
                break;
        }
        
        UIView *viewthree = [self getthreebtview:CGRectMake(20+(nowwidth+50)*i, XYViewBottom(imageline1)+30, nowwidth, 150) Imagebt:imagetem LabelT:strtem];
        [view addSubview:viewthree];
    }
    
    return view;
}

-(UIView *)getthreebtview:(CGRect)frame Imagebt:(UIImage*)imagebt LabelT:(NSString *)labelt
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-20, frame.size.width-20)];
    imageicon.image = imagebt;
    imageicon.userInteractionEnabled = YES;
    if([labelt isEqualToString:@"微信登录"])
        imageicon.tag = EnThreeLoginWXImageTag;
    else if([labelt isEqualToString:@"微博登录"])
        imageicon.tag = EnThreeLoginWBImageTag;
    else if([labelt isEqualToString:@"QQ登录"])
        imageicon.tag = EnThreeLoginQQImageTag;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
    [imageicon addGestureRecognizer:singleTap];
    [view addSubview:imageicon];
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, XYViewBottom(imageicon)+10,frame.size.width,20)];
    labeltitle.text = labelt;
    labeltitle.font = FONTN(14.0f);
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = COLORNOW(78, 78, 78);
    labeltitle.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labeltitle];
    
    
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
    UIButton *button = [self.view viewWithTag:EnLoginAccountBtTag];
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
-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
    int tagnow = (int)[sender.view tag];
    if(tagnow == EnThreeLoginWXImageTag)
    {
        [self wxlogin:nil];
    }
    else if(tagnow == EnThreeLoginWBImageTag)
    {
        [self Sinalogin:nil];
    }
    else if(tagnow == EnThreeLoginQQImageTag)
    {
        [self QQlogin:nil];
    }
}

-(void)returnback:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)clicklogin:(id)sender
{
    if([textfieldphone.text length]==0||[textfieldpwd.text length]==0)
    {
        [MBProgressHUD showError:@"请填写电话和密码" toView:app.window];
    }
    else if(![AddInterface isValidateMobile:textfieldphone.text])
    {
        [MBProgressHUD showError:@"请填写正确的电话格式" toView:app.window];
    }
    else
    {
        [self clicklogindone];
    }
}

-(void)gotoregiest:(id)sender
{
    RegiestViewController *regiest = [[RegiestViewController alloc] init];
    [self.navigationController pushViewController:regiest animated:YES];
}

-(void)clickforgetpwd:(id)sender
{
    ForGetPwdViewController *regiest = [[ForGetPwdViewController alloc] init];
    [self.navigationController pushViewController:regiest animated:YES];
}

#pragma mark 第三方登录
-(void)wxlogin:(id)sender
{
    DLog(@"wxlogin");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            DLog(@"error==%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            NSMutableDictionary *arraylogin = [[NSMutableDictionary alloc] init];
            [arraylogin setValue:resp.uid forKey:@"login_id" ];
            [arraylogin setValue:resp.name forKey:@"login_name" ];
            [arraylogin setValue:@"WX" forKey:@"login_type" ];
            [arraylogin setValue:resp.iconurl forKey:@"head_pic" ];
            [arraylogin setValue:app.Gmachid forKey:@"cw_machine_id" ];
            [arraylogin setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.latitude] forKey:@"cw_latitude" ];
            [arraylogin setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.longitude] forKey:@"cw_longitude" ];
            
            
            [self gotothreelogin:arraylogin];
        }
    }];
}

-(void)QQlogin:(id)sender
{
    DLog(@"qqlogin");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            
            NSMutableDictionary *arraylogin = [[NSMutableDictionary alloc] init];
            [arraylogin setValue:resp.uid forKey:@"login_id" ];
            [arraylogin setValue:resp.name forKey:@"login_name" ];
            [arraylogin setValue:@"QQ" forKey:@"login_type" ];
            [arraylogin setValue:resp.iconurl forKey:@"head_pic" ];
            [arraylogin setValue:app.Gmachid forKey:@"cw_machine_id" ];
            [arraylogin setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.latitude] forKey:@"cw_latitude" ];
            [arraylogin setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.longitude] forKey:@"cw_longitude" ];
            [self gotothreelogin:arraylogin];
        }
    }];
}

-(void)Sinalogin:(id)sender
{
    DLog(@"sinalogin");
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            DLog(@"error==%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            
            NSMutableDictionary *arraylogin = [[NSMutableDictionary alloc] init];
            [arraylogin setValue:resp.uid forKey:@"login_id" ];
            [arraylogin setValue:resp.name forKey:@"login_name" ];
            [arraylogin setValue:@"SINA" forKey:@"login_type" ];
            [arraylogin setValue:resp.iconurl forKey:@"head_pic" ];
            [arraylogin setValue:app.Gmachid forKey:@"cw_machine_id" ];
            [arraylogin setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.latitude] forKey:@"cw_latitude" ];
            [arraylogin setValue:[NSString stringWithFormat:@"%f",app.diliweizhi.longitude] forKey:@"cw_longitude" ];
            [self gotothreelogin:arraylogin];
        }
    }];
}

-(void)aduserdefaultuser:(NSDictionary *)tempdic
{
    
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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userdic forKey:DefaultUserInfo];
    [userDefaults synchronize];
}

#pragma mark 接口
//登录
-(void)clicklogindone
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tel"] = textfieldphone.text;
    params[@"passwd"] = textfieldpwd.text;
    
    [RequestInterface doGetJsonWithParametersForUser:params App:app ReqUrl:InterfaceUserLogin ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSDictionary *tempdic = [dic objectForKey:@"data"];
            [self aduserdefaultuser:tempdic];
            [self returnback:nil];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

//第三方登录
-(void)gotothreelogin:(NSDictionary *)params
{
    
    [RequestInterface doGetJsonWithParametersForUser:params App:app ReqUrl:InterfaceUserThreeLogin ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSDictionary *tempdic = [dic objectForKey:@"data"];
            [self aduserdefaultuser:tempdic];
            [self returnback:nil];
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
