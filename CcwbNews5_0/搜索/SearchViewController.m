//
//  SearchViewController.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[self initparament:nil];
	[self gethotword];
}

-(void)initparament:(id)sender
{
	[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
	arraydata=[[NSMutableArray alloc] init];
	arrayhot = [[NSMutableArray alloc] init];    //高度
	arrayheight = [[NSMutableArray alloc] init];
	nowpage = 1;
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = COLORNOW(237, 237, 237);
	if(tableview == nil)
	{
		[self addtableview];
	}
	
}

-(void)addnavigateionview
{
	HpNavigateView *hpna = [[HpNavigateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) FromFlag:@"2"];
	hpna.delegate1 = self;
	hpna.tag = EnHpNctlViewTag;
	[self.navigationController.navigationBar addSubview:hpna];
}

-(void)addheaderview:(NSArray *)arrayheader
{
	viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	viewheader.backgroundColor = [UIColor clearColor];
	viewheader.tag = EnHpChannelViewTAG;
	tableview.tableHeaderView = viewheader;
	
	int painum = 3;//每排显示几个
	float widthspace = 25;//(SCREEN_WIDTH-50)/(painum-1); //2表示3个按钮中间间隔两个空白
	float nowwidth = 20;   //第一个按钮左边距
	float heightnow = 15;  //第一排按钮的距顶高度
	int counth = 0; //多少排
	int countv = 0; //多少列
	float btwidth = (SCREEN_WIDTH-nowwidth*2-widthspace*2)/3;
	int countfocus = (int)[arrayheader count];  //共多少个元素
	counth = (countfocus%painum==0?countfocus/painum:countfocus/painum+1);
	
	
	for(int i=0;i<counth;i++)
	{
		DLog(@"heightnow===%f",heightnow);
		if(i<counth-1)
		{
			countv = painum;
		}
		else
		{
			countv = countfocus%painum;
		}
		nowwidth = 25;
		for(int j=0;j<countv;j++)
		{
			NSDictionary *dictemp = [arrayheader objectAtIndex:i*painum+j];
			UIButton *buttonfunction = [UIButton buttonWithType:UIButtonTypeCustom];
			
			buttonfunction.frame= CGRectMake(nowwidth+j*(btwidth+widthspace), heightnow+i*(30+10), btwidth, 30);
			[buttonfunction setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
			buttonfunction.tag = EnSearchHotWordBtTag+i*3+j;
			buttonfunction.layer.cornerRadius = 15.0f;
			buttonfunction.clipsToBounds = YES;
			buttonfunction.titleLabel.font = FONTN(15.0f);
			buttonfunction.backgroundColor = [UIColor whiteColor];
			[buttonfunction setTitleColor:COLORNOW(20, 20, 20) forState:UIControlStateNormal];
			[buttonfunction addTarget:self action:@selector(clickhotword:) forControlEvents:UIControlEventTouchUpInside];
			[viewheader addSubview:buttonfunction];

		}
	}
	viewheader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40*counth+heightnow);

}

-(void)addtableview
{
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-47-20)];
	tableview.showsVerticalScrollIndicator = NO;
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:tableview];
	
	MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
	footer.stateLabel.hidden = YES;
	footer.automaticallyRefresh = NO;
	
	tableview.mj_footer = footer;
	
	YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
	[self.view addSubview:imageViewgif];
	imageViewgif.tag = EnYLImageViewTag;
	imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
	[[self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag] removeFromSuperview];
	[self addnavigateionview];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    app.gnctl = self.navigationController;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

-(void)tableviewcellheight:(NSArray *)arraysrc
{
	for(int i=0;i<[arraysrc count];i++)
	{
		NSDictionary *dictemp = [arraysrc objectAtIndex:i];
		EnCellType celltype = [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
		float nowheight;
		UIView *viewtemp;
		NSArray *arraygoodlist;
		switch (celltype)
		{
			case EnCellTypeFocus:
				nowheight = 160;
				if(iphone6)
					nowheight = nowheight*iphone6ratio;
				else if(iphone6p)
					nowheight = nowheight*iphone6pratio;
				[arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
				break;
			case EnCellTypeFunction:

				break;
			case EnCellTypeSudden:
				viewtemp = [[BurstNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110) Dicsrc:dictemp];
				[arrayheight addObject:[NSString stringWithFormat:@"%f",viewtemp.frame.size.height]];
				break;
			case EnCellTypeNews:
				nowheight = 100;
				viewtemp = [[CustomNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp];
				[arrayheight addObject:[NSString stringWithFormat:@"%f",viewtemp.frame.size.height]];
				break;
			case EnCellTypeMore:
				viewtemp = [[MoreNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
				[arrayheight addObject:[NSString stringWithFormat:@"%f",viewtemp.frame.size.height]];
				break;
			case EnCellTypeUrl:
				nowheight = 240;
				if(iphone6p)
					nowheight = 240*iphone6pratio;
				else if(iphone6)
					nowheight = 240*iphone6ratio;
				
				[arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
				break;
			case EnCellTypeActivity:
				nowheight = 240;
				if(iphone6p)
					nowheight = 240*iphone6pratio;
				else if(iphone6)
					nowheight = 240*iphone6ratio;
				
				[arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
				break;
			case EnCellTypeApp:
				nowheight = 300;
				[arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
				break;
			case EnCellTypeNewsGroup:
				nowheight = 210;
				[arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
				break;
			case EnCellTypePhotoGroup:
				nowheight = 240;
				[arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
				break;
			case EnCellTypePhoto:
				nowheight = 255;
				[arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
				break;
			case EnCellTypeBiz: //商品
				arraygoodlist = [dictemp objectForKey:@"list"];
				if([arraygoodlist count]>0)
					nowheight = 370;
				else
					nowheight = 190;
				[arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
				break;
			default:
				[arrayheight addObject:[NSString stringWithFormat:@"%f",110.0f]];
				break;
		}
	}
}

#pragma mark ActionDelegate
-(void)DGClickSearchTextField:(NSString *)strsearch
{
	[self getsearchlist:strsearch City:app.diliweizhi.dilicity Page:@"1" Header:@"YES"];
}

-(void)DGClickSearchCannel:(id)sender
{
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)DGDeleteSearchTextfield:(NSString *)strsearch
{
	[[self.view viewWithTag:EnNoSearchImageview] removeFromSuperview];
	tableview.tableHeaderView = viewheader;
	[arrayheight removeAllObjects];
	[arraydata removeAllObjects];
	[tableview reloadData];
}


-(void)DGGotoGoodsDetailView:(NSDictionary *)sender
{
    
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
    {
        strurl = [sender objectForKey:@"url"];
    }
    else
    {
        StoreWebViewViewController *storewebview = [[StoreWebViewViewController alloc] init];
        storewebview.strfromurl = [NSString stringWithFormat:@"%@%@",@"#/goodsinfo?goods_id=",[sender objectForKey:@"id"]];
        [self.navigationController pushViewController:storewebview animated:YES];
    }
}

-(void)DGClickMoreNewsUrl:(NSDictionary *)moredic
{
    NSString *strmoreurl = [moredic objectForKey:@"more_url"];
    if([strmoreurl length]>0)
    {
        [self gotowkwebview:strmoreurl StrTitle:@"列表" StrNewsid:[moredic objectForKey:@"id"] StrInType:[moredic objectForKey:@"in_type"]];
    }
    else if([[moredic objectForKey:@"in_type"] isEqualToString:@"biz"])
    {
        StoreWebViewViewController *storewebview = [[StoreWebViewViewController alloc] init];
        storewebview.strfromurl = @"";
        [self.navigationController pushViewController:storewebview animated:YES];
    }
    else
    {
        NewsListViewController *newslist = [[NewsListViewController alloc] init];
        newslist.fccw_type = [moredic objectForKey:@"id"];
        newslist.fcfromflag = @"1";
        [self.navigationController pushViewController:newslist animated:YES];
    }
}

-(void)DGClickBurstNews:(NSDictionary *)sender
{
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:[sender objectForKey:@"app_name"] StrNewsid:[sender objectForKey:@"id"] StrInType:[sender objectForKey:@"in_type"]];
}

-(void)DGclickNewsZuPic:(NSDictionary *)sender
{
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:@"" StrNewsid:[sender objectForKey:@"id"] StrInType:[sender objectForKey:@"in_type"]];
}

-(void)DGClickSingleTuJipic:(id)sender
{
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:@"" StrNewsid:[sender objectForKey:@"id"] StrInType:[sender objectForKey:@"in_type"]];
}

-(void)DGClickActivityPic:(NSDictionary *)sender
{
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:[sender objectForKey:@"title"] StrNewsid:[sender objectForKey:@"id"] StrInType:[sender objectForKey:@"in_type"]];
}

-(void)DGFocusClickNumberPic:(NSDictionary *)sender
{
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:@"焦点新闻详情" StrNewsid:[sender objectForKey:@"id"] StrInType:[sender objectForKey:@"in_type"]];
}

-(void)DGclickTuJiPic:(NSDictionary *)sender
{
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:@"" StrNewsid:[sender objectForKey:@"id"] StrInType:[sender objectForKey:@"in_type"]];
}



-(void)DGclickpersoncenter:(id)sender
{
	PersonCenterViewController *personcenter = [[PersonCenterViewController alloc] init];
	[self.navigationController pushViewController:personcenter animated:YES];
}




-(void)DGClickWkWebViewAlert:(id)sender
{
	[self presentViewController:sender animated:YES completion:nil];
}






#pragma mark IBaction
-(void)gotowkwebview:(NSString *)str StrTitle:(NSString *)strtitle StrNewsid:(NSString *)strnewsid StrInType:(NSString *)strintype
{
    WkWebViewCustomViewController *webviewcustom = [[WkWebViewCustomViewController alloc] init];
    NSString *requeststring = str;
    if([requeststring rangeOfString:@"?"].location !=NSNotFound)
    {
        requeststring = [NSString stringWithFormat:@"%@&cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requeststring,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid!=nil?app.userinfo.userid:@""];
    }
    else
    {
        requeststring = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requeststring,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid!=nil?app.userinfo.userid:@""];
    }
    webviewcustom.delegate1 = self;
    webviewcustom.strtitle = strtitle;
    webviewcustom.strurl = requeststring;
    [self.navigationController pushViewController:webviewcustom animated:YES];
}

-(void)clickhotword:(id)sender
{
	int tagnow = (int)[(UIButton *)sender tag]-EnSearchHotWordBtTag;
	NSDictionary *dictemp = [arrayhot objectAtIndex:tagnow];
	
	HpNavigateView *nctlview = [self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag];
	UITextField *textfield = [nctlview viewWithTag:EnSearchTextFieldTag];
	
	textfield.text = [dictemp objectForKey:@"name"];
	[textfield resignFirstResponder];
	[self getsearchlist:textfield.text City:app.diliweizhi.dilicity Page:@"1" Header:@"YES"];
	
}

-(void)loadMoreData
{
	DLog(@"test");
	HpNavigateView *nctlview = [self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag];
	UITextField *textfield = [nctlview viewWithTag:EnSearchTextFieldTag];
	if([textfield.text length]>1)
		[self getsearchlist:textfield.text City:app.diliweizhi.dilicity Page:[NSString stringWithFormat:@"%d",nowpage] Header:@"NO"];
	else
	{
		[MBProgressHUD showError:@"至少输入2个字符" toView:app.window];
		[tableview.mj_footer endRefreshing];
	}
}


#pragma mark tableview 代理
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
	float nowheight;
	NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
	EnCellType celltype = [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
	FocusNewsView *focusnews;
	BurstNewsView *burstnews;
	CustomNewsView *customnews;
	MoreNewsView *moreview;
	ActivityNow *activitynow;
	ApplicationRecommendView *apprecommend;
	CcwbNewsSaidView *ccwbnews;
	TuJiView *ccwbtuji;
	URLTypeView *urltype;
	SingleTuJiView *singletuji;
	GoodsCellView *cellview;
	NSArray *arraygoodslist;
	switch (celltype)
	{
		case EnCellTypeFocus:
			focusnews = [[FocusNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) Focus:dictemp];
			focusnews.delegate1 = self;
			[cell.contentView addSubview:focusnews];
			break;
		case EnCellTypeSudden: //突发
			burstnews = [[BurstNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110) Dicsrc:dictemp Sudden:@"more"];
			burstnews.delegate1 = self;
			[cell.contentView addSubview:burstnews];
			break;
		case EnCellTypeNews:   //普通新闻
			nowheight = 100;
			customnews = [[CustomNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp];
			[cell.contentView addSubview:customnews];
			break;
		case EnCellTypeMore:
			moreview = [[MoreNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
			[cell.contentView addSubview:moreview];
			break;
		case EnCellTypeUrl:
			urltype = [[URLTypeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) Dicsrc:dictemp TypeUrl:@"more"];
			urltype.delegate1 = self;
			[cell.contentView addSubview:urltype];
			break;
		case EnCellTypeActivity:
			activitynow = [[ActivityNow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) Dicsrc:dictemp TypeActivity:@"more"];
			activitynow.delegate1 = self;
			[cell.contentView addSubview:activitynow];
			break;
		case EnCellTypeApp: //应用推荐
			apprecommend = [[ApplicationRecommendView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) Dicsrc:dictemp];
			apprecommend.delegate1 = self;
			[cell.contentView addSubview:apprecommend];
			break;
		case EnCellTypeNewsGroup:
			ccwbnews = [[CcwbNewsSaidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210) Dicsrc:dictemp More:@"more"];
			ccwbnews.delegate1= self;
			[cell.contentView addSubview:ccwbnews];
			break;
		case EnCellTypePhotoGroup:
			ccwbtuji = [[TuJiView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) Dicsrc:dictemp More:@"more"];
			ccwbtuji.delegate1= self;
			[cell.contentView addSubview:ccwbtuji];
			break;
		case EnCellTypePhoto:
			singletuji = [[SingleTuJiView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 255) Dicsrc:dictemp];
			singletuji.delegate1= self;
			[cell.contentView addSubview:singletuji];
			break;
		case EnCellTypeBiz:
			arraygoodslist = [dictemp objectForKey:@"list"];
			if([arraygoodslist count]>0)
				nowheight = 370;
			else
				nowheight = 190;
			
			cellview = [[GoodsCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp More:@"more"];
			cellview.delegate1 = self;
			[cell.contentView addSubview:cellview];
			break;
		default:
			cell.textLabel.text = [NSString stringWithFormat:@"123+%d",(int)indexPath.row];
			break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    NSString *strurl;
    if([[dictemp objectForKey:@"show_type"] isEqualToString:@"normal"])
    {
        if([[dictemp objectForKey:@"url"] length]>0)
            strurl = [dictemp objectForKey:@"url"];
        else
            strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[dictemp objectForKey:@"id"]];
        [self gotowkwebview:strurl StrTitle:@"新闻详情" StrNewsid:[dictemp objectForKey:@"id"] StrInType:[dictemp objectForKey:@"in_type"]];
    }
    else if([[dictemp objectForKey:@"show_type"] isEqualToString:@"more"])//当是显示更我推荐新闻cell是进
    {
        NewsListViewController *newslist = [[NewsListViewController alloc] init];
        newslist.fccw_type = [dictemp objectForKey:@"id"];
        newslist.fcfromflag = @"2";
        [self.navigationController pushViewController:newslist animated:YES];
    }
    else if([[dictemp objectForKey:@"show_type"] isEqualToString:@"LiveVideo"])
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            parameters[LVMovieParameterDisableDeinterlacing] = @(YES);
        
        /****这里换成直播、点播的地址****/
        NSString *path =  [dictemp objectForKey:@"url"];//@"http://r03.wscdn.hls.xiaoka.tv/live/xRfgXFw02cCzJZb8/playlist.m3u8";
        LVMovieViewController *videoPlayVC = [LVMovieViewController movieViewControllerWithContentPath:path parameters:parameters];
        [self presentViewController:videoPlayVC animated:YES completion:nil];
    }
}



#pragma mark 接口
-(void)gethotword
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceGetHotWord ShowView:app.window alwaysdo:^{
		
	}
										  Success:^(NSDictionary *dic)
	{
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			arrayhot = [dic objectForKey:@"list"];
			[self addheaderview:arrayhot];
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
		[[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	} Failur:^(NSString *strmsg) {
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
		[tableview.mj_footer endRefreshing];
		[[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	}];
}


-(void)getsearchlist:(NSString *)keyword City:(NSString *)city Page:(NSString *)page Header:(NSString *)header
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_page"] = page;
	params[@"cw_keyword"] = keyword;
	params[@"cw_city"] = city;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceGetSearchList ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 if([header isEqualToString:@"YES"])
			 {
				 nowpage = nowpage+1;
				 arraydata = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"newsList"]];
				 
				 [arrayheight removeAllObjects];
				 
				 [self tableviewcellheight:arraydata];
				 
			 }
			 else
			 {
				 NSArray *arraynew = [dic objectForKey:@"newsList"];
				 if([arraynew count]>0)   //当有新数据的时候页面加1
					 nowpage = nowpage+1;
				 for(int i=0;i<[arraynew count];i++)
				 {
					 NSDictionary *dictemp = [arraynew objectAtIndex:i];
					 [arraydata addObject:dictemp];
				 }
				 
				 [arrayheight removeAllObjects];
				 
				 [self tableviewcellheight:arraydata];
			 }
			 
			 if([arrayheight count]>0)
			 {
				 [[self.view viewWithTag:EnNoSearchImageview] removeFromSuperview];
				 tableview.tableHeaderView = nil;
			 }
			 else
			 {
				 UIView *viewnosearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
				 viewnosearch.backgroundColor = COLORNOW(235, 235, 235);
				 viewnosearch.tag = EnNoSearchImageview;
				 [self.view addSubview:viewnosearch];
				 
				 UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 186)];
				 imageview.image = LOADIMAGE(@"未搜索到", @"png");
				 imageview.center = CGPointMake(SCREEN_WIDTH/2, 250);
				 [viewnosearch addSubview:imageview];
			 }
			 
			 tableview.delegate = self;
			 tableview.dataSource = self;
			 if([arraydata count]==[arrayheight count])
				 [tableview reloadData];
			 else
				 [MBProgressHUD showError:@"数据不称,请稍候再请求!" toView:app.window];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
		 // 结束刷新
		 [tableview.mj_footer endRefreshing];
		 [tableview.mj_header endRefreshing];
		 [[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
		 [tableview.mj_footer endRefreshing];
		 [[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
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
