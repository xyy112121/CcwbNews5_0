//
//  WkWebViewCustomView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WkWebViewCustomView : UIView<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>
{
	int flagloading;
	NSString * fromurl;
	WKUserContentController * userContentController;
	NSString *strfromurl;
	AppDelegate *app;
	EnWebViewWindowsType webviewtype;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property (strong, nonatomic)WKWebView  *webView;
-(id)initWithFrame:(CGRect)frame StrUrl:(NSString *)strurl;
//-(void)loadData:(NSString *)strurl;
@end
