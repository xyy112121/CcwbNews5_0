//
//  WkWebViewCustomViewController.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WkWebViewCustomViewController.h"

@interface WkWebViewCustomViewController ()<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>

@property (strong, nonatomic)   WKWebView                   *wkwebview;
@end

@implementation WkWebViewCustomViewController
@synthesize wkwebview;

-(void)returnback:(id)sender
{
	self.app.allowRotation = 0;
	if([[self.strurl lowercaseString] rangeOfString:[@"/User/Login/index" lowercaseString]].location !=NSNotFound)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
	else if (wkwebview.canGoBack)
	{
		[wkwebview goBack];
	}
	else
	{
		
		[self.navigationController popViewControllerAnimated:YES];
	}
}


-(void)viewWillAppear:(BOOL)animated
{
	self.app.allowRotation = 0;
	self.app.gnctl = self.navigationController;
	if(ennctl==EnNavigateionYES)
		[self.navigationController setNavigationBarHidden:NO animated:YES];
	else
		[self.navigationController setNavigationBarHidden:YES animated:YES];
	if(hpna)
	{
		[[self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag] removeFromSuperview];
		[self.navigationController.navigationBar addSubview:hpna];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	[self.navigationController setNavigationBarHidden:NO];
	ennctl = EnNavigateionYES;
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
	self.title = self.strtitle;
	flagloading = 0;
	webviewtype = EnWebViewSingle;
	self.view.backgroundColor = [UIColor whiteColor];
	self.app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[self initWKWebView];
	
	UISwipeGestureRecognizer *recognizer;
	recognizer = [[ UISwipeGestureRecognizer alloc ] initWithTarget : self action : @selector (handleSwipeFrom:)];
	[recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
	[self.view addGestureRecognizer:recognizer];
	
	recognizer = [[ UISwipeGestureRecognizer alloc ] initWithTarget : self action : @selector (handleSwipeFrom:)];
	[recognizer setDirection :( UISwipeGestureRecognizerDirectionLeft)];
	[self.view addGestureRecognizer :recognizer];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(begainFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil];//进入全屏
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];//退出全屏
}

- (void)initWKWebView
{
	userContentController = [[WKUserContentController alloc] init];
	WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//    configuration.allowsInlineMediaPlayback = YES;
	configuration.userContentController = userContentController;
    
	[userContentController addScriptMessageHandler:self name:@"commonBack"];
	[userContentController addScriptMessageHandler:self name:@"getAppUserInfo"];
	[userContentController addScriptMessageHandler:self name:@"addApp"];
	[userContentController addScriptMessageHandler:self name:@"openAppManage"];
	[userContentController addScriptMessageHandler:self name:@"openApp"];        //打开app频道
	[userContentController addScriptMessageHandler:self name:@"loginsucessIOS"];  //登录成功返回用户信息
	[userContentController addScriptMessageHandler:self name:@"openAppImage"];   //选择图片上传
	[userContentController addScriptMessageHandler:self name:@"setHeadBarVisible"]; //设置导航 栏是否显示
	[userContentController addScriptMessageHandler:self name:@"cwImageQRCode"];// 二维码识别
	[userContentController addScriptMessageHandler:self name:@"openShare"];  //点击 分享
	[userContentController addScriptMessageHandler:self name:@"showVideo"];  // 播放视频
	[userContentController addScriptMessageHandler:self name:@"cwLoginWX"]; //微信登录
	[userContentController addScriptMessageHandler:self name:@"cwLoginQQ"]; //QQ登录
	[userContentController addScriptMessageHandler:self name:@"cwLoginSina"]; //sina登录
	[userContentController addScriptMessageHandler:self name:@"setWebviewWindows"];//设置webview是单个窗口内打开还是多个窗口push进入
	[userContentController addScriptMessageHandler:self name:@"cwOrderInfo"];//支付发起
	[userContentController addScriptMessageHandler:self name:@"cwHeadBarConfig"];//获取导航 栏信息
	[userContentController addScriptMessageHandler:self name:@"getiostoke"];
    [userContentController addScriptMessageHandler:self name:@"ShowNewsDetail"];
	
    
    
	WKPreferences *preferences = [WKPreferences new];
	preferences.javaScriptCanOpenWindowsAutomatically = YES;
//	preferences.minimumFontSize = 10.0;
	configuration.preferences = preferences;
	
//	self.wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
//											configuration:configuration];
	
	
    self.wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)
                                        configuration:configuration];
    
    

//    NSString* urlpath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:urlpath];
//    [self.wkwebview loadFileURL:url allowingReadAccessToURL:url];
//    self.wkwebview.navigationDelegate = self;
//    self.wkwebview.UIDelegate = self;
//    [self.view addSubview:self.wkwebview];
    
	//商城的用单页 判断商城域名
	if(([self.strurl rangeOfString:@"newapp.ccwb.cn"].location !=NSNotFound)||([self.strurl rangeOfString:@"newuser.ccwb.cn"].location !=NSNotFound))
	{
		webviewtype = EnWebViewMuli;
	}
	

	__weak typeof(self) weakSelf = self;
	[self.wkwebview evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
		__strong typeof(weakSelf) strongSelf = weakSelf;
		
		NSString *userAgent = result;
		if([result rangeOfString:@"ccwb_app/ios"].location ==NSNotFound)
		{
			NSString *newUserAgent = [userAgent stringByAppendingString:@";ccwb_app/ios"];
			
			NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
			[[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
		}
		strongSelf.wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
													 configuration:configuration];
		NSURL *fileURL = [NSURL URLWithString:strongSelf.strurl];
		NSURLRequest *request  = [NSURLRequest requestWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
		[strongSelf.wkwebview loadRequest:request];
		strongSelf.wkwebview.navigationDelegate = self;
		strongSelf.wkwebview.UIDelegate = self;
		[strongSelf.view addSubview:self.wkwebview];
		
//		UIScrollView *scroller = [strongSelf.wkwebview.subviews objectAtIndex:0];
//		if ([scroller isKindOfClass:[UIScrollView class]]&&scroller)
//		{
//			scroller.bounces = NO;
//			scroller.alwaysBounceVertical = NO;
//			scroller.alwaysBounceHorizontal = NO;
//		}
        
		YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
		imageViewgif.tag = EnYLImageViewTag;
		imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
		[strongSelf.view insertSubview:imageViewgif aboveSubview:self.wkwebview];
	}];
	
	self.wkwebview.backgroundColor = [UIColor clearColor];
    self.wkwebview.scrollView.bounces =YES;
	self.wkwebview.scrollView.showsVerticalScrollIndicator = YES;
	self.wkwebview.scrollView.showsHorizontalScrollIndicator = YES;
    self.wkwebview.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0,  0, 0);
	UIScrollView *scroller = [self.wkwebview.subviews objectAtIndex:0];
	if ([scroller isKindOfClass:[UIScrollView class]]&&scroller)
	{
		scroller.bounces = YES;
		scroller.alwaysBounceVertical = YES;
		scroller.alwaysBounceHorizontal = YES;
	}

}

- (void)dealloc
{
	NSLog(@"%s",__FUNCTION__);
	[userContentController removeScriptMessageHandlerForName:@"commonBack"];
	[userContentController removeScriptMessageHandlerForName:@"getAppUserInfo"];
	[userContentController removeScriptMessageHandlerForName:@"addApp"];
	[userContentController removeScriptMessageHandlerForName:@"openAppManage"];
	[userContentController removeScriptMessageHandlerForName:@"openApp"];
	[userContentController removeScriptMessageHandlerForName:@"loginsucessIOS"];
	[userContentController removeScriptMessageHandlerForName:@"openAppImage"];
	[userContentController removeScriptMessageHandlerForName:@"openAppVideo"];
	[userContentController removeScriptMessageHandlerForName:@"openAppAudio"];
	[userContentController removeScriptMessageHandlerForName:@"openAppCamera"];
	[userContentController removeScriptMessageHandlerForName:@"setHeadBarVisible"];
	[userContentController removeScriptMessageHandlerForName:@"cwImageQRCode"];
	[userContentController removeScriptMessageHandlerForName:@"openShare"];
	[userContentController removeScriptMessageHandlerForName:@"getAppUserInfo"];
	[userContentController removeScriptMessageHandlerForName:@"showVideo"];
	[userContentController removeScriptMessageHandlerForName:@"cwLoginWX"];
	[userContentController removeScriptMessageHandlerForName:@"cwLoginQQ"];
	[userContentController removeScriptMessageHandlerForName:@"cwLoginSina"];
	[userContentController removeScriptMessageHandlerForName:@"setWebviewWindows"];
	[userContentController removeScriptMessageHandlerForName:@"cwOrderInfo"];
	[userContentController removeScriptMessageHandlerForName:@"cwHeadBarConfig"];
    [userContentController removeScriptMessageHandlerForName:@"ShowNewsDetail"];
}

#pragma mark 滑动事件
- (void)handleSwipeFrom:( UISwipeGestureRecognizer *)sender
{
	DLog(@"UISwipeGestureRecognizerDirectionRight");
	
	if ((sender. direction == UISwipeGestureRecognizerDirectionRight))
	{
		[self returnback];
	}
	else if((sender. direction == UISwipeGestureRecognizerDirectionLeft))
	{
		
	}
}

#pragma mark - WKScriptMessageHandler

-(void)gotoreturnjs:(NSDictionary *)dicfrom JSFunction:(NSString *)jsf
{
	DLog(@"custom====%@",[CustomPageObject convertToJSONData:dicfrom]);
	NSString *js = [NSString stringWithFormat:@"%@(%@)",jsf, [CustomPageObject convertToJSONData:dicfrom]];
	[self.wkwebview evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
		//TODO
		NSLog(@"responsec %@ %@",response,error);
	}];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
	NSLog(@"body:%@,%@",message.body,message.name);
	if ([message.name isEqualToString:@"commonBack"]) //返回
	{
		if (wkwebview.canGoBack)
		{
			[wkwebview goBack];
		}
		else
		{
			[self.navigationController popViewControllerAnimated:YES];
		}
	}
	else if([message.name isEqualToString:@"getAppUserInfo"])  //从用户端获取个人信息
	{
		
	}
	else if([message.name isEqualToString:@"loginsucessIOS"])  //登录成功后返回用户信息
	{
		[CustomPageObject CUgetUserInfo:self.app StrJson:message.body];
		[self returnback];
	}
	else if([message.name isEqualToString:@"addApp"])  //添加app
	{
		NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] init];
		[dictemp setValue:@"true" forKey:@"success"];
		[dictemp setValue:@"获取信息成功" forKey:@"msg"];
		[dictemp setValue:self.app.Gmachid forKey:@"cw_machine_id"];
		[dictemp setValue:self.app.userinfo.userid forKey:@"cw_user_id"];
		[self gotoreturnjs:dictemp JSFunction:@"getAppUserInfoIOS"];
	}
	else if([message.name isEqualToString:@"openApp"]) //打开app
	{
		[self clickopenapplication:message.body];
	}
	else if([message.name isEqualToString:@"setHeadBarVisible"]) //判断 是否有导航栏
	{
		[self setnactlvisible:message.body];
	}
	else if([message.name isEqualToString:@"cwImageQRCode"]) //二维码识别
	{
		[self identifyscancode:message.body];
	}
	else if([message.name isEqualToString:@"openShare"]) //点击分享
	{
		[self clickshare:message.body];
	}
	else if([message.name isEqualToString:@"showVideo"]) // 播放视频
	{
		[self playvideo:message.body];
	}
	else if([message.name isEqualToString:@"cwLoginWX"]) //微信登录
	{
		[self wxlogin:message.body];
	}
	else if([message.name isEqualToString:@"cwLoginQQ"]) //QQ登录
	{
		[self QQlogin:message.body];
	}
	else if([message.name isEqualToString:@"cwLoginSina"]) //新浪登录
	{
		[self Sinalogin:message.body];
	}
	else if([message.name isEqualToString:@"setWebviewWindows"])
	{
		[self setwebviewwindowtype:message.body];
	}
	else if([message.name isEqualToString:@"openAppImage"])  //调用选择图片
	{
		[self webviewuploadpic:message.body];
	}
	else if([message.name isEqualToString:@"cwOrderInfo"]) //支付订单调用
	{
		[self initwxsdk:message.body];
	}
	else if([message.name isEqualToString:@"cwHeadBarConfig"])  //设置导航 栏view
	{
		[self setnctlview:message.body];
	}
    else if([message.name isEqualToString:@"getiostoke"])
    {
        DLog(@"123");
    }
    else if([message.name isEqualToString:@"ShowNewsDetail"]) //第三方网页显示新闻连接
    {
        NSString *strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,message.body];
        WkWebViewCustomViewController *webviewcustom = [[WkWebViewCustomViewController alloc] init];
        if([strurl rangeOfString:@"?"].location !=NSNotFound)
        {
            strurl = [NSString stringWithFormat:@"%@&cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",strurl,CwVersion,CwDevice,self.app.Gmachid,[self.app.userinfo.userid length]>0?self.app.userinfo.userid:@""];
        }
        else
        {
            strurl = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",strurl,CwVersion,CwDevice,self.app.Gmachid,[self.app.userinfo.userid length]>0?self.app.userinfo.userid:@""];
        }
        webviewcustom.strurl = strurl;
        [self.navigationController pushViewController:webviewcustom animated:YES];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
	DLog(@"开始加载");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
	DLog(@"加载完成");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
    NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] init];
    [dictemp setValue:@"true" forKey:@"success"];
    [dictemp setValue:@"获取信息成功" forKey:@"msg"];
    [dictemp setValue:self.app.Gmachid forKey:@"cw_machine_id"];
    [dictemp setValue:self.app.userinfo.userid==nil?@"":self.app.userinfo.userid forKey:@"cw_user_id"];
    [self gotoreturnjs:dictemp JSFunction:@"getAppUserInfoIOS"];
	if(ennctl==EnNavigateionYES)
		self.wkwebview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
	else
		self.wkwebview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	
    
	NSString *JsStr = @"(document.getElementsByTagName(\"video\")[0]).src";
	[webView evaluateJavaScript:JsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
		if(![response isEqual:[NSNull null]] && response != nil){
			//截获到视频地址了
			NSLog(@"response == %@",response);
		}else{
			//没有视频链接
		}
	}];
	
	__block WkWebViewCustomViewController *weakSelf = self;
	dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
	dispatch_after(delayTime, dispatch_get_main_queue(), ^{
		[[weakSelf.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	});
	
	
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
	[self.wkwebview reload];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
	[[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	DLog(@"55555");
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
	DLog(@"22222");
}



// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
	DLog(@"333333");
	NSLog(@"%@",navigationResponse.response.URL.absoluteString);
	NSString *requestString = navigationResponse.response.URL.absoluteString;
	//允许跳转
	if((webviewtype == EnWebViewSingle)||([requestString rangeOfString:@"cw_redirect=true"].location !=NSNotFound))
	{
		decisionHandler(WKNavigationResponsePolicyAllow);
	}
	else
	{
		if(flagloading == 0)
		{
			flagloading = 1;
			decisionHandler(WKNavigationResponsePolicyAllow);
		}
		else
			decisionHandler(WKNavigationResponsePolicyCancel);
	
	}
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
	DLog(@"3453453");
	NSLog(@"%@",navigationAction.request.URL.absoluteString);
	NSString *requestString = navigationAction.request.URL.absoluteString;
	
    
	if((webviewtype == EnWebViewSingle)||([requestString rangeOfString:@"cw_redirect=true"].location !=NSNotFound))
	{
		if(([requestString rangeOfString:@"favicon"].location !=NSNotFound))
        {
            decisionHandler(WKNavigationActionPolicyCancel);
        }
		else if(([requestString rangeOfString:@"cw_user_id"].location ==NSNotFound)&&([requestString rangeOfString:@"cw_machine_id"].location == NSNotFound))
		{
			decisionHandler(WKNavigationActionPolicyCancel);
			if([requestString rangeOfString:@"?"].location !=NSNotFound)
			{
				requestString = [NSString stringWithFormat:@"%@&cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requestString,CwVersion,CwDevice,self.app.Gmachid,[self.app.userinfo.userid length]>0?self.app.userinfo.userid:@""];
			}
			else
			{
				requestString = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requestString,CwVersion,CwDevice,self.app.Gmachid,[self.app.userinfo.userid length]>0?self.app.userinfo.userid:@""];
			}
			self.strurl = requestString;
			[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestString]]];
		}
		else
		{
			decisionHandler(WKNavigationActionPolicyAllow);
		}
//		[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestString]]];
		
	}

	else
	{
		NSArray *arraystr = [requestString componentsSeparatedByString:@"html"];
		NSArray *arrayurl = [self.strurl componentsSeparatedByString:@"html"];
		if([[arraystr objectAtIndex:0] isEqualToString:[arrayurl objectAtIndex:0]])
		{
			//允许跳转
			if(flagloading == 0)
			{
				decisionHandler(WKNavigationActionPolicyAllow);
			}
			else
			{
				decisionHandler(WKNavigationActionPolicyCancel);
			}
		}
		else
		{
			//允许跳转
			decisionHandler(WKNavigationActionPolicyAllow);
			WkWebViewCustomViewController *webviewcustom = [[WkWebViewCustomViewController alloc] init];
			if([requestString rangeOfString:@"?"].location !=NSNotFound)
			{
				requestString = [NSString stringWithFormat:@"%@&cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requestString,CwVersion,CwDevice,self.app.Gmachid,[self.app.userinfo.userid length]>0?self.app.userinfo.userid:@""];
			}
			else
			{
				requestString = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requestString,CwVersion,CwDevice,self.app.Gmachid,[self.app.userinfo.userid length]>0?self.app.userinfo.userid:@""];
			}
			webviewcustom.strurl = requestString;
			[self.navigationController pushViewController:webviewcustom animated:YES];
		}
	}
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler();
	}])];
	
	[self presentViewController:alertController animated:YES completion:nil];
	
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
	//    DLOG(@"msg = %@ frmae = %@",message,frame);
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(NO);
	}])];
	[alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(YES);
	}])];
	
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		textField.text = defaultText;
	}];
	[alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(alertController.textFields[0].text?:@"");
	}])];
	
	[self presentViewController:alertController animated:YES completion:nil];
	
}

#pragma mark ActionDelegate
-(void)DGCLickNctlEvent:(NSString *)jsevent
{
	DLog(@"custom====%@",jsevent);
	NSString *js = [NSString stringWithFormat:@"%@",jsevent];
	[self.wkwebview evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
		//TODO
		NSLog(@"responsec %@ %@",response,error);
	}];
}

-(void)DGClickWebViewAddApp:(NSDictionary *)dictemp
{
    [self clickaddapplication:dictemp];
}

-(void)DGClickWebViewOpenApp:(NSString *)srcid
{
    if([self.delegate1 respondsToSelector:@selector(DGClickOpenApplication:)])
    {
        [self.delegate1 DGClickOpenApplication:srcid];
    }
    [self returnback];
}

#pragma mark IBAction

-(void)setnactlvisible:(id)sender
{
	DLog(@"sender====%@",sender);
	if([sender isEqualToString:@"false"])
	{
		ennctl = EnNavigateionNO;
		[self.navigationController setNavigationBarHidden:YES animated:YES];
	}
	else
	{
		ennctl = EnNavigateionYES;
		[self.navigationController setNavigationBarHidden:NO animated:YES];
	}
	
	if(ennctl==EnNavigateionYES)
		self.wkwebview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
	else
		self.wkwebview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

-(void)openAppMange:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGClickOpenAppManger:)])
	{
		[self.delegate1 DGClickOpenAppManger:sender];
	}
}

-(void)clickaddapplication:(NSDictionary *)sender
{
	DLog(@"sender====%@",sender);
	
	if([self.delegate1 respondsToSelector:@selector(DGclickAddAppMachine:)])
	{
		[self.app.arrayaddapplication addObject:sender];
		[self.delegate1 DGclickAddAppMachine:sender];
	}
}

-(void)clickopenapplication:(NSString *)sender
{
	DLog(@"sender====%@",sender);
	
	if([self.delegate1 respondsToSelector:@selector(DGClickOpenApplication:)])
	{
		[self.navigationController popToRootViewControllerAnimated:YES];
		[self.delegate1 DGClickOpenApplication:sender];
	}
}

-(void)clickshare:(NSString *)sender
{
	[self getShareInfo:sender];
}

-(void)returnback
{
	[[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	[self.navigationController popViewControllerAnimated:YES];
	
}



-(void)identifyscancode:(NSString *)strurl
{
	//处理选中的相片,获得二维码里面的内容
	ZBarReaderController *reader = [[ZBarReaderController alloc] init];
	NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:strurl]];
	UIImage *image = [UIImage imageWithData:data];//[info objectForKey:UIImagePickerControllerOriginalImage];
	CGImageRef cgimage = image.CGImage;
	ZBarSymbol *symbol = nil;
	for(symbol in [reader scanImage:cgimage])
		break;
	NSString *urlStr = symbol.data;
	

	
	if(urlStr==nil || urlStr.length<=0){
		//二维码内容解析失败
		UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"此二维码不能识别" message:nil preferredStyle:UIAlertControllerStyleAlert];
		__weak __typeof(self) weakSelf = self;
		UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
			
		}];
		[alertVC addAction:action];
		[weakSelf presentViewController:alertVC animated:YES completion:^{
		}];
		
		return;
	}
	//	[self getscancodevalid:urlStr Typeid:codetype==EnToOrgin?@"suyuan":@"fanli"];
	NSLog(@"urlStr: %@",urlStr);
}

-(void)playvideo:(NSString *)playvideourl
{
	NSURL * videoURL = [NSURL URLWithString:playvideourl];
	AVPlayerViewController *avPlayer = [[AVPlayerViewController alloc] init];
	avPlayer.player = [[AVPlayer alloc] initWithURL:videoURL];
	/*
	 可以设置的值及意义如下：
	 AVLayerVideoGravityResizeAspect   不进行比例缩放 以宽高中长的一边充满为基准
	 AVLayerVideoGravityResizeAspectFill 不进行比例缩放 以宽高中短的一边充满为基准
	 AVLayerVideoGravityResize     进行缩放充满屏幕
	 */
	avPlayer.videoGravity = AVLayerVideoGravityResizeAspect;
//	avPlayer.view.bounds = CGRectMake(0, 0, 350, 300);
//	avPlayer.view.center = CGPointMake(CGRectGetMidX(self.view.bounds), 64 + CGRectGetMidY(avPlayer.view.bounds) + 30);
	[avPlayer.player play];
	avPlayer.delegate = self;
//	[self addChildViewController:avPlayer];
//	[self.view addSubview:avPlayer.view];
	
	[self presentViewController:avPlayer animated:YES completion:nil];
	
}

-(void)webviewuploadpic:(id)sender
{
	[self clickselectphoto:sender];
}

-(void)setwebviewwindowtype:(NSString *)type
{
	if([type isEqualToString:@"true"])
	{
		webviewtype = EnWebViewSingle;
	}
	else
	{
		webviewtype = EnWebViewMuli;
	}
}

-(void)setnctlview:(NSString *)body
{
	[[self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag] removeFromSuperview];
	
	NSDictionary *dic = [AddInterface dictionaryWithJsonString:body];
	
	hpna = [[HpNavigateView alloc] initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH, 44) DicFrom:dic];
	hpna.delegate1 = self;
	hpna.tag = EnHpNctlViewTag;
	[self.navigationController.navigationBar addSubview:hpna];

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
		DLog(@"res====%@",res);
	}
}


#pragma mark 上传图片
- (void)clickselectphoto:(id)sender{
	FYAlbumManager * manager =[FYAlbumManager shareAlbumManager];
	manager.maxSelect = 1;
	manager.delegate1 = self;
	manager.complate = ^(NSArray *array)
	{
		
		if([array count]>0)
		{
			DLog(@"array====%@",[array objectAtIndex:0]);
			UIImage *selectimage = [[array objectAtIndex:0] objectForKey:@"result"];
			NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
			[arrayimage addObject:selectimage];
			[self uploadpic:arrayimage];
		}
	};
	[manager showInView:self Photo:@"4"];  //相册,相机
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
			[arraylogin setValue:self.app.Gmachid forKey:@"cw_machine_id" ];
			[arraylogin setValue:[NSString stringWithFormat:@"%f",self.app.diliweizhi.latitude] forKey:@"cw_latitude" ];
			[arraylogin setValue:[NSString stringWithFormat:@"%f",self.app.diliweizhi.longitude] forKey:@"cw_longitude" ];

			[self gotoreturnjs: arraylogin JSFunction:@"loginSuccess"];
			
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
			[arraylogin setValue:self.app.Gmachid forKey:@"cw_machine_id" ];
			[arraylogin setValue:[NSString stringWithFormat:@"%f",self.app.diliweizhi.latitude] forKey:@"cw_latitude" ];
			[arraylogin setValue:[NSString stringWithFormat:@"%f",self.app.diliweizhi.longitude] forKey:@"cw_longitude" ];
			[self gotoreturnjs: arraylogin JSFunction:@"loginSuccess"];
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
			[arraylogin setValue:self.app.Gmachid forKey:@"cw_machine_id" ];
			[arraylogin setValue:[NSString stringWithFormat:@"%f",self.app.diliweizhi.latitude] forKey:@"cw_latitude" ];
			[arraylogin setValue:[NSString stringWithFormat:@"%f",self.app.diliweizhi.longitude] forKey:@"cw_longitude" ];
			[self gotoreturnjs: arraylogin JSFunction:@"loginSuccess"];
		}
	}];
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
	UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[dicfrom objectForKey:@"title"] descr:[dicfrom objectForKey:@"summary"] thumImage:thumbURL];
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
                
                [self getShareInfoCallBack:[dicfrom objectForKey:@"cw_id"] ShareType:sharetype ShareId:[dicfrom objectForKey:@"share_id"]];
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
-(void)getShareInfo:(NSString *)sender
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_id"] = sender;
	params[@"cw_type"] = @"news";
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:self.app ReqUrl:InterfaceShare ShowView:self.app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
            
			[self setUMshare];
			[self showshareinfo:[dic objectForKey:@"data"]];
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:self.app.window];
		}
	} Failur:^(NSString *strmsg) {
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];

	}];
}

-(void)getShareInfoCallBack:(NSString *)sender ShareType:(NSString *)sharetype ShareId:(NSString *)shareid
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cw_id"] = sender;
    params[@"cw_type"] = sharetype;
    params[@"share_id"] = shareid;
    
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
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)uploadpic:(NSArray *)sender
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:@"ccwb_app" forKey:@"project"];
	[params setObject:@"broke" forKey:@"module"];
	[params setObject:@"image" forKey:@"uploadType"];
	[RequestInterface doGetJsonWithArraypic:sender Parameter:params App:self.app ReqUrl:InterfaceBrokeUploadResource ShowView:self.app.window alwaysdo:^{
		
	}
									Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 NSDictionary *dicrevice = dic;
			 [self gotoreturnjs:dicrevice JSFunction:@"openAppImageCallback"];
			 [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:self.app.window];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:self.app.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.app.window];
	 }];
}

#pragma mark 控制屏幕旋转
// 进入全屏
-(void)begainFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
}
// 退出全屏
-(void)endFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    
    //强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val =UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}



#pragma mark - UMSocialShareMenuViewDelegate
- (void)UMSocialShareMenuViewDidAppear
{
	NSLog(@"UMSocialShareMenuViewDidAppear");
}
- (void)UMSocialShareMenuViewDidDisappear
{
	NSLog(@"UMSocialShareMenuViewDidDisappear");
}

//不需要改变父窗口则不需要重写此协议
- (UIView*)UMSocialParentView:(UIView*)defaultSuperView
{
	return defaultSuperView;
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
