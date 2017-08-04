//
//  WebViewCustomViewController.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/27.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WebViewCustomViewController.h"

@interface WebViewCustomViewController ()<WKUIDelegate,WKScriptMessageHandler>

@end

@implementation WebViewCustomViewController

-(void)returnback
{
	[[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	UIWebView *webview = (UIWebView *)[self.view viewWithTag:EnWebViewCustomTag];
	if (webview.canGoBack)
	{
		[webview goBack];
	}
	else
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
		self.automaticallyAdjustsScrollViewInsets = NO;
	}
	
	[self initparament:nil];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
	flagloading = 0;
	[self.navigationController setNavigationBarHidden:YES];
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


-(void)initparament:(id)sender
{
	self.app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[self initview:nil];
	
	
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
		userContentController = [[WKUserContentController alloc] init];
		[userContentController addScriptMessageHandler:self name:@"commonBack"];
		
		// WKWebView的配置
		WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
		configuration.userContentController = userContentController;
		
//		WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//		configuration.userContentController = [WKUserContentController new];
//		
//		[configuration.userContentController addScriptMessageHandler:self name:@"commonBack"];
//		[configuration.userContentController addScriptMessageHandler:self name:@"getUserInfo"];

		
		WKPreferences *preferences = [WKPreferences new];
		preferences.javaScriptCanOpenWindowsAutomatically = YES;
		preferences.minimumFontSize = 40.0;
		configuration.preferences = preferences;
		
		wkwebview = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
		NSString *urlStr = self.strurl;
		NSURL *fileURL = [NSURL URLWithString:urlStr];
		[wkwebview loadRequest:[NSURLRequest requestWithURL:fileURL]];
		wkwebview.UIDelegate = self;
		wkwebview.navigationDelegate = self;
		[self.view addSubview:wkwebview];
		
		YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
		[self.view addSubview:imageViewgif];
		imageViewgif.tag = EnYLImageViewTag;
		imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
	});
}

-(void)removeimagegif
{
	[[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
	//    message.body  --  Allowed types are NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull.
	NSLog(@"body:%@",message.body);
	if ([message.name isEqualToString:@"commonBack"])
	{
		[self returnback];
	}
	else if ([message.name isEqualToString:@"getUserInfo"])
	{
		[self getUserInfo:message.body];
	}
	NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
}


// oc调用JS方法   页面加载完成之后调用
- (void)webView:(WKWebView *)tmpWebView didFinishNavigation:(WKNavigation *)navigation{
	
	
	[self removeimagegif];
	//say()是JS方法名，completionHandler是异步回调block
//	[wkwebview evaluateJavaScript:@"h5()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//		NSLog(@"%@",result);
//	}];
//	
//	if (wkwebview.title.length > 0) {
//		self.title = wkwebview.title;
//	}
	
}
//#pragma mark - WKNavigationDelegate
//// 页面开始加载时调用
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
//{
//	DLog(@"123123");
//}
//// 当内容开始返回时调用
//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
//{
//	
//}
//// 页面加载失败时调用
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
//{
//	
//}
//// 接收到服务器跳转请求之后调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
//{
//	
//}
//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
//{
//	
//	NSLog(@"%@",navigationResponse.response.URL.absoluteString);
//	//允许跳转
//	decisionHandler(WKNavigationResponsePolicyAllow);
//	//不允许跳转
//	//    decisionHandler(WKNavigationResponsePolicyCancel);
//}
//// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
//{
//	DLog(@"3453453");
//	NSLog(@"%@",navigationAction.request.URL.absoluteString);
//	//允许跳转
//	decisionHandler(WKNavigationActionPolicyAllow);
//	//不允许跳转
//	//    decisionHandler(WKNavigationActionPolicyCancel);
//}
//#pragma mark - WKUIDelegate
//// 创建一个新的WebView
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
//	// 接口的作用是打开新窗口委托
//	
//	DLog(@"6786787");
//	return [[WKWebView alloc]init]; //OBJC_SWIFT_UNAVAILABLE("use object initializers instead")
//	
//	//    [self createNewWebViewWithURL:webView.URL.absoluteString config:configuration];
//	//
//	//    return currentSubView.webView;
//}
//// 输入框
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
//	completionHandler(@"http");
//}
//// 确认框
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
//	completionHandler(YES);
//}
//// 警告框
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//	NSLog(@"%@",message);
//	completionHandler();
//}
//#pragma mark - WebViewJavascriptBridgeBaseDelegate
////代理方法
//- (NSString*) _evaluateJavascript:(NSString*)javascriptCommand{
//	return nil;
//}



-(void)getUserInfo:(NSDictionary *)tempDic
{
	if (![tempDic isKindOfClass:[NSDictionary class]]) {
		return;
	}
	
	DLog(@"tempDic====%@",tempDic);
	
}


- (void)dealloc{
	//这里需要注意，前面增加过的方法一定要remove掉。
	[userContentController removeScriptMessageHandlerForName:@"commonBack"];
	[userContentController removeScriptMessageHandlerForName:@"getUserInfo"];
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
