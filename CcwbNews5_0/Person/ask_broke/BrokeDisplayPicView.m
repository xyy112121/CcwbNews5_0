//
//  BrokeDisplayPicView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/4/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "BrokeDisplayPicView.h"

@implementation BrokeDisplayPicView

-(id)initWithFrame:(CGRect)frame PicPath:(NSString *)picpath  FromImage:(UIImage *)fromimage
{
	self = [super initWithFrame:frame];
	if (self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor blackColor];
		
		self.tag = EnBrokePicDisplayView;
		[self initview:picpath FromImage:fromimage];
		
	}
	return self;
}

-(void)initview:(NSString *)downpath FromImage:(UIImage *)fromimage
{
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	[self addSubview:scrollview];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	button.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	[button addTarget:self action:@selector(removepicview) forControlEvents:UIControlEventTouchUpInside];
	[scrollview addSubview:button];
	
	float nowheight = fromimage.size.height*self.frame.size.width/fromimage.size.width;
	self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-nowheight)/2, self.frame.size.width, nowheight)];
	[scrollview addSubview:self.imageView];

	float imaheight = fromimage.size.height*SCREEN_WIDTH/fromimage.size.width;
	self.imageView.image = fromimage;
	[UIView transitionWithView:self.imageView duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		if(imaheight>SCREEN_HEIGHT)
		{
			self.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imaheight);
		}
		else
		{
			self.imageView.frame = CGRectMake(0, (SCREEN_HEIGHT-imaheight)/2, SCREEN_WIDTH, imaheight);
		}
	} completion:^(BOOL finished) {
		//finished判断动画是否完成
		if (finished) {
			
		}
	}];
	scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, imaheight);
	//	[self downloadinit:downpath];
}

-(void)removepicview
{
	[[app.window viewWithTag:EnBrokePicDisplayView] removeFromSuperview];
}

#pragma mark 文件下载
-(void)downloadinit:(NSString *)downpath
{
	//网络监控句柄
	AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
	
	//要监控网络连接状态，必须要先调用单例的startMonitoring方法
	[manager startMonitoring];
	
	[manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		//status:
		//AFNetworkReachabilityStatusUnknown          = -1,  未知
		//AFNetworkReachabilityStatusNotReachable     = 0,   未连接
		//AFNetworkReachabilityStatusReachableViaWWAN = 1,   3G
		//AFNetworkReachabilityStatusReachableViaWiFi = 2,   无线连接
		NSLog(@"%ld", (long)status);
	}];
	
	//准备从远程下载文件. -> 请点击下面开始按钮启动下载任务
	[self downFileFromServer:downpath];
}


- (void)downFileFromServer:(NSString *)downpath
{
	
	//远程地址
	NSURL *URL = [NSURL URLWithString:downpath];
	//默认配置
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	
	//AFN3.0+基于封住URLSession的句柄
	AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
	
	//请求
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	
	//下载Task操作
	_downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
		
		// @property int64_t totalUnitCount;     需要下载文件的总大小
		// @property int64_t completedUnitCount; 当前已经下载的大小
		
		// 给Progress添加监听 KVO
		NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
		// 回到主队列刷新UI
		dispatch_async(dispatch_get_main_queue(), ^{
			// 设置进度条的百分比
			
			self.progressView.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
		});
		
	} destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
		
		//- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
		NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
		NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
		DLog(@"path===%@",path);
		return [NSURL fileURLWithPath:path];
		
	} completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
		//设置下载完成操作
		// filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
		
		NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
		[self compositionpicture:imgFilePath];
		
	}];
	
	[_downloadTask resume];
}

-(void)compositionpicture:(NSString *)imgFilePath
{
	UIImage *img = [UIImage imageWithContentsOfFile:imgFilePath];
	float imaheight = img.size.height*SCREEN_WIDTH/img.size.width;
	self.imageView.image = img;
	
	[UIView transitionWithView:self.imageView duration:3.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		if(imaheight>SCREEN_HEIGHT)
		{
			self.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imaheight);
		}
		else
		{
			self.imageView.frame = CGRectMake(0, (SCREEN_HEIGHT-imaheight)/2, SCREEN_WIDTH, imaheight);
		}
	} completion:^(BOOL finished) {
		//finished判断动画是否完成
		if (finished) {
			
		}
	}];
	
	
	
	scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, imaheight);
}


@end
