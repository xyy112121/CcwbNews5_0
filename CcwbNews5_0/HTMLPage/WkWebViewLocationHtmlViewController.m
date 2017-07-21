//
//  WkWebViewLocationHtmlViewController.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WkWebViewLocationHtmlViewController.h"

@interface WkWebViewLocationHtmlViewController ()<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>

@property (strong, nonatomic)   WKWebView                   *wkwebview;
@end


@implementation WkWebViewLocationHtmlViewController

@synthesize wkwebview;

-(void)returnback:(id)sender
{
    self.app.allowRotation = 0;

    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.app.allowRotation = 0;
    self.app.gnctl = self.navigationController;

    [self.navigationController setNavigationBarHidden:YES animated:YES];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
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
    
    flagloading = 0;
    reloadflag = 0;
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
}

- (void)initWKWebView
{
    userContentController = [[WKUserContentController alloc] init];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    
    
    
    [userContentController addScriptMessageHandler:self name:@"commonBack"];
    [userContentController addScriptMessageHandler:self name:@"getiostoke"];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    
    self.wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)
                                        configuration:configuration];
    
    
    
    NSString* urlpath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:urlpath];
    [self.wkwebview loadFileURL:url allowingReadAccessToURL:url];
    self.wkwebview.navigationDelegate = self;
    self.wkwebview.UIDelegate = self;
    [self.view addSubview:self.wkwebview];
    
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [userContentController removeScriptMessageHandlerForName:@"commonBack"];
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
    else if([message.name isEqualToString:@"getiostoke1"])
    {
        DLog(@"123123123123123123123123123123");
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
   CGFloat sizeHeight = webView.scrollView.contentSize.height;
    DLog(@"sizeheight====%f",sizeHeight);
    
    if(reloadflag == 0)
    {
        DLog(@"app.token====%@",self.app.cwtoken);
        NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] init];
        [dictemp setObject:self.app.cwtoken forKey:@"token"];
        [self gotoreturnjs:dictemp JSFunction:@"uploadiostoken"];
        [webView reload];
        reloadflag = 1;
    }
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
//    NSString *requestString = navigationResponse.response.URL.absoluteString;

    decisionHandler(WKNavigationResponsePolicyAllow);

}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    DLog(@"3453453");
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
//    NSString *requestString = navigationAction.request.URL.absoluteString;
    decisionHandler(WKNavigationActionPolicyAllow);
 
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

-(void)returnback
{
    [[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 接口
-(void)getNewsDetailInfo:(NSString *)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cw_id"] = @"20170629160614DGLWZL";
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:self.app ReqUrl:InterfaceNewsDetailContent ShowView:self.app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSDictionary *dictemp = [dic objectForKey:@"data"];
            NSDictionary *dicdata = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",@"123123"],@"info", [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"title"]],@"title",
                                     [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"add_time"]],@"add_time",
                                     [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"source"]],@"source",
                                     [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"click_num"]],@"click_num",nil];
            
       //     NSDictionary *dicjson = [NSDictionary dictionaryWithObjectsAndKeys:dicdata,@"data",[dic objectForKey:@"msg"],@"msg",[dic objectForKey:@"success"],@"success", nil];
            NSString *strjson = [AddInterface DataTOjsonString:dicdata];
            strjson = [strjson stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *js = [NSString stringWithFormat:@"createcharthtml('%@');",strjson];
//            [self.wkwebview evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//                //TODO
//                NSLog(@"responsec %@ %@",response,error);
//            }];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:self.app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
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
