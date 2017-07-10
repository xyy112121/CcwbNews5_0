//
//  PopAdView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/5/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopAdView : UIView<ActionDelegate,WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>
{
	int flagloading;
	AppDelegate *app;
	WKUserContentController * userContentController;
	NSString *fromurl;
}

@property(nonatomic,strong)id<ActionDelegate> delegate1;
@property (strong, nonatomic)WKWebView  *webView;
-(id)initWithFrame:(CGRect)frame Requeststr:(NSString *)requeststring;
@end
