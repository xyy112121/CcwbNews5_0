//
//  WkWebviewTestViewController.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WkWebviewTestViewController.h"

@interface WkWebviewTestViewController ()<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>

@property (strong, nonatomic)   WKWebView                   *wkwebview;

@end

@implementation WkWebviewTestViewController

-(void)returnback:(id)sender
{
    [[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag] removeFromSuperview];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    contentView.backgroundColor = [UIColor clearColor];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:LOADIMAGE(@"arrowleftred", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -10;//这个值可以根据自己需要自己调整
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, barButtonItem];
    
    [self initWKWebView];
    // Do any additional setup after loading the view.
}

- (void)initWKWebView
{
    userContentController = [[WKUserContentController alloc] init];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    
    
    
//    [userContentController addScriptMessageHandler:self name:@"commonBack"];
//    [userContentController addScriptMessageHandler:self name:@"getiostoke"];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = NO;
    //   preferences.minimumFontSize = 10.0;
    configuration.preferences = preferences;
    
    self.wkwebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)
                                        configuration:configuration];
    
    
    
//    NSString* urlpath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:urlpath];
//    [self.wkwebview loadFileURL:url allowingReadAccessToURL:url];
    NSURL *url = [NSURL URLWithString:@"http://www.163.com"];
    self.wkwebview.navigationDelegate = self;
    self.wkwebview.UIDelegate = self;
    [self.wkwebview loadRequest:[NSURLRequest requestWithURL:url]];
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
    
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
//    [self.wkwebview reload];
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

-(void)returnback
{
    [[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
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
