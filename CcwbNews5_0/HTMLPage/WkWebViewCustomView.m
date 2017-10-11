//
//  WkWebViewCustomView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WkWebViewCustomView.h"

@implementation WkWebViewCustomView

-(id)initWithFrame:(CGRect)frame StrUrl:(NSString *)strurl
{
	self = [super initWithFrame:frame];
	if (self)
	{
		fromurl = strurl;
		self.backgroundColor = [UIColor clearColor];
		[self initWKWebView:strurl];
	}
	return self;
}

- (void)initWKWebView:(NSString *)strurl
{
	flagloading = 0;
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	userContentController = [[WKUserContentController alloc] init];
	WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
	configuration.userContentController = userContentController;
	configuration.allowsInlineMediaPlayback = YES;
	
	[userContentController addScriptMessageHandler:self name:@"addAppIOS"];
	[userContentController addScriptMessageHandler:self name:@"getAppUserInfo"];
	[userContentController addScriptMessageHandler:self name:@"openAppManage"];
	[userContentController addScriptMessageHandler:self name:@"openApp"];
    [userContentController addScriptMessageHandler:self name:@"commonBack"];
	
	
	WKPreferences *preferences = [WKPreferences new];
	preferences.javaScriptCanOpenWindowsAutomatically = YES;
	preferences.minimumFontSize = 40.0;
	configuration.preferences = preferences;
	
	self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)
											configuration:configuration];
    self.webView.backgroundColor = [UIColor clearColor];
	UIScrollView *scroller = [self.webView.subviews objectAtIndex:0];
	if ([scroller isKindOfClass:[UIScrollView class]]&&scroller)
	{
		scroller.bounces = NO;
		scroller.alwaysBounceVertical = NO;
		scroller.alwaysBounceHorizontal = NO;
	}
	
	
	__weak typeof(self) weakSelf = self;
	[self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
		__strong typeof(weakSelf) strongSelf = weakSelf;
		
		NSString *userAgent = result;
		if([result rangeOfString:@"ccwb_app/ios"].location ==NSNotFound)
		{
			NSString *newUserAgent = [userAgent stringByAppendingString:@";ccwb_app/ios"];
			
			NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
			[[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
		}
		strongSelf.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)
												configuration:configuration];
		NSURL *fileURL = [NSURL URLWithString:strurl];
		NSURLRequest *request  = [NSURLRequest requestWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
		[strongSelf.webView loadRequest:request];
		strongSelf.webView.navigationDelegate = self;
		strongSelf.webView.UIDelegate = self;
		[strongSelf addSubview:strongSelf.webView];
		
		UIScrollView *scroller = [strongSelf.webView.subviews objectAtIndex:0];
		if ([scroller isKindOfClass:[UIScrollView class]]&&scroller)
		{
			scroller.bounces = NO;
			scroller.alwaysBounceVertical = NO;
			scroller.alwaysBounceHorizontal = NO;
		}
        self.webView.backgroundColor = [UIColor clearColor];
		YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
		[self addSubview:imageViewgif];
		imageViewgif.tag = EnYLImageViewTag;
		imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
	}];
	self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
	
	
}

- (void)dealloc
{
	NSLog(@"%s",__FUNCTION__);
    
    [userContentController removeScriptMessageHandlerForName:@"commonBack"];
	[userContentController removeScriptMessageHandlerForName:@"addAppIOS"];
	[userContentController removeScriptMessageHandlerForName:@"getAppUserInfo"];
	[userContentController removeScriptMessageHandlerForName:@"openAppManage"];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
	//    message.body  --  Allowed types are NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull.
	NSLog(@"body:%@",message.body);
	if ([message.name isEqualToString:@"openAppManage"])  //打开应用管理
	{
		[self openAppMange:message.body];
	}
	else if([message.name isEqualToString:@"getAppUserInfo"])  //返回用户信息
	{
		NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] init];
		[dictemp setValue:@"true" forKey:@"success"];
		[dictemp setValue:@"获取信息成功" forKey:@"msg"];
		[dictemp setValue:app.Gmachid forKey:@"cw_machine_id"];
		[dictemp setValue:app.userinfo.userid forKey:@"cw_user_id"];
		NSString *js = [NSString stringWithFormat:@"getAppUserInfoIOS(%@)", [CustomPageObject DataTOjsonString:dictemp]];
		[self.webView evaluateJavaScript:js completionHandler:nil];
	}
	else if([message.name isEqualToString:@"addAppIOS"])  //添加应用
	{
		[self clickaddapplication:message.body];
	}
	else if([message.name isEqualToString:@"openApp"])  //打开应用
	{
		[self clickopenapplication:message.body];
	}
    else if([message.name isEqualToString:@"commonBack"])
    {
        [self removeFromSuperview];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
	DLog(@"123123");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
	
	DLog(@"111111");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
	[[self viewWithTag:EnYLImageViewTag] removeFromSuperview];
	DLog(@"55555");
}

// 页面加载成功时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
	[[self viewWithTag:EnYLImageViewTag] removeFromSuperview];
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
	decisionHandler(WKNavigationResponsePolicyAllow);
	//允许跳转
//	if(flagloading == 0)
//	{
//		flagloading = 1;
//		decisionHandler(WKNavigationResponsePolicyAllow);
//	}
//	else
//		decisionHandler(WKNavigationResponsePolicyCancel);
	
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
	DLog(@"3453453");
	NSLog(@"%@",navigationAction.request.URL.absoluteString);
	NSString *requestString = navigationAction.request.URL.absoluteString;
	
	
	NSArray *arrayurl1 = [requestString componentsSeparatedByString:@"html"];
	NSArray *arrayurl2 = [fromurl componentsSeparatedByString:@"html"];
	//允许跳转
	if([[arrayurl1 objectAtIndex:0] isEqualToString:[arrayurl2 objectAtIndex:0]])
	{
		decisionHandler(WKNavigationActionPolicyAllow);
	}
	else
	{
		decisionHandler(WKNavigationActionPolicyCancel);
		if([self.delegate1 respondsToSelector:@selector(DGClickwkwebviewCustomview:)])
		{
			[self.delegate1 DGClickwkwebviewCustomview:requestString];
		}
	}
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler();
	}])];
	completionHandler();
	if([self.delegate1 respondsToSelector:@selector(DGClickWkWebViewAlert:)])
	{
		[self.delegate1 DGClickWkWebViewAlert:alertController];
	}
	
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
	
	if([self.delegate1 respondsToSelector:@selector(DGClickWkWebViewAlert:)])
	{
		[self.delegate1 DGClickWkWebViewAlert:alertController];
	}
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
	[alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		textField.text = defaultText;
	}];
	[alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		completionHandler(alertController.textFields[0].text?:@"");
	}])];
	
	if([self.delegate1 respondsToSelector:@selector(DGClickWkWebViewAlert:)])
	{
		[self.delegate1 DGClickWkWebViewAlert:alertController];
	}
	
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
		[app.arrayaddapplication addObject:sender];
		[self.delegate1 DGclickAddAppMachine:sender];
	}
}

-(void)clickopenapplication:(NSString *)sender
{
	DLog(@"sender====%@",sender);
	
	if([self.delegate1 respondsToSelector:@selector(DGClickOpenApplication:)])
	{
		[self.delegate1 DGClickOpenApplication:sender];
	}
}


@end
