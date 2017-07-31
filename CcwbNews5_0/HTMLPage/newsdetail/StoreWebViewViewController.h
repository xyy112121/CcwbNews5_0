//
//  StoreWebViewViewController.h
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreWebViewViewController : UIViewController<UIWebViewDelegate,ActionDelegate>
{
    JQIndicatorView *indicator;
    AppDelegate *app;
    int reloadflag;
    UIWebView *webview;
}

@property (strong, nonatomic)JSContext *context;
@property(nonatomic,strong)NSString *strfromurl;

@end
