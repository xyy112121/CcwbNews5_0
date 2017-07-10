//
//  WebViewCustomViewController.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/27.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface WebViewCustomViewController : UIViewController<WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate,ActionDelegate,WKScriptMessageHandler>
{
	int flagloading;  //加载loading...   每个页面只能加载一次
	WKWebView *wkwebview;
	WKUserContentController * userContentController;
}
@property(nonatomic,strong)AppDelegate *app;
@property(nonatomic,strong)NSString *strurl;
@property (strong, nonatomic)JSContext *context;


@end
