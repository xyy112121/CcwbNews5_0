//
//  StoreWebViewViewController.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "StoreWebViewViewController.h"

@interface StoreWebViewViewController ()

@end

@implementation StoreWebViewViewController
-(void)returnback:(id)sender
{
    [[self.view viewWithTag:1800] removeFromSuperview];
    UIWebView *webview = (UIWebView *)[self.view viewWithTag:8090];
    
    if (webview.canGoBack)
    {
        [webview goBack];
    }
    else
    {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [webview loadRequest:nil];
    [webview removeFromSuperview];
    webview = nil;
    webview.delegate = nil;
    [webview stopLoading];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.navigationController setNavigationBarHidden:NO];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    [button setImage:LOADIMAGE(@"arrowleftred", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;

    self.view.backgroundColor = [UIColor whiteColor];
    [self initparament:nil];
    // Do any additional setup after loading the view.
}

#pragma mark 滑动事件
- (void)handleSwipeFrom:( UISwipeGestureRecognizer *)sender
{
    DLog(@"UISwipeGestureRecognizerDirectionRight");
    
    if ((sender. direction == UISwipeGestureRecognizerDirectionRight))
    {
        [self returnback:nil];
    }
    else if((sender. direction == UISwipeGestureRecognizerDirectionLeft))
    {
        
    }
}


-(void)initparament:(id)sender
{
    [self initview:nil];
    reloadflag = 0;
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
        
        NSString* urlpath = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:@""];
        if([self.strfromurl length]>0)
            urlpath = [urlpath stringByAppendingString:self.strfromurl];//@"#/order"];
        webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
        webview.backgroundColor = [UIColor clearColor];
        webview.delegate = self;
        webview.tag = 8090;
        NSURL *urlstr = [NSURL URLWithString:urlpath];
        NSURLRequest *request = [NSURLRequest requestWithURL:urlstr];
        [webview loadRequest:request];
        webview.scalesPageToFit = YES;
        [self.view addSubview:webview];
        
        
        for (UIView *_aView in [webview subviews])
        {
            if ([_aView isKindOfClass:[UIScrollView class]])
            {
                [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO]; //右侧的滚动条
                
                for (UIView *_inScrollview in _aView.subviews)
                {
                    if ([_inScrollview isKindOfClass:[UIImageView class]])
                    {
                        _inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
                    }
                }
            }
        }
        YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-150, 200, 200)];
        [self.view addSubview:imageViewgif];
        imageViewgif.tag = 1800;
        imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];

    });
    
    
    
}

-(void)removeimagegif:(id)sender
{
    [[self.view viewWithTag:1800] removeFromSuperview];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[self.view viewWithTag:1800] removeFromSuperview];

    if(reloadflag == 0)
    {
        reloadflag = 1;
        NSString *jsMethod = [NSString stringWithFormat:@"uploadiostoken('%@')", app.cwtoken];
        [webView stringByEvaluatingJavaScriptFromString:jsMethod];
        [webView reload];
    }
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __block typeof(self) weakSelf = self;
    self.context[@"commonBack"] =
    ^(NSString *viewname)
    {
        [weakSelf returnback:nil];
 
    };
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];//6602850289
    DLog(@"requestString====%@",requestString);
    
    return YES;
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
