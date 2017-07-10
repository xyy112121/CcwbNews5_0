//
//  AskBrokeViewController.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/4/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "AskBrokeViewController.h"

@interface AskBrokeViewController ()

@end

@implementation AskBrokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	[self.navigationController setNavigationBarHidden:NO];
	[self.navigationController.navigationBar setBarTintColor:Colorredcolor];
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 5, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	[button setImage:LOADIMAGE(@"arrowleft", @"png") forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
	
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	[self settingScrollView];
	[self initview];

}

-(void)addbottombar
{
	MTInputToolbar *inputToolbar = [[MTInputToolbar alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-64 - 50 , SCREEN_WIDTH, 50)];
	inputToolbar.delegate = self;
	
	NSMutableArray *arr = [[NSMutableArray alloc] init];
	for (int i = 0; i<12; i ++ ) {
		NSDictionary *dict = @{@"image":@"img_defaulthead_nor",
							   @"label":[NSString stringWithFormat:@"%d",i],
							   };
		[arr addObject:dict];
	}
	inputToolbar.typeDatas = [arr copy];
	
	//文本输入框最大行数
	inputToolbar.textViewMaxLine = 4;
	[self.view addSubview:inputToolbar];
}

- (void)settingScrollView
{
	NSString *str = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",URLAskQuestViewHtml,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid!=nil?app.userinfo.userid:@""];
	str = [URLHTTPHeader stringByAppendingString:str];
	WkWebViewCustomView *askview = [[WkWebViewCustomView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) StrUrl:str];

	brokeview = [[BrokeTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	brokeview.deletage1 = self;

	
	
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
	
	scrollview.delegate = self;
	scrollview.bounces = NO;
	scrollview.pagingEnabled = YES;
	scrollview.directionalLockEnabled = YES;
	
	//[tableView addSubview:scrollView];
	scrollview.contentSize = CGSizeMake(2 *SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
	scrollview.showsHorizontalScrollIndicator = NO;
	
	[self.view addSubview:scrollview];
	[scrollview addSubview:askview];
	[scrollview addSubview:brokeview];
	
}

-(void)initview
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = COLORNOW(240, 240, 240);
	[self settingSegment];

}


-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	[self.navigationController.navigationBar setBarTintColor:COLORNOW(232, 56, 47)];
}

#pragma mark  ibaction
-(void)returnback
{
	[brokeview.player stop];
	brokeview.player = nil;
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark Segment

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	CGFloat offset = scrollView.contentOffset.x;
	
	self.segment.selectedSegmentIndex = offset/self.view.frame.size.width;
}

- (void)settingSegment{
	
	UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"问吧",@"爆料"]];
	
	self.navigationItem.titleView = segment;
	segment.frame = CGRectMake(0, 0, 140, 30);
//	segment.width = 120;
	segment.selectedSegmentIndex = 0;
	
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:14],NSFontAttributeName,nil];
	
	[segment setTitleTextAttributes:dic forState:UIControlStateNormal];
	
	segment.layer.cornerRadius = 15.0f;
	
	segment.layer.masksToBounds = YES;
	
	
	segment.tintColor = [UIColor whiteColor];
	segment.layer.borderWidth = 1.0f;
	segment.layer.borderColor = [UIColor whiteColor].CGColor;
	
	
	
	[segment addTarget:self action:@selector(segmentBtnClick) forControlEvents:UIControlEventValueChanged];
	_segment = segment;
	
	
}

- (void)segmentBtnClick{
	NSLog(@"改变值");
	scrollview.contentOffset = CGPointMake(self.segment.selectedSegmentIndex * SCREEN_WIDTH, 0);
}


#pragma mark 照相
- (void)DGClickselectcamera:(id)sender
{
	FYAlbumManager * manager =[FYAlbumManager shareAlbumManager];
	manager.maxSelect = 1;
	manager.delegate1 = self;
	manager.complate = ^(NSArray *array)
	{
		if([array count]>0)
		{
			DLog(@"array====%@",[array objectAtIndex:0]);
			UIImage *cameraimage = [[array objectAtIndex:0] objectForKey:@"result"];
			NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
			[arrayimage addObject:cameraimage];
			[self uploadpic:arrayimage];
		}
	};
	[manager showInView:self Photo:@"2"];  //照相
}

#pragma mark 录制 视频
-(void)DGGototakevideo:(id)sender
{
	DBTakeVideoVC *takeVideoVC=[[DBTakeVideoVC alloc]init];
	takeVideoVC.delegate1 = self;
	[self.navigationController pushViewController:takeVideoVC animated:YES];
}

-(void)DGSetvideopath:(NSString *)sender Thumbimg:(UIImage *)thumbimg
{
	NSString *strfilepath = sender;

	DLog(@"strfilepath====%@",strfilepath);

	[self uploadvideo:strfilepath];

}

#pragma mark 图片选择
- (void)DGClickselectphoto:(id)sender{
	FYAlbumManager * manager =[FYAlbumManager shareAlbumManager];
	manager.maxSelect = 1;
	manager.delegate1 = self;
	manager.complate = ^(NSArray *array)
	{
		
		if([array count]>0)
		{
			DLog(@"array====%@",[array objectAtIndex:0]);
			UIImage *selectimage = [[array objectAtIndex:0] objectForKey:@"result"];
			NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
			[arrayimage addObject:selectimage];
			[self uploadpic:arrayimage];
		}
	};
	[manager showInView:self Photo:@"1"];  //相册
}

#pragma mark 视频播放
-(void)DGPlayVideo:(NSString*)videopath
{
	NSURL * videoURL = [NSURL URLWithString:videopath];
	AVPlayerViewController *avPlayer = [[AVPlayerViewController alloc] init];
	avPlayer.player = [[AVPlayer alloc] initWithURL:videoURL];
	/*
	 可以设置的值及意义如下：
	 AVLayerVideoGravityResizeAspect   不进行比例缩放 以宽高中长的一边充满为基准
	 AVLayerVideoGravityResizeAspectFill 不进行比例缩放 以宽高中短的一边充满为基准
	 AVLayerVideoGravityResize     进行缩放充满屏幕
	 */
	avPlayer.videoGravity = AVLayerVideoGravityResizeAspect;
	
	[self presentViewController:avPlayer animated:YES completion:nil];
	
//	self.moviePlayerViewController=nil;
//	NSURL *url=[self getNetworkUrl:videopath];
//	self.moviePlayerViewController=[[MPMoviePlayerViewController alloc] initWithContentURL:url];
//	[self addNotification];
//	
//	//    [self presentViewController:self.moviePlayerViewController animated:YES completion:nil];
//	//注意，在MPMoviePlayerViewController.h中对UIViewController扩展两个用于模态展示和关闭MPMoviePlayerViewController的方法，增加了一种下拉展示动画效果
//	[self presentMoviePlayerViewControllerAnimated:self.moviePlayerViewController];
}

-(void)dealloc{
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSURL *)getNetworkUrl:(NSString *)strurl{
	NSString *urlStr=strurl;
	urlStr=[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//			stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url=[NSURL URLWithString:urlStr];
	return url;
}



-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{

}

-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
	//	NSLog(@"播放完成.%li",self.moviePlayerViewController.moviePlayer.playbackState);
}


#pragma mark actiondelegate
-(void)DGUpLoadBrokeContentItem:(NSString *)fromtype FileURL:(NSString *)fileurl FileId:(NSString *)fileid Content:(NSString *)content TimeLength:(NSString *)timelength
{
	[self uploadresourceitem:content Type:fromtype FileURL:fileurl FileId:fileid TimeLength:timelength VideoPicPath:@""];
}


#pragma mark 接口
-(void)uploadresourceitem:(NSString *)content Type:(NSString *)type FileURL:(NSString *)fileurl FileId:(NSString *)fileid TimeLength:(NSString *)timelength VideoPicPath:(NSString *)videopicpath
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:type forKey:@"cw_type"];
	[params setObject:[content length]==0?@"无内容":content forKey:@"cw_content"];
	[params setObject:fileurl forKey:@"cw_file_url"];
	[params setObject:fileid forKey:@"cw_file_id"];
	[params setObject:timelength forKey:@"cw_timelength"];
	[params setObject:videopicpath forKey:@"cw_video_picpath"];
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceUploadBrokeInfo ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [brokeview getbrokelist:@"1" PageSize:@"10" FreshDirect:@"foot"];
			 
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
	 }];
}

-(void)uploadpic:(NSArray *)sender
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:@"ccwb_app" forKey:@"project"];
	[params setObject:@"broke" forKey:@"module"];
	
	[RequestInterface doGetJsonWithArraypic:sender Parameter:params App:app ReqUrl:InterfaceBrokeUploadImage ShowView:app.window alwaysdo:^{
		
	}
									Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 NSDictionary *dicrevice = [dic objectForKey:@"data"];
			 [self uploadresourceitem:@"" Type:@"2" FileURL:[dicrevice objectForKey:@"path"] FileId:[dicrevice objectForKey:@"id"] TimeLength:@"0" VideoPicPath:[dicrevice objectForKey:@"path"]];
			 [brokeview sendMessage:[NSString stringWithFormat:@"img[%@]",[dicrevice objectForKey:@"path"]]];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
	 }];
}


-(void)uploadvideo:(NSString *)sender
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:@"ccwb_app" forKey:@"project"];
	[params setObject:@"broke" forKey:@"module"];


	[RequestInterface doGetJsonWithvideo:sender Parameter:params App:app ReqUrl:InterfaceBrokeUploadVideo ShowView:app.window alwaysdo:^{

	}
	Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 NSDictionary *dicrevice = [dic objectForKey:@"data"];
			 [self uploadresourceitem:@"" Type:@"3" FileURL:[dicrevice objectForKey:@"path"] FileId:[dicrevice objectForKey:@"id"] TimeLength:@"0" VideoPicPath:[dicrevice objectForKey:@"pic_path"]];
			 [brokeview sendMessage:[NSString stringWithFormat:@"video[%@]",[dicrevice objectForKey:@"path"]]];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }
	 Failur:^(NSString *strmsg)
	 {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
	 }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
