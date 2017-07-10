//
//  PopAdView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/5/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "PopAdView.h"

@implementation PopAdView

-(id)initWithFrame:(CGRect)frame Requeststr:(NSString *)requeststring
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		fromurl = requeststring;
		flagloading = 0;
		[self initWKWebView:requeststring];
	}
	return self;
}

- (void)initWKWebView:(NSString *)strurl
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	userContentController = [[WKUserContentController alloc] init];
	WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
	configuration.userContentController = userContentController;
	configuration.allowsInlineMediaPlayback = YES;
	
	[userContentController addScriptMessageHandler:self name:@"commonBack"];
	
	WKPreferences *preferences = [WKPreferences new];
	preferences.javaScriptCanOpenWindowsAutomatically = YES;
	preferences.minimumFontSize = 40.0;
	configuration.preferences = preferences;
	
	self.webView = [[WKWebView alloc] initWithFrame:self.frame configuration:configuration];
	self.webView.navigationDelegate = self;
	self.webView.backgroundColor = [UIColor clearColor];
	self.webView.opaque = NO;
	self.webView.UIDelegate = self;
	[self addSubview:self.webView];
	NSURL *fileURL = [NSURL URLWithString:strurl];
	NSURLRequest *request  = [NSURLRequest requestWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
	[self.webView loadRequest:request];
	
	UIScrollView *scroller = [self.webView.subviews objectAtIndex:0];
	if ([scroller isKindOfClass:[UIScrollView class]]&&scroller)
	{
		scroller.bounces = NO;
		scroller.alwaysBounceVertical = NO;
		scroller.alwaysBounceHorizontal = NO;
	}
	
}

- (void)dealloc
{
	NSLog(@"%s",__FUNCTION__);
	[userContentController removeScriptMessageHandlerForName:@"commonBack"];

}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
	
	NSLog(@"body:%@",message.body);
	if ([message.name isEqualToString:@"commonBack"])  //打开应用管理
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
	//允许跳转
	if(flagloading == 0)
	{
		flagloading = 1;
		decisionHandler(WKNavigationResponsePolicyAllow);
	}
	else
		decisionHandler(WKNavigationResponsePolicyCancel);
	
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
	
	NSLog(@"%@",navigationAction.request.URL.absoluteString);
	NSString *requestString = navigationAction.request.URL.absoluteString;
	DLog(@"requestStringpopview==%@",requestString);
	
	NSArray *arraystr = [requestString componentsSeparatedByString:@"html"];
	NSArray *arrayurl = [fromurl componentsSeparatedByString:@"html"];
	if([[arraystr objectAtIndex:0] isEqualToString:[arrayurl objectAtIndex:0]])
	{
		//不允许跳转
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
		decisionHandler(WKNavigationActionPolicyCancel);
		if([requestString length]>0)
		{
			if([self.delegate1 respondsToSelector:@selector(DGGotoPopAdView:)])
			{
				[self.delegate1 DGGotoPopAdView:requestString];
			}
		}
	}
}




@end
