//
//  HomePageViewController.m
//  CcwbNews
//
//  Created by xyy520 on 16/4/27.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController
@synthesize strchannelid;

/**
 *  首页
 */

#pragma mark 初始化信息
- (void)viewDidLoad
{
    [super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
	{
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSFileManager *filemanger = [NSFileManager defaultManager];
	if(![filemanger fileExistsAtPath:AddGuidePage1])
	{
		NSString *string = @"guide";
		[string writeToFile:AddGuidePage1 atomically:NO encoding:NSUTF8StringEncoding error:nil];
		[self addguidepage];
	}
	
	
	[self initparament:nil];

}

-(void)initparament:(id)sender
{
    
	nowpage = 1;
	repatcount = 0;
	strchannelid = @"";
	entypefoled = EnFolded; //折叠
	arraydata=[[NSMutableArray alloc] init];
	arrayheight = [[NSMutableArray alloc] init];    //高度
	arrayappchannellist = [[NSArray alloc] init];   //频道
	arrayfocuschannellist = [[NSArray alloc] init];  //焦点
	arrayapplicationfirstin = [[NSMutableArray alloc] init];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = COLORNOW(237, 237, 237);
	if(tableview == nil)
	{
		scrollviewbg = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-47)];
		scrollviewbg.backgroundColor = [UIColor clearColor];
		scrollviewbg.showsVerticalScrollIndicator = NO;
		[self.view addSubview:scrollviewbg];
		[self addtableview];
		
		
	}
	
    [self getAppToken];
    [CustomPageObject adddefaultpath];
	
	
	//版本更新
	[self getAppUpdata];
	
}

-(void)addnavigateionview
{
	[[self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag] removeFromSuperview];
	HpNavigateView *hpna = [[HpNavigateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) FromFlag:@"1"];
	hpna.delegate1 = self;
	hpna.tag = EnHpNctlViewTag;
	[self.navigationController.navigationBar addSubview:hpna];
//	if([self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag] == nil)
//	{
//		HpNavigateView *hpna = [[HpNavigateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) FromFlag:@"1"];
//		hpna.delegate1 = self;
//		hpna.tag = EnHpNctlViewTag;
//		[self.navigationController.navigationBar addSubview:hpna];
//	}
//	else
//	{
//		UIButton *buttonheader = [[self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag] viewWithTag:EnHpUserHeaderPic];
//		[buttonheader setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[app.userinfo.userheader length]>0?app.userinfo.userheader:@""] placeholderImage:LOADIMAGE(@"hp_个人头像", @"png")];
//	}
}

-(void)addheaderview:(NSArray *)arrayheader
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
	view.backgroundColor = [UIColor whiteColor];
	view.tag = EnHpChannelViewTAG;
	[self.view addSubview:view];
	float nowwidth = SCREEN_WIDTH/[arrayheader count];
	for(int i=0;i<[arrayappchannellist count];i++)
	{
		NSDictionary *dictemp = [arrayappchannellist objectAtIndex:i];
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.layer.borderColor = [UIColor clearColor].CGColor;
		button.frame = CGRectMake(0+nowwidth*i, 0, nowwidth, 40);
		[button setTitle:[dictemp objectForKey:@"name"] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		button.titleLabel.font = FONTN(15.0f);
		button.tag = EnHpChannelButtonTag+i;
		[button addTarget:self action:@selector(clickchannel:) forControlEvents:UIControlEventTouchUpInside];
		[view addSubview:button];
		if(i==0)
		{
			UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, view.frame.size.height-3, nowwidth, 3)];
			imageview.backgroundColor = COLORNOW(232, 56, 47);
			imageview.tag = EnHpChannelImageViewTag;
			[view addSubview:imageview];
		}
		
		
	}
	
	tableview.frame =CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-47-20-40);
	
	
}

-(void)addtableview
{
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-47-20)];
	tableview.showsVerticalScrollIndicator = NO;
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
	[scrollviewbg addSubview:tableview];
	
	MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
	header.lastUpdatedTimeLabel.hidden = YES;
	header.stateLabel.hidden = YES;
	
	
//	tableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
	
	MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
	footer.stateLabel.hidden = YES;
	footer.automaticallyRefresh = YES;
	
	tableview.mj_header = header;
	tableview.mj_footer = footer;
	
	YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
	[self.view addSubview:imageViewgif];
	imageViewgif.tag = EnYLImageViewTag;
	imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
}


#pragma mark IBaction

-(void)addpopadview:(NSString *)requeststring Appid:(NSString *)appid
{
	if([requeststring rangeOfString:@"?"].location !=NSNotFound)
	{
		requeststring = [NSString stringWithFormat:@"%@&cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@&cw_appid=%@",requeststring,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid!=nil?app.userinfo.userid:@"",appid];
	}
	else
	{
		requeststring = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@&cw_appid=%@",requeststring,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid!=nil?app.userinfo.userid:@"",appid];
	}
	UIView *viewhomead = [app.window viewWithTag:EnHomePopAdViewTag];
	PopAdView *popview = [[PopAdView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Requeststr:requeststring];
	popview.tag = EnPopAdViewTag;
	popview.delegate1 = self;
	if(viewhomead!=nil)
	{
		[app.window insertSubview:popview belowSubview:viewhomead];
	}
	else
	{
		[app.window addSubview:popview];
	}
}

-(void)setapplicationfirstshow:(NSString *)appid Show:(NSString *)show
{
	NSMutableDictionary *dicinput = [NSMutableDictionary dictionary];
	dicinput[@"appid"] = appid;
	dicinput[@"cw_show"] = show;
	[arrayapplicationfirstin addObject:dicinput];
}

-(void)comparapplicationfirstin:(NSMutableArray *)arrayapp
{
	for(int i=0;i<[arrayapp count];i++)
	{
		int flag = 0;
		NSDictionary *dictemp = [arrayapp objectAtIndex:i];
		for(int j=0;j<[arrayapplicationfirstin count];j++)
		{
			NSDictionary *dicfirst = [arrayapplicationfirstin objectAtIndex:j];
			if([[dictemp objectForKey:@"id"] isEqualToString:[dicfirst objectForKey:@"appid"]])
			{
				flag = 1;
				break;
			}
			
		}
		if(flag == 0)
		{
			[self setapplicationfirstshow:[dictemp objectForKey:@"id"] Show:@"1"];
		}
		
	}
	
}

-(void)initapplicationfirstin
{
	[self comparapplicationfirstin:app.arrayfixedapplication];
	[self comparapplicationfirstin:app.arrayaddapplication];
	[arrayapplicationfirstin writeToFile:ApplicationFirstin atomically:NO];
}

-(void)clickchannel:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnHpChannelButtonTag;
	UIImageView *imageview = [[self.view viewWithTag:EnHpChannelViewTAG] viewWithTag:EnHpChannelImageViewTag];
	imageview.frame = CGRectMake(button.frame.origin.x, imageview.frame.origin.y, imageview
								 .frame.size.width, imageview.frame.size.height);
	NSDictionary *dicchannel = [arrayappchannellist objectAtIndex:tagnow];
	strchannelid = [dicchannel objectForKey:@"id"];
	nowpage = 1;
	[self gethpapplist:@"1" ChannelId:strchannelid City:app.diliweizhi.dilicity Header:@"YES" CW_Time:@""];
}

-(void)jumpeadversie:(id)sender
{
	[self removeadvertise:0];
}

-(void)getappdefaultapplist
{
	[self getDefaultlist:app.Gmachid];
}

-(void)addadver:(NSDictionary *)dictemp
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	view.backgroundColor = [UIColor redColor];
	view.tag = 99;
	
	UIImageView *imageviewbg  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	imageviewbg.image = LOADIMAGE(@"text1", @"png");
	[view addSubview:imageviewbg];
	
	UIImageView *imageviewad  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
	imageviewad.contentMode = UIViewContentModeScaleAspectFill;
	imageviewad.clipsToBounds = YES;
	[imageviewad setImageWithURL:[NSURL URLWithString:[dictemp objectForKey:@"pic"]] placeholderImage:LOADIMAGE(@"test2", @"png")];
	[view addSubview:imageviewad];
	
	[app.window addSubview:view];
}

//获取首页
-(void)getapparraylist
{
	if([app.arrayfixedapplication count]>0)
	{
		NSDictionary *dictemp = [app.arrayfixedapplication objectAtIndex:0];
		SelectedApp = [dictemp objectForKey:@"id"];
		strlastappid = SelectedApp;
	}
	else
	{
		NSDictionary *dictemp = [app.arrayaddapplication objectAtIndex:0];
		SelectedApp = [dictemp objectForKey:@"id"];
		strlastappid = SelectedApp;
	}
	[self getappchannel:SelectedApp]; //请求第一个应用首页
}

-(void)viewWillAppear:(BOOL)animated
{
	if(bottomview != nil)
	{
		int flag = 0;
		if([app.arrayaddapplication count]>0)
		{
			NSDictionary *dicone = [app.arrayaddapplication objectAtIndex:0];
			//处理第一次的时候处理addapplication这个里面的图片会变大的问题
			if([[dicone objectForKey:@"id"] isEqualToString:SelectedApp])
			{
				for(int i=0;i<[arrayapplicationfirstin count];i++)
				{
					NSDictionary *dictemp = [arrayapplicationfirstin objectAtIndex:i];
					if([[dictemp objectForKey:@"appid"] isEqualToString:SelectedApp])
					{
						if([[dictemp objectForKey:@"cw_show"] isEqualToString:@"1"])
						{
							flag = 1;
						}
						break;
					}
				}
			}
		}
		if(flag == 0)
			[bottomview againarrangement:SelectedApp];
		else
			[bottomview againarrangement:@""];
	}
	
	[self addnavigateionview];
	if([SelectedApp isEqualToString:@"AddApplication"])
	{
		[self.navigationController setNavigationBarHidden:YES];
	}
	else
	{
		[self.navigationController setNavigationBarHidden:NO];
	}
	self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
	app.gnctl = self.navigationController;
	[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
				if(entypefoled == EnFolded)
				{
					nowheight = 90;
					[arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
				}
				else if(entypefoled == EnUnFolded)
				{
					viewtemp = [[FunctionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130) Focus:dictemp  EnFoledType:entypefoled];
					[arrayheight addObject:[NSString stringWithFormat:@"%f",viewtemp.frame.size.height]];
				}
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

#pragma mark actiondelegate代理
-(void)gotowkwebview:(NSString *)str StrTitle:(NSString *)strtitle
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

-(void)DGClickHpFunctionView:(NSDictionary *)dicfuncitem
{
	if([[dicfuncitem objectForKey:@"in_type"] isEqualToString:@"ask"])//ar/vr
	{
        AskBrokeViewController *askbroke = [[AskBrokeViewController alloc] init];
        UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:askbroke];
        [self.navigationController presentViewController:nctl animated:YES completion:nil];	}
    else if([[dicfuncitem objectForKey:@"in_type"] isEqualToString:@"ar"])//ar/vr
    {
        ScanQRCodeARViewController *scanqrcode = [[ScanQRCodeARViewController alloc] init];
        UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:scanqrcode];
        [self.navigationController presentViewController:nctl animated:YES completion:nil];
    }
	else if([[dicfuncitem objectForKey:@"in_type"] isEqualToString:@"url"])
	{
		[self gotowkwebview:[dicfuncitem objectForKey:@"url"] StrTitle:[dicfuncitem objectForKey:@"title"]];
	}
}

-(void)DGGotoPopAdView:(NSString *)popadurl
{
//	[self gotowkwebview:popadurl];
//	[[app.window viewWithTag:EnPopAdViewTag] removeFromSuperview];
}

-(void)DGClickgotoqrcode:(id)sender
{
	ScanQRCodeARViewController *scanqrcode = [[ScanQRCodeARViewController alloc] init];
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:scanqrcode];
	[self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)DGClickwkwebviewCustomview:(NSString *)clickurl
{
//	[self gotowkwebview:clickurl];
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
//        WkWebViewLocationHtmlViewController *wkwebview = [[WkWebViewLocationHtmlViewController alloc] init];
//        [self.navigationController pushViewController:wkwebview animated:YES];
    }
}

-(void)DGClickMoreNewsUrl:(NSDictionary *)moredic
{
    NSString *strmoreurl = [moredic objectForKey:@"more_url"];
    if([strmoreurl length]>0)
    {
        [self gotowkwebview:strmoreurl StrTitle:@"列表"];
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
    [self gotowkwebview:strurl StrTitle:[sender objectForKey:@"app_name"]];
}

-(void)DGclickNewsZuPic:(NSDictionary *)sender
{
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:@""];
}

-(void)DGClickSingleTuJipic:(id)sender
{
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:@""];
}

-(void)DGClickActivityPic:(NSDictionary *)sender
{
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:[sender objectForKey:@"app_name"]];
}

-(void)DGFocusClickNumberPic:(NSDictionary *)sender
{
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:@"焦点新闻详情"];
}

-(void)DGclickTuJiPic:(NSDictionary *)sender
{
//	[self gotowkwebview:[sender objectForKey:@"url"]];
//    http://172.16.5.37/app/public/apppage/AppPage/detail.html?cw_id=20170720103240V45ZUS
    NSString *strurl;
    if([[sender objectForKey:@"url"] length]>0)
        strurl = [sender objectForKey:@"url"];
    else
        strurl = [NSString stringWithFormat:@"%@%@",URLNewsDetailHref,[sender objectForKey:@"id"]];
    [self gotowkwebview:strurl StrTitle:@""];
}

-(void)DGclickAddAppMachine:(NSDictionary *)sender
{
	[bottomview removeFromSuperview];
	bottomview = [[BottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-47, SCREEN_WIDTH, 47)];
	if([SelectedApp isEqualToString:@"AddApplication"])
	{
	}
	else
	{
		bottomview.frame = CGRectMake(0, SCREEN_HEIGHT-47-64, SCREEN_WIDTH, 47);
	}
	
	
	bottomview.delegate1 = self;
	[self.view addSubview:bottomview];
	
	UIScrollView *scrollview = bottomview.scrollview;
	[scrollview setContentOffset:CGPointMake(SCREEN_WIDTH/5*([app.arrayaddapplication count]>3?[app.arrayaddapplication count]-3:0), 0) animated:NO];
	
}

-(void)DGclickpersoncenter:(id)sender
{
	PersonCenterViewController *personcenter = [[PersonCenterViewController alloc] init];
	[self.navigationController pushViewController:personcenter animated:YES];
}

-(void)DGclickArrowFolded:(EnTypeFunctionFoled)sender
{
	entypefoled = sender;
	[arrayheight removeAllObjects];
	[self tableviewcellheight:arraydata];
	[tableview reloadData];
}

-(void)DGclickApplicationItem:(NSDictionary *)clickapp   //点击应用
{
	SelectedApp = [clickapp objectForKey:@"id"];
	
	[[self.view viewWithTag:EnAddApplicationWebViewTag] removeFromSuperview];
	[[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	[[self.view viewWithTag:EnHpChannelViewTAG] removeFromSuperview];
	if([[clickapp objectForKey:@"type"] isEqualToString:@"sys"])  //不可排序
	{
		[self.navigationController setNavigationBarHidden:NO];
		bottomview.frame = CGRectMake(0, SCREEN_HEIGHT-47-64, SCREEN_WIDTH, 47);
		
		[self getappchannel:[clickapp objectForKey:@"id"]];
		YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
		[self.view addSubview:imageViewgif];
		imageViewgif.tag = EnYLImageViewTag;
		imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
	}
	else if([[clickapp objectForKey:@"type"] isEqualToString:@"default"])//可排序
	{
		[self.navigationController setNavigationBarHidden:NO];
		bottomview.frame = CGRectMake(0, SCREEN_HEIGHT-47-64, SCREEN_WIDTH, 47);
		
		[self getappchannel:[clickapp objectForKey:@"id"]];
		YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
		[self.view addSubview:imageViewgif];
		imageViewgif.tag = EnYLImageViewTag;
		imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
	}
	else
	{
		bottomview.frame = CGRectMake(0, SCREEN_HEIGHT-47, SCREEN_WIDTH, 47);
		[self.navigationController setNavigationBarHidden:YES];
        
		NSString *requeststring = [clickapp objectForKey:@"url"];
		requeststring = [CustomPageObject getrequesturlstring:requeststring App:app];
		
		WkWebViewCustomView *webdetail = [[WkWebViewCustomView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-bottomview.frame.size.height) StrUrl:requeststring];
		webdetail.tag = EnAddApplicationWebViewTag;
		webdetail.delegate1 = self;
		webdetail.alpha = 0;
		[self.view insertSubview:webdetail belowSubview:bottomview];
		SelectedApp = @"AddApplication";
		[UIView animateWithDuration:0.1 // 动画时长
							  delay:0.1 // 动画延迟
							options:UIViewAnimationOptionCurveLinear // 动画过渡效果
						 animations:^{
							 // code...
							 webdetail.alpha = 1;
						 }
						 completion:^(BOOL finished) {
							 
						 }];
	}
	
	DLog(@"appliction===%@",clickapp);
	
	
}

-(void)DGclickAddApplication:(int)clickflag   //点击添加应用
{
	if([SelectedApp isEqualToString:@"AddApplication"])
	{
		
	}
	else
	{
		[[self.view viewWithTag:EnHpChannelViewTAG] removeFromSuperview];
		[[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
		[[self.view viewWithTag:EnHpChannelViewTAG] removeFromSuperview];
		bottomview.frame = CGRectMake(0, SCREEN_HEIGHT-47, SCREEN_WIDTH, 47);
		[self.navigationController setNavigationBarHidden:YES];
        
        ApplicationHpView *application = [[ApplicationHpView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-bottomview.frame.size.height)];
        application.tag = EnAddApplicationWebViewTag;
        application.delegate1 = self;
        [self.view insertSubview:application belowSubview:bottomview];
        SelectedApp = @"AddApplication";
        [UIView animateWithDuration:0.1 // 动画时长
                              delay:0.1 // 动画延迟
                            options:UIViewAnimationOptionCurveLinear // 动画过渡效果
                         animations:^{
                             // code...
                             application.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             
                         }];
	}
}


-(void)clickfindqrcode
{
	[self gotoscan:nil];
}

-(void)DGClickOpenAppManger:(id)sender
{
	ApplicationMangerViewController *appmanger = [[ApplicationMangerViewController alloc] init];
	appmanger.delegate1 = self;
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:appmanger];
	[self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)DGClickWkWebViewAlert:(id)sender
{
	[self presentViewController:sender animated:YES completion:nil];
}

-(void)DGClickGoToSearch:(id)sender
{
	SearchViewController *search = [[SearchViewController alloc] init];
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:search];
	[self.navigationController presentViewController:nctl animated:YES completion:nil];
}

-(void)DGClickOpenApplication:(NSString *)sender
{
	NSDictionary *clickapp=nil;
	int flagclick = 0;
	for(int i=0;i<[app.arrayaddapplication count];i++)
	{
		NSDictionary *dictemp = [app.arrayaddapplication objectAtIndex:i];
		if([[dictemp objectForKey:@"id"] isEqualToString:sender])
		{
			flagclick = i;
			UIScrollView *scrollview = bottomview.scrollview;
			clickapp = dictemp;
			[scrollview setContentOffset:CGPointMake(SCREEN_WIDTH/5*(i>2?i-1:0), 0) animated:YES];
			break;
		}
	}
	
	//设置变大变小
	int tagnow = flagclick;

	
	UIImageView *clickimage = [bottomview.scrollview viewWithTag:EnBottomApplicationBtTag+100+tagnow];
	for(int i=0;i<[app.arrayaddapplication count];i++)
	{
		UIImageView *imageview = [bottomview.scrollview viewWithTag:EnBottomApplicationImageviewTag+i];
		[UIView transitionWithView:imageview duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
			imageview.frame = CGRectMake((SCREEN_WIDTH/5-23)/2, 8, 23, 23);
			imageview.alpha = 0.7;
			clickimage.frame = CGRectMake((SCREEN_WIDTH/5-30)/2, 5, 30, 30);
			clickimage.alpha = 1;
		} completion:^(BOOL finished) {
			//finished判断动画是否完成
			if (finished) {
				
			}
		}];
	}
	
	
	if(clickapp!=nil)
	{
		[self DGclickApplicationItem:clickapp];
	}
	
}

#pragma mark 上拉下拉加载
-(void)loadNewData
{
	nowpage = 1;
	[self gethpapplist:[NSString stringWithFormat:@"%d",nowpage] ChannelId:strchannelid City:app.diliweizhi.dilicity Header:@"YES" CW_Time:@""];
	YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
	[self.view addSubview:imageViewgif];
	imageViewgif.tag = EnYLImageViewTag;
	imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
	DLog(@"test");
}

-(void)loadMoreData
{
	DLog(@"test");
	
	[self gethpapplist:[NSString stringWithFormat:@"%d",nowpage] ChannelId:strchannelid City:app.diliweizhi.dilicity Header:@"NO" CW_Time:strcw_time];
	YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
	[self.view addSubview:imageViewgif];
	imageViewgif.tag = EnYLImageViewTag;
	imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
}


#pragma mark 广告点击 
-(void)AdTappedpic:(UIGestureRecognizer*)sender
{
	
}


-(void)AddAdverTise:(NSDictionary *)dicad
{
	UIView *viewad = [app.window viewWithTag:EnHomePopAdViewTag];
	UIImageView *imageview = [viewad viewWithTag:EnHomePOPAdImageViewTag];
	[imageview setImageWithURL:URLSTRING([dicad objectForKey:@"pic"])];
	imageview.userInteractionEnabled = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AdTappedpic:)];
	[imageview addGestureRecognizer:singleTap];
	int sec = [[dicad objectForKey:@"time"] intValue]/1000;
	
	UIButton *buttontime = [viewad viewWithTag:EnHomePopAdTimeLabelTag];
	buttontime.alpha = 1;
	[buttontime setTitle:[NSString stringWithFormat:@"%dS跳过",sec] forState:UIControlStateNormal];
	timerad =  [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(Sectimer:) userInfo:nil repeats:YES];
	[self removeadvertise:sec];
	
	[buttontime addTarget:self action:@selector(jumpeadversie:) forControlEvents:UIControlEventTouchUpInside];
	
}

-(void)Sectimer:(id)sender
{
	UIView *viewad = [app.window viewWithTag:EnHomePopAdViewTag];
	UIButton *buttontime = [viewad viewWithTag:EnHomePopAdTimeLabelTag];
	int sec = [[buttontime.currentTitle substringToIndex:1] intValue];
	if(sec >0)
		sec = sec-1;
	else
		sec = 0;
	[buttontime setTitle:[NSString stringWithFormat:@"%dS跳过",sec] forState:UIControlStateNormal];

	
	DLog(@"aaaaaaaa====%d",sec);
}

-(void)removeadvertise:(int)sec
{
	UIView *viewad = [app.window viewWithTag:EnHomePopAdViewTag];

	double delayInSeconds = sec;
	dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
		
		[UIView transitionWithView:viewad duration:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
			viewad.alpha = 0;
		}
		completion:^(BOOL finished)
		{
			if (finished)
			{
				[timerad invalidate];
				timerad = nil;
				[viewad removeFromSuperview];
			}
		}];
		
	});
}

-(void)addactivity:(NSDictionary *)sender
{
}

#pragma mark 二维码扫描
-(void)gotoscan:(id)sender
{
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
	FunctionView *functionview;
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
		case EnCellTypeFunction:
			functionview = [[FunctionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110) Focus:dictemp  EnFoledType:entypefoled];
			functionview.delegate1 = self;
			[cell.contentView addSubview:functionview];
			break;
		case EnCellTypeSudden: //突发
			burstnews = [[BurstNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110) Dicsrc:dictemp];
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
			urltype = [[URLTypeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) Dicsrc:dictemp];
			urltype.delegate1 = self;
			[cell.contentView addSubview:urltype];
			break;
		case EnCellTypeActivity:
			activitynow = [[ActivityNow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) Dicsrc:dictemp];
			activitynow.delegate1 = self;
			[cell.contentView addSubview:activitynow];
			break;
		case EnCellTypeApp: //应用推荐
			apprecommend = [[ApplicationRecommendView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) Dicsrc:dictemp];
			apprecommend.delegate1 = self;
			[cell.contentView addSubview:apprecommend];
			break;
		case EnCellTypeNewsGroup:
			ccwbnews = [[CcwbNewsSaidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210) Dicsrc:dictemp];
			ccwbnews.delegate1= self;
			[cell.contentView addSubview:ccwbnews];
			break;
		case EnCellTypePhotoGroup:
			ccwbtuji = [[TuJiView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) Dicsrc:dictemp];
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
			
			cellview = [[GoodsCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp];
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
        [self gotowkwebview:strurl StrTitle:@"新闻详情"];
//        WkWebviewTestViewController *webviewtest = [[WkWebviewTestViewController alloc] init];
//        [self.navigationController pushViewController:webviewtest animated:YES];
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
//    else if([[dictemp objectForKey:@"show_type"] isEqualToString:@"biz"])
//    {
//        WkWebViewLocationHtmlViewController *wkwebview = [[WkWebViewLocationHtmlViewController alloc] init];
//        [self.navigationController pushViewController:wkwebview animated:YES];
//    }
}
#pragma 引导页
-(void)addguidepage
{
	GuideView *guide = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	guide.tag = EnGuideViewTag;
	guide.delegate1 = self;
	[app.window addSubview:guide];
	UIView *viewad = [app.window viewWithTag:EnHomePopAdViewTag];
	[viewad removeFromSuperview];
}

-(void)guideviewsnift:(id)sender
{
	GuideView *guideview =  (GuideView *)[app.window viewWithTag:EnGuideViewTag];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(removeguideview:)];
	guideview.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	[UIView commitAnimations];
	
	[self getappdefaultapplist];
}

-(void)removeguideview:(id)sender
{
	[[app.window viewWithTag:EnGuideViewTag] removeFromSuperview];
}

-(void)gotonextpushpage:(NSDictionary *)dictemp
{
	
	
}
#pragma mark 转向问题
- (BOOL)shouldAutorotate {
    return NO;
}
//返回直接支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
//返回最优先显示的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}



#pragma mark 接口
//获取token
-(void)getAppToken
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"123" forKey:@"key"];
    [params setObject:@"321" forKey:@"secret"];
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceUploadAuthToken ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            if([[dic objectForKey:@"data"] length]>0)
                app.cwtoken = [dic objectForKey:@"data"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setValue:app.cwtoken forKey:DefaultCWToken];
            [userDefaults synchronize];
            if([app.window viewWithTag:EnGuideViewTag]==nil)
            {
                [self getappdefaultapplist];
            }
        }
        else
        {
            if([app.cwtoken length]>0)
            {
                [self getappdefaultapplist];
            }
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        if([app.cwtoken length]>0)
        {
            [self getappdefaultapplist];
        }
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
    }];
}


//列表
-(void)gethpapplist:(NSString *)page ChannelId:(NSString *)channelid City:(NSString *)city Header:(NSString *)header CW_Time:(NSString *)cw_time
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_page"] = page;
	params[@"cw_channel_id"] = channelid;
	params[@"cw_city"] = city;
	params[@"cw_time"] = cw_time;
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceAppNewsList ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 strcw_time = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cw_time"]];
			 if([header isEqualToString:@"YES"])
			 {
				 nowpage = nowpage+1;
				 arraydata = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"newsList"]];
				 
				 [arrayheight removeAllObjects];
				 
				 [self tableviewcellheight:arraydata];
				 
				 //用于存储首页应用推荐，便于操作的时候管理
				 for(int i=0;i<[arraydata count];i++)
				 {
					 NSDictionary *dictemp = [arraydata objectAtIndex:i];
					 EnCellType celltype = [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
					 switch (celltype)
					 {
						 case EnCellTypeApp:
							 app.arrapprecommend = [[NSMutableArray alloc] initWithArray:[dictemp objectForKey:@"list"]];
							 break;
						 default:
							 break;
					 }
				 }
				
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
				 
				 //用于存储首页应用推荐，便于操作的时候管理
				 for(int i=0;i<[arraydata count];i++)
				 {
					 NSDictionary *dictemp = [arraydata objectAtIndex:i];
					 EnCellType celltype = [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
					 switch (celltype)
					 {
						 case EnCellTypeApp:
							 app.arrapprecommend = [[NSMutableArray alloc] initWithArray:[dictemp objectForKey:@"list"]];
							 break;
						 default:
							 break;
					 }
				 }
				 
//				 if(([arrayheight count]>8)&&[arraynew count]>0)
//				 {
//					 if(iphone6p)
//						 [tableview setContentOffset:CGPointMake(0, tableview.contentOffset.y+300) animated:YES];
//					 else if(iphone6)
//						 [tableview setContentOffset:CGPointMake(0, tableview.contentOffset.y+250) animated:YES];
//					 else
//						 [tableview setContentOffset:CGPointMake(0, tableview.contentOffset.y+240) animated:YES];
//				 }
				 
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
		 [tableview.mj_header endRefreshing];
		 [tableview.mj_footer endRefreshing];
		 [[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
		 [tableview.mj_header endRefreshing];
		 [tableview.mj_footer endRefreshing];
		 [[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	 }];
}

-(void)getappchannel:(NSString *)appid
{
	if([appid length]==0)
	{
		[MBProgressHUD showError:@"没有获取到默认ID，请退出app,重试" toView:self.view];
		return ;
	}
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_app_id"] = appid;
	params[@"cw_show"] = @"1";//第一次的时候传1 ,以后传0
	int flag = 0;
	for(int i=0;i<[arrayapplicationfirstin count];i++)
	{
		NSDictionary *dictemp = [arrayapplicationfirstin objectAtIndex:i];
		if([[dictemp objectForKey:@"appid"] isEqualToString:appid])
		{
			flag = 1;
			if([[dictemp objectForKey:@"cw_show"] isEqualToString:@"1"])
			{
				params[@"cw_show"] = @"1";//第一次的时候传1 ,以后传0
				[arrayapplicationfirstin removeObject:dictemp];
				[self setapplicationfirstshow:appid Show:@"0"];
			}
			else
			{
				params[@"cw_show"] = @"0";
			}
			break;
		}
	}
	if(flag == 0)
	{
		[self setapplicationfirstshow:appid Show:@"0"];
	}
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceAppChannelList ShowView:self.view alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [[self.view viewWithTag:EnHpChannelViewTAG] removeFromSuperview];
			 //判断当前应用是否有广告
			 if([[dic objectForKey:@"ad"] length]>0)
			 {
				 [self addpopadview:[dic objectForKey:@"ad"] Appid:appid];
			 }
			 
			 arrayappchannellist = [dic objectForKey:@"channelList"];
			 if([arrayappchannellist count]>1)
			 {
				 [self addheaderview:arrayappchannellist];
			 }
			 else
			 {
				 tableview.tableHeaderView = nil;
				 [[self.view viewWithTag:EnHpChannelViewTAG] removeFromSuperview];
				 tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-47-20);
			 }
			 arrayfocuschannellist = [dic objectForKey:@"focusList"];
			 if([arrayappchannellist count]>0)
			 {
				 NSDictionary *dicchannel = [arrayappchannellist objectAtIndex:0];
				 strchannelid = [dicchannel objectForKey:@"id"];
				 nowpage = 1;
				 [self gethpapplist:[NSString stringWithFormat:@"%d",nowpage] ChannelId:strchannelid City:app.diliweizhi.dilicity Header:@"YES" CW_Time:@""];
			 }
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
		 [tableview.mj_header endRefreshing];
		 [tableview.mj_footer endRefreshing];
		 [[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	 }];
	
}



-(void)getDefaultlist:(NSString *)sender
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];

	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceAppInit ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			dicadver = [dic objectForKey:@"advertise"];
			app.arrayaddapplication = [[NSMutableArray alloc] initWithArray: [dic objectForKey:@"appList"]];
			app.arrayfixedapplication = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"fixList"]];
			//获取开机广告
			if(([dicadver count]>0)&&[[dicadver objectForKey:@"id"] length]>0)
			{
				[self AddAdverTise:dicadver];
			}
			else
			{
				[[app.window viewWithTag:EnHomePopAdViewTag] removeFromSuperview];
			}
			
			
			if(bottomview == nil)
			{
				bottomview = [[BottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-47-64, SCREEN_WIDTH, 47)];
				bottomview.delegate1 = self;
				[self.view addSubview:bottomview];
			}
			//初始化第一次应用进入
			[self initapplicationfirstin];
			
			//第一次获取数据
			[self getapparraylist];
			
			//上传地理位置
			[self updatajpushregiestid:app.strregiestpushid];
			
			//上传pushid
			[self updatalocation];
			
			
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
	} Failur:^(NSString *strmsg) {
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
		UIView *viewad = [app.window viewWithTag:EnHomePopAdViewTag];
		[viewad removeFromSuperview];
		if(repatcount<10)
		{
			repatcount = repatcount+1;
			[self getDefaultlist:app.Gmachid];
		}
		[tableview.mj_header endRefreshing];
		[tableview.mj_footer endRefreshing];
		[[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
	}];
}





-(void)getAppUpdata
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceUpdataApp ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
			NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
			NSString *serversion = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"number"]];
			NSString *verswitch = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"switch"]];
			if([verswitch isEqualToString:@"0"])
			{
				return ;
			}
			else if([serversion isEqualToString:@"0.0"])
			{
				return ;
			}
			else if(![serversion isEqualToString:currentVersion])
			{
				
				UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本,你确定要更新吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
				
				UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"稍后再更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
					
				}];
				
				UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
					NSString *postUrl = @"http://cwresource.ccwb.cn/Upload/ipa/download.html";
					DLog(@"posturl===%@",postUrl);
					
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl]];
					
					
				}];
				
				// Add the actions.
				[alertController addAction:cancelAction];
				[alertController addAction:otherAction];
				
				[self presentViewController:alertController animated:YES completion:nil];
				
			}
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		}
	} Failur:^(NSString *strmsg) {
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
	}];
}

-(void)updatajpushregiestid:(NSString *)regiestid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_registration"] = regiestid;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:Interfaceupdataregiestid ShowView:app.window alwaysdo:^
	 {
		 
	 }
      Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 
		 }
		 else
		 {
			// [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
	 }];
	
}

-(void)updatalocation
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_city"] = app.diliweizhi.dilicity;
	params[@"cw_country"] = @"中国";
	params[@"cw_longitude"] = [NSString stringWithFormat:@"%f",app.diliweizhi.longitude];
	params[@"cw_latitude"] = [NSString stringWithFormat:@"%f",app.diliweizhi.latitude];
	params[@"cw_province"] = app.diliweizhi.diliprovince;
	params[@"cw_area"] = app.diliweizhi.dililocality;
	
	
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:Interfaceupdatelocation ShowView:app.window alwaysdo:^
	 {
		 
	 }
										  Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 
		 }
		 else
		 {
		//	 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
	 }];
}


//-(BOOL)shouldAutorotate{
//	
//	return YES;
//	
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//	return UIInterfaceOrientationMaskPortrait;//UIInterfaceOrientationMaskAllButUpsideDown;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//	return UIInterfaceOrientationPortrait;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
