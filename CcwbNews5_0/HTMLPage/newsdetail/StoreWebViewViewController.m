//
//  StoreWebViewViewController.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "StoreWebViewViewController.h"

@interface StoreWebViewViewController ()

@end

@implementation StoreWebViewViewController
-(void)returnback:(id)sender
{
    [[self.view viewWithTag:1800] removeFromSuperview];
    
    if (webview.canGoBack)
    {
        [webview goBack];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if(loginflag != 0)
    {
        [webview loadRequest:nil];
        [webview removeFromSuperview];
        webview = nil;
        webview.delegate = nil;
        [webview stopLoading];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.navigationController setNavigationBarHidden:NO];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    [button setImage:LOADIMAGE(@"arrowleftred", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;

    self.view.backgroundColor = [UIColor whiteColor];
    [self initparament:nil];
    // Do any additional setup after loading the view.
}

-(void)gotologipage
{
    loginflag = 0;
    LoginViewController *login = [[LoginViewController alloc] init];
    login.delegate1 = self;
    UINavigationController *nctl  = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nctl animated:YES completion:nil];
}

#pragma mark Actiondegate
-(void)DGLoginSuccess:(NSString *)success
{
    NSString *jsMethod = [NSString stringWithFormat:@"uploadiostoken('%@')", self.app.cwtoken];
    [webview stringByEvaluatingJavaScriptFromString:jsMethod];
    [webview reload];
}

#pragma mark 滑动事件
- (void)handleSwipeFrom:( UISwipeGestureRecognizer *)sender
{
    DLog(@"UISwipeGestureRecognizerDirectionRight");
    
    if ((sender. direction == UISwipeGestureRecognizerDirectionRight))
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    }
    else if((sender. direction == UISwipeGestureRecognizerDirectionLeft))
    {
        
    }
}


-(void)initparament:(id)sender
{
    [self initview:nil];
    reloadflag = 0;
    self.app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[ UISwipeGestureRecognizer alloc ] initWithTarget : self action : @selector (handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
    
    recognizer = [[ UISwipeGestureRecognizer alloc ] initWithTarget : self action : @selector (handleSwipeFrom:)];
    [recognizer setDirection :( UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer :recognizer];
    
    
}

-(void)initview:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        
        NSString* urlpath = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:@""];
        if([self.strfromurl length]>0)
            urlpath = [urlpath stringByAppendingString:self.strfromurl];//@"#/order"];
        webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
        webview.backgroundColor = [UIColor clearColor];
        webview.delegate = self;
        webview.tag = 8090;
        NSURL *urlstr = [NSURL URLWithString:urlpath];
        NSURLRequest *request = [NSURLRequest requestWithURL:urlstr];
        [webview loadRequest:request];
        webview.scalesPageToFit = YES;
        [self.view addSubview:webview];
        
        
        for (UIView *_aView in [webview subviews])
        {
            if ([_aView isKindOfClass:[UIScrollView class]])
            {
                [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条
                
                for (UIView *_inScrollview in _aView.subviews)
                {
                    if ([_inScrollview isKindOfClass:[UIImageView class]])
                    {
                        _inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
                    }
                }
            }
        }
        YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-150, 200, 200)];
        [self.view addSubview:imageViewgif];
        imageViewgif.tag = 1800;
        imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];

    });
    
    
    
}

-(void)removeimagegif:(id)sender
{
    [[self.view viewWithTag:1800] removeFromSuperview];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[self.view viewWithTag:1800] removeFromSuperview];

    if(reloadflag == 0)
    {
        reloadflag = 1;
        NSString *jsMethod;
        if([AddInterface judgeislogin])
        {
            jsMethod = [NSString stringWithFormat:@"uploadiostoken('%@')", self.app.cwtoken];
        }
        else
        {
            jsMethod = [NSString stringWithFormat:@"uploadiostoken('%@')", @""];
        }
        [webView stringByEvaluatingJavaScriptFromString:jsMethod];
        [webView reload];
    }
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __block typeof(self) weakSelf = self;
    self.context[@"commonBack"] =
    ^(NSString *viewname)
    {
        [weakSelf returnback:nil];
 
    };
    self.context[@"openBizShare"] =
    ^(NSString *json)
    {
        NSDictionary *dicgoods = [AddInterface dictionaryWithJsonString:json];
        [weakSelf setUMshare];
        [weakSelf showshareinfo:dicgoods];
        DLog(@"====%@",json);
    };
    self.context[@"appCallPay"] =
    ^(NSString *json)
    {
//        NSDictionary *diczhifu = [AddInterface dictionaryWithJsonString:json];
        [weakSelf initwxsdk:json];
        DLog(@"====%@",json);
    };
    self.context[@"cwLogin"] =
    ^(NSString *json)
    {
        if([AddInterface judgeislogin])
        {
            NSString *jsMethod = [NSString stringWithFormat:@"uploadiostoken('%@')", weakSelf.app.cwtoken];
            [webView stringByEvaluatingJavaScriptFromString:jsMethod];
            [webView reload];
        }
        else
        {
            [weakSelf gotologipage];
        }
    };
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];//6602850289
    DLog(@"requestString====%@",requestString);
    
    return YES;
}

#pragma mark 微信支付
-(void)initwxsdk:(NSString *)strorder
{
    strorder = [strorder  stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
    NSData *data = [strorder dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *tempdic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [WXApiManager sharedManager].delegate = self;
    NSString *res = [WXApiRequestHandler jumpToBizPay:tempdic];
    if( ![@"" isEqual:res] ){
        NSString* urlpath = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:@""];
        urlpath = [urlpath stringByAppendingString:@"#/order?order_state=20"];
        NSURL *urlstr = [NSURL URLWithString:urlpath];
        NSURLRequest *request = [NSURLRequest requestWithURL:urlstr];
        [webview loadRequest:request];

        DLog(@"res====%@",res);
    }
}

#pragma mark 分享
-(void)setUMshare
{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               @(UMSocialPlatformType_QQ),
                                               @(UMSocialPlatformType_Qzone),
                                               @(UMSocialPlatformType_Sina)
                                               ]];
    //设置分享面板的显示和隐藏的代理回调
    [UMSocialUIManager setShareMenuViewDelegate:self];
}


- (void)showshareinfo:(NSDictionary *)dicfrom
{
    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Middle;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [self runShareWithType:platformType Dicfrom:dicfrom];
    }];
}

- (void)runShareWithType:(UMSocialPlatformType)type Dicfrom:(NSDictionary *)dicfrom
{
    //	if(type==UMSocialPlatformType_Sina)
    //	{
    [self shareWebPageToPlatformType:type Dicfrom:dicfrom];
    //	}
}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType Dicfrom:(NSDictionary *)dicfrom
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  [dicfrom objectForKey:@"share_pic_path"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[dicfrom objectForKey:@"title"] descr:[[dicfrom objectForKey:@"summary"] length]>0?[dicfrom objectForKey:@"summary"]:[dicfrom objectForKey:@"title"] thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = [dicfrom objectForKey:@"share_url"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }
        else
        {
            if ([data isKindOfClass:[UMSocialShareResponse class]])
            {
                UMSocialShareResponse *resp = data;
                NSString *sharetype;
                if(platformType==UMSocialPlatformType_Sina)
                {
                    sharetype = @"sina";
                }
                else if(platformType==UMSocialPlatformType_WechatSession)
                {
                    sharetype = @"wechat";
                }
                else if(platformType==UMSocialPlatformType_WechatTimeLine)
                {
                    sharetype = @"wxcircle";
                }
                else if(platformType==UMSocialPlatformType_QQ)
                {
                    sharetype = @"qq";
                }
                else if(platformType==UMSocialPlatformType_Qzone)
                {
                    sharetype = @"qzone";
                }
                
                [self getShareInfoCallBack:[dicfrom objectForKey:@"cw_id"] ShareType:sharetype];
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }
            else
            {
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}


- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"分享出错,错误码: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"确定", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark 接口
-(void)getShareInfoCallBack:(NSString *)sender ShareType:(NSString *)sharetype
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cw_id"] = sender;
    params[@"cw_type"] = sharetype;
    params[@"share_id"] = [AddInterface RandomId:32];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:self.app ReqUrl:InterfaceShareCallBack ShowView:self.app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:self.app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.app.window];
        
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
