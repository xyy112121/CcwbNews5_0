//
//  BrokeTableView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/4/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "BrokeTableView.h"

@implementation BrokeTableView

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = COLORNOW(240, 240, 240);
		jmloginstatus = ENJMNotLogin;
		[JMessage addDelegate:self withConversation:nil];
		
		
		if([app.userinfo.userid length]>0)
			[self jmregiestuser:app.userinfo.userid Pwd:@"123456"];
		else
			[self jmregiestuser:app.Gmachid Pwd:@"123456"];
		
		[self initview];
		[self getbrokelist:@"1" PageSize:@"10" FreshDirect:@"foot"];
		[self addbottombar];
	}
	return self;
}

-(void)addbottombar
{
	inputtoolbar = [[MTInputToolbar alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT-64 - 50 , SCREEN_WIDTH, 50)];
	inputtoolbar.delegate = self;
	
	NSMutableArray *arr = [[NSMutableArray alloc] init];
	for (int i = 0; i<4; i ++ )
	{
		NSDictionary *dict;
		if(i==0)
		{
			dict = @{@"image":@"爆料图片icon.png",
								   @"label":@"图片",};
		}
		else if(i==1)
		{
			dict = @{@"image":@"爆料拍照icon.png",
								   @"label":@"拍照",};
		}
		else if(i==2)
		{
			dict = @{@"image":@"爆料视频icon.png",
								   @"label":@"视频",};
		}
		else if(i==3)
		{
			dict = @{@"image":@"爆料视频icon.png",
					 @"label":@"视频",};
		}
		
		[arr addObject:dict];
	}
	inputtoolbar.typeDatas = [arr copy];
	
	//文本输入框最大行数
	inputtoolbar.textViewMaxLine = 4;
	[self addSubview:inputtoolbar];
}

-(void)initview
{
	arraydata = [[NSMutableArray alloc] init];
	arrayheight = [[NSMutableArray alloc] init];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height-50) style:UITableViewStylePlain];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self setExtraCellLineHidden:tableview];
	[self addSubview:tableview];
	
    
	
	
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 极光IM
//用户注册
-(void)jmregiestuser:(NSString *)username Pwd:(NSString *)password
{
	[JMSGUser registerWithUsername:username
						  password:password
				 completionHandler:^(id resultObject, NSError *error) {
					 if (error == nil) {
						 DLog(@"resultobjectregiest====%@",resultObject);
						 //SDK：用户登录方法（用户注册成功后自动登录）
						 [self jmloginuser:username Pwd:password];
					 }
					 else
					 {
						  DLog(@"resultobjectregiest====%ld",(long)error.code);
						 if((long)error.code == 898001)
						 {
							 [self jmloginuser:username Pwd:password];
						 }
						 else
						 {
							 [MBProgressHUD showError:@"爆料信息获取失败" toView:app.window];
						 }
						 
					 }
				 }];

}

//用户登录
-(void)jmloginuser:(NSString *)username Pwd:(NSString *)password
{
	[JMSGUser loginWithUsername:username
					   password:password
			  completionHandler:^(id resultObject, NSError *error) {
				  if (error == nil)
				  {
					  DLog(@"resultobject====%@",resultObject);
					  jmloginstatus = ENJMNotLogin;
				  }
				  else
				  {
					  NSLog(@"login fail error  %@",error);
					  [MBProgressHUD showError:@"爆料信息获取失败" toView:app.window];
				  }
			  }];
}

//发送信息
- (void)sendMessage:(NSString *)sender
{
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
	[dic setObject:sender forKey:@"content"];
	JMSGCustomContent *content = [[JMSGCustomContent alloc] initWithCustomDictionary:dic];
	JMSGMessage *message = [JMSGMessage createSingleMessageWithContent:content username:JMAdmin];
	[JMSGMessage sendMessage:message];
}

//发送消息回调
- (void)onSendMessageResponse:(JMSGMessage *)message
						error:(NSError *)error
{
	NSLog(@"Event - sendMessageResponse");
	if(error==nil)
	{
		JMSGCustomContent *textContent = (JMSGCustomContent *)message.content;
		NSDictionary *msgdic = textContent.customDictionary;
		DLog(@"message===%@",[msgdic objectForKey:@"content"]);
        [self resignfirsttextview];
	}
	else
	{
		
	}
}

//接收消息回调
- (void)onReceiveMessage:(JMSGMessage *)message error:(NSError *)error
{
	NSLog(@"Event - onReceiveMessage");
	if(error==nil)
	{
		JMSGCustomContent *textContent = (JMSGCustomContent *)message.content;
		NSDictionary *msgdic = textContent.customDictionary;
		DLog(@"message===%@",[msgdic objectForKey:@"content"]);
		[self getbrokelist:@"1" PageSize:@"10" FreshDirect:@"foot"];
	}
	else
	{
		
	}
//	[JMSGTools showResponseResultWithInfo:[NSString stringWithFormat:@"receive message: %@",  message] error:error];
}

- (void)onReceiveMessageDownloadFailed:(JMSGMessage *)message {
	NSLog(@"onReceiveMessageDownloadFailed: %@", message);
}

#pragma mark 上拉下拉加载
-(void)loadNewData
{
	[self getbrokelist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[arraydata count]+10] FreshDirect:@"header"];
	DLog(@"test");
}


#pragma MTInputToolbarDelegate

- (void)inputToolbar:(MTInputToolbar *)inputToolbar sendContent:(NSAttributedString *)sendContent
{
	NSLog(@"%@",sendContent);
	
	[self sendMessage:sendContent.string];
	if([self.deletage1 respondsToSelector:@selector(DGUpLoadBrokeContentItem:FileURL:FileId:Content:TimeLength:)])
	{
		[self.deletage1 DGUpLoadBrokeContentItem:@"1" FileURL:@"" FileId:@"" Content:sendContent.string TimeLength:@"0"];
	}
}

- (void)inputToolbar:(MTInputToolbar *)inputToolbar sendRecordData:(NSString *)Data
{
	NSLog(@"%@",Data);
	[self uploadaudio:Data];
	
}

- (void)inputToolbar:(MTInputToolbar *)inputToolbar indexPath:(NSIndexPath *)indexPath
{
	NSLog(@"%@",indexPath);
	if(indexPath.row == 0)
	{
		DLog(@"选择的图片");
		if([self.deletage1 respondsToSelector:@selector(DGClickselectphoto:)])
		{
			[self.deletage1 DGClickselectphoto:nil];
		}
	}
	else if(indexPath.row == 1)
	{
		if([self.deletage1 respondsToSelector:@selector(DGClickselectcamera:)])
		{
			[self.deletage1 DGClickselectcamera:nil];
		}
		DLog(@"选择的照相");
	}
	else if(indexPath.row == 2)
	{
		DLog(@"选择的视频");
		if([self.deletage1 respondsToSelector:@selector(DGGototakevideo:)])
		{
			[self.deletage1 DGGototakevideo:nil];
		}
	}
	
}


-(void)resignfirsttextview
{
	[inputtoolbar.textInput resignFirstResponder];
	[inputtoolbar setFrame:CGRectMake(0, SCREEN_HEIGHT-inputtoolbar.frame.size.height-64, inputtoolbar.frame.size.width, inputtoolbar.frame.size.height)];
}

#pragma mark 键盘高度
- (void)keyboardWillChangeFrame:(NSNotification *)notification

{
	
	NSDictionary *info = [notification userInfo];
	
	CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
	
	CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
	
	CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	
	CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
	
//	CGRect inputFieldRect = self.inputTextField.frame;
	
//	CGRect moreBtnRect = self.moreInputTypeBtn.frame;
	
//	inputFieldRect.origin.y += yOffset;
	
//	moreBtnRect.origin.y += yOffset;

	DLog(@"yOffset====%f",yOffset);
		removekeyboardbutton = [UIButton buttonWithType:UIButtonTypeCustom];
		removekeyboardbutton.frame= CGRectMake(0, 0, SCREEN_WIDTH, yOffset);
		removekeyboardbutton.backgroundColor = [UIColor redColor];
		[self addSubview:removekeyboardbutton];
	
	[UIView animateWithDuration:duration animations:^{
		
		tableview.frame=CGRectMake(0, yOffset, SCREEN_WIDTH, tableview.frame.size.height);
		[self scrollToBottom];
//		self.inputTextField.frame = inputFieldRect;
		
//		self.moreInputTypeBtn.frame = moreBtnRect;
		
	}];
	
}

- (void)keyboardWillHide:(NSNotification *)notification {
	
	// 获取通知信息字典
	NSDictionary* userInfo = [notification userInfo];
	
	// 获取键盘隐藏动画时间
	NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
	NSTimeInterval animationDuration;
	[animationDurationValue getValue:&animationDuration];
	
	// do something...
	
	tableview.frame=CGRectMake(0, 0, SCREEN_WIDTH, tableview.frame.size.height);
	[removekeyboardbutton removeFromSuperview];
}

#pragma mark tableview 代理
- (void)scrollToBottom
{
	CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
	if (tableview.contentSize.height > tableview.bounds.size.height) {
		yOffset = tableview.contentSize.height - tableview.bounds.size.height;
	}
	[tableview setContentOffset:CGPointMake(0, yOffset) animated:NO];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
	UIView *view = [UIView new];
	view.backgroundColor = [UIColor clearColor];
	[tableView setTableFooterView:view];
}

-(void)viewDidLayoutSubviews
{
	if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
		[tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
	}
	
	if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
		[tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
	}
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return [[arrayheight objectAtIndex:indexPath.row] floatValue];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	
	return [arrayheight count];
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor clearColor];
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	if([[dictemp objectForKey:@"type"] isEqualToString:@"1"])  //表示文字
	{
		BrokeWordView *brokeword = [[BrokeWordView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [[arrayheight objectAtIndex:indexPath.row] floatValue]) FromUser:[dictemp objectForKey:@"send_type"] WordStr:[dictemp objectForKey:@"content"]];
		[cell.contentView addSubview:brokeword];
	}
	else if([[dictemp objectForKey:@"type"] isEqualToString:@"2"])  //表示图片
	{
		BrokePicView *brokepic = [[BrokePicView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [[arrayheight objectAtIndex:indexPath.row] floatValue]) FromUser:[dictemp objectForKey:@"send_type"] PicPath:[dictemp objectForKey:@"file_url"]];
		brokepic.delegate1 = self;
		[cell.contentView addSubview:brokepic];
		
	}
	else if([[dictemp objectForKey:@"type"] isEqualToString:@"4"])  //表示语音
	{
		BrokeAudioView *brokeaudio = [[BrokeAudioView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [[arrayheight objectAtIndex:indexPath.row] floatValue]) FromUser:[dictemp objectForKey:@"send_type"] AudioPath:[dictemp objectForKey:@"file_url"] TimeLength:[NSString stringWithFormat:@"%@",[dictemp objectForKey:@"timelength"]]];
		brokeaudio.delegate1 = self;
		[cell.contentView addSubview:brokeaudio];
	}
	else if([[dictemp objectForKey:@"type"] isEqualToString:@"3"])  //表示视频
	{
		BrokeVideoView *brokevideo = [[BrokeVideoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [[arrayheight objectAtIndex:indexPath.row] floatValue]) FromUser:[dictemp objectForKey:@"send_type"] PicPath:[dictemp objectForKey:@"video_picpath"] VideoPaht:[dictemp objectForKey:@"file_url"]];
		brokevideo.delegate1 = self.deletage1;
		[cell.contentView addSubview:brokevideo];
	}
	else
	{
		cell.textLabel.text = @"123";
	}
	return cell;
	
}

#pragma mark actiondelegate1
-(void)DGClickBrokeDisPlayPic:(NSString *)picpath ConView:(UIView *)conview FormImage:(UIImage *)fromimage
{
	NSIndexPath *indexpath;
	int flag = 0;
	for(int i=0;i<[arraydata count];i++)
	{
		NSDictionary *dictemp = [arraydata objectAtIndex:i];
		if([[dictemp objectForKey:@"file_url"] isEqualToString:picpath])
		{
			flag = 1;
			indexpath = [NSIndexPath indexPathForRow:i inSection:0];
			break;
		}
		
	}
	if(flag == 1)
	{
		UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
		CGRect rectInTableView = [tableview rectForRowAtIndexPath:indexpath];//获取cell在tableView中的位置
		CGRect rectInSuperview = [tableview convertRect:rectInTableView toView:app.window];
		CGRect rectPicView = [cell convertRect:conview.frame toView:app.window];
		DLog(@"size==%f,%f,%f,%f",rectInSuperview.origin.x,rectInSuperview.origin.y,rectPicView.origin.x,rectPicView.origin.y);
		BrokeDisplayPicView *brokedisplay = [[BrokeDisplayPicView alloc] initWithFrame:CGRectMake(rectPicView.origin.x, rectInSuperview.origin.y, 100, 150) PicPath:picpath FromImage:fromimage];
		[app.window addSubview:brokedisplay];
		[UIView transitionWithView:brokedisplay duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
			brokedisplay.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
		} completion:^(BOOL finished) {
			//finished判断动画是否完成
			if (finished) {
				
			}
		}];
	}
}

#pragma mark 音频播放
-(void)tostop:(id)sender
{
	[self.player stop];
	
}

-(void)DGPlayaudio:(NSString *)mp3path PlayStatus:(EnPlaytatus)playstatus
{
	if(playstatus==EnStop)
	{
		[self.player stop];
		self.player = nil;
	}
	else
	{
		if(self.player!=nil)
		{
			[self.player stop];
			self.player = nil;
		}
		NSError *playerError;
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:mp3path]];
		AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
	//	[[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:mp3path] error:&playerError];
		self.player = audioPlayer;
		self.player.volume = 5.0f;
		if (self.player == nil)
		{
			NSLog(@"ERror creating player: %@", [playerError description]);
		}
		self.player.numberOfLoops = 0;
		self.player.delegate = self;
		[self.player play];
	}

}


#pragma mark 接口
-(void)getbrokelist:(NSString *)page PageSize:(NSString *)pagesize FreshDirect:(NSString *)direct
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:page forKey:@"cw_page"];
	[params setObject:pagesize forKey:@"cw_pagesize"];
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceBrokeList ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			[arraydata removeAllObjects];
			[arrayheight removeAllObjects];
			NSArray *arraytemp = [dic objectForKey:@"data"];
			
			for(int i=(int)[arraytemp count];i>0;i--)
			{
				NSDictionary *dictemp = [arraytemp objectAtIndex:i-1];
				[arraydata addObject:dictemp];
			}
			
			
			for(int i=0;i<[arraydata count];i++)
			{
				NSDictionary *dictemp = [arraydata objectAtIndex:i];
				if([[dictemp objectForKey:@"type"] isEqualToString:@"1"])  //表示文字
				{
					CGSize sizetemp = [AddInterface getlablesize:[dictemp objectForKey:@"content"] Fwidth:SCREEN_WIDTH-130 Fheight:1000 Sfont:FONTN(14.0f)];
					[arrayheight addObject:[NSString stringWithFormat:@"%f",sizetemp.height+40]];
				}
				else if([[dictemp objectForKey:@"type"] isEqualToString:@"2"])  //表示图片
				{
					[arrayheight addObject:[NSString stringWithFormat:@"%f",170.0f]];
				}
				else if([[dictemp objectForKey:@"type"] isEqualToString:@"4"])  //表示音频
				{
					[arrayheight addObject:[NSString stringWithFormat:@"%f",60.0f]];
				}
				else if([[dictemp objectForKey:@"type"] isEqualToString:@"3"]) //表示视频
				{
					[arrayheight addObject:[NSString stringWithFormat:@"%f",140.0f]];
				}
			}
			tableview.delegate = self;
			tableview.dataSource = self;
			[tableview reloadData];
			if([direct isEqualToString:@"foot"])
			{
                if([arrayheight count]>10)
                {
                    CGPoint offset = CGPointMake(0, tableview.contentSize.height - tableview.frame.size.height);
                    [tableview setContentOffset:offset animated:YES];
                }
			}
			else
				[tableview setContentOffset:CGPointMake(0, 0) animated:YES];
            
            if([arrayheight count]>10)
            {
            MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
            header.lastUpdatedTimeLabel.hidden = YES;
            header.stateLabel.hidden = YES;
            
            
            tableview.mj_header = header;
            }
		}
		else
		{
		//	[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
		[tableview.mj_header endRefreshing];
	} Failur:^(NSString *strmsg) {
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
        [tableview.mj_header endRefreshing];
		
	}];
}

#pragma mark 上传音频接口
-(void)uploadaudio:(NSString *)audiopath
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	[params setObject:[NSString stringWithFormat:@"%d",10] forKey:@"time"];
    [params setObject:@"audio" forKey:@"uploadType"];
	[params setObject:@"app" forKey:@"project"];
	[params setObject:@"broke" forKey:@"module"];
    
	[params setObject:CwVersion forKey:@"cw_version"];
	[params setObject:CwDevice forKey:@"cw_device"];
	[params setObject:app.Gmachid forKey:@"cw_machine_id"];
	[params setObject:app.userinfo.userid forKey:@"cw_user_id"];

	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
	
	[manager POST:[URLResouceUpLoadHeader stringByAppendingString:InterfaceBrokeUploadResource] parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
		NSURL *url = [NSURL fileURLWithPath:audiopath];
		NSData *videoData = [NSData dataWithContentsOfURL:url];
		[formData appendPartWithFileData:videoData name:@"file" fileName:@"audio.mp3" mimeType:@"video/quicktime"];
	}
		 progress:^(NSProgress * _Nonnull uploadProgress)
	 {

		 
	 }
	 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	 {
		 NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
		 DLog(@"str====%@",str);
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 
		 NSLog(@"responseObject = %@,",jsonvalue);
		 if([[jsonvalue objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 NSDictionary *dicrevice = [jsonvalue objectForKey:@"data"];
			 if([self.deletage1 respondsToSelector:@selector(DGUpLoadBrokeContentItem:FileURL:FileId:Content:TimeLength:)])
			 {
				 [self.deletage1 DGUpLoadBrokeContentItem:@"4" FileURL:[dicrevice objectForKey:@"url"] FileId:[dicrevice objectForKey:@"id"] Content:@"" TimeLength:[NSString stringWithFormat:@"%@",[dicrevice objectForKey:@"time"]]];
			 }
			 [self sendMessage:[NSString stringWithFormat:@"audio[%@]",[dicrevice objectForKey:@"url"]]];
		 }
		 else
		 {
			 [MBProgressHUD showError:[jsonvalue objectForKey:@"msg"] toView:app.window];
		 }
		 
		 
	 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

		 NSLog(@"error = %@",error);
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
	 }];

	
	
	
}





@end
