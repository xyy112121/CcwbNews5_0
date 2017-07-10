//
//  WKWebViewDelegate.h
//  nanjids
//
//  Created by ZhangFan on 2017/2/16.
//  Copyright © 2017年 Ten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@protocol WKWebViewDelegate <NSObject>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface WKWebViewDelegate : UIViewController <WKScriptMessageHandler>

@property (weak , nonatomic) id<WKWebViewDelegate> delegate;

@end
