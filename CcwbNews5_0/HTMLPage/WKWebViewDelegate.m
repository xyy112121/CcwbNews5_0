//
//  WKWebViewDelegate.m
//  nanjids
//
//  Created by ZhangFan on 2017/2/16.
//  Copyright © 2017年 Ten. All rights reserved.
//

#import "WKWebViewDelegate.h"
@interface WKWebViewDelegate ()

@end

@implementation WKWebViewDelegate

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}


@end

