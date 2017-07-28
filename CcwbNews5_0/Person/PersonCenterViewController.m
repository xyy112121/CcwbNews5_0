//
//  PersonCenterViewController.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/27.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "PersonCenterViewController.h"

@interface PersonCenterViewController ()

@end

@implementation PersonCenterViewController

- (void)viewWillAppear:(BOOL)animated
{
	if([AddInterface judgeislogin])
	{
		[self getUserInfo];
	}
	else
	{
		
	}
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES];
	app.gnctl = self.navigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	[self.navigationController setNavigationBarHidden:YES];
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 5, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	[button setImage:LOADIMAGE(@"arrowleft", @"png") forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
	
	[button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
	[self initview];
	
    // Do any additional setup after loading the view.
}

-(void)initview
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor whiteColor];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self setExtraCellLineHidden:tableview];
	[self.view addSubview:tableview];
	
	//返回按钮
	UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
	btreturn.layer.borderColor = [UIColor clearColor].CGColor;
	btreturn.frame = CGRectMake(10, 22, 40, 40);
	[btreturn setImage:LOADIMAGE(@"arrowleft", @"png") forState:UIControlStateNormal];
	[btreturn addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
	[btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[self.view addSubview:btreturn];
	
	PersonalHeaderView *viewheader = [[PersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190+73)];
	viewheader.delegate1 = self;
	viewheader.backgroundColor = [UIColor clearColor];
	tableview.tableHeaderView = viewheader;
	
	UIImage* img=LOADIMAGE(@"p_addr_icon", @"png");
	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 20, 80, 44)];
	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
	buttonright.layer.borderColor = [UIColor clearColor].CGColor;
	[buttonright setImage:img forState:UIControlStateNormal];
	buttonright.titleLabel.font = FONTMEDIUM(12.0f);
	[buttonright setTitle:([app.diliweizhi.dilicity length]>0?[app.diliweizhi.dilicity substringToIndex:3]:app.diliweizhi.dilicity) forState:UIControlStateNormal];
	buttonright.imageEdgeInsets = UIEdgeInsetsMake(0, 58, 0, 0);
	buttonright.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
	[contentViewright addSubview:buttonright];
	[self.view addSubview:contentViewright];

}

#pragma mark actiondelegate
-(void)DGclickpersonlogin:(id)sender
{
	if([AddInterface judgeislogin])
	{
		[self gotowkwebview:URLInfoSetHtml URLType:URLHeader];
	}
	else
	{
        LoginViewController *login = [[LoginViewController alloc] init];
        UINavigationController *nctl  = [[UINavigationController alloc] initWithRootViewController:login];
        
        [self presentViewController:nctl animated:YES completion:nil];
	}
}

-(void)clickusermenu:(int)sender
{
	AskBrokeViewController *askbroke;
	UINavigationController *nctl;
    ApplicationMangerViewController *appmanger;
	switch (sender)
	{
		case 0://收藏
			[self gotowkwebview:URLUserCollection URLType:URLHeader];
			break;
		case 1://评论
			[self gotowkwebview:URLUserMyReview URLType:URLHeader];
			break;
		case 2://问吧
			askbroke = [[AskBrokeViewController alloc] init];
			nctl = [[UINavigationController alloc] initWithRootViewController:askbroke];
			[self.navigationController presentViewController:nctl animated:YES completion:nil];
			break;
		case 3://应用
            appmanger = [[ApplicationMangerViewController alloc] init];
            appmanger.delegate1 = self;
            UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:appmanger];
            [self.navigationController presentViewController:nctl animated:YES completion:nil];
			break;

	}
}


#pragma mark  ibaction
-(void)gotowkwebview:(NSString *)strfrom URLType:(NSString *)urltype
{
	WkWebViewCustomViewController *webviewcustom = [[WkWebViewCustomViewController alloc] init];
	NSString *str = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",strfrom,CwVersion,CwDevice,app.Gmachid,[app.userinfo.userid length]>0?app.userinfo.userid:@""];
	str = [urltype stringByAppendingString:str];
	webviewcustom.strurl = str;
	[self.navigationController pushViewController:webviewcustom animated:YES];
}


-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableviewdelegate
#pragma mark tableview 代理

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
	
	return 50;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	
	return 6;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
	[cell.contentView addSubview:imageview];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width+20, 15, 90, 20)];
	labeltitle.textColor = ColorBlackdeep;
	labeltitle.font = FONTN(16.0f);
	[cell.contentView addSubview:labeltitle];
	
	UIImageView *imageviewpoint = [[UIImageView alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x+labeltitle.frame.size.width,labeltitle.frame.origin.y+10, 4, 4)];
	imageviewpoint.backgroundColor = COLORNOW(232, 56, 22);
	imageviewpoint.layer.cornerRadius = 2;
	imageviewpoint.clipsToBounds = YES;
	
	CGSize size;
	
	switch (indexPath.row)
	{
		case 0:
			labeltitle.text = @"历史";
			imageview.image = LOADIMAGE(@"my_历史icon", @"png");
			imageview.frame = CGRectMake(20, 15, 19, 19);
			if([self getredpointflag:@"history"])
			{
				size = [AddInterface getlablesize:@"历史" Fwidth:100 Fheight:20 Sfont:FONTN(16.0f)];
				imageviewpoint.frame = CGRectMake(XYViewLeft(labeltitle)+size.width+10, XYViewTop(imageviewpoint), XYViewWidth(imageviewpoint), XYViewHeight(imageviewpoint));
				[cell.contentView addSubview:imageviewpoint];
			}
			break;
		case 1:
			labeltitle.text = @"通知";
			imageview.image = LOADIMAGE(@"my_通知icon", @"png");
			imageview.frame = CGRectMake(20, 15, 19, 19);
			if([self getredpointflag:@"notice"])
			{
				size = [AddInterface getlablesize:@"通知" Fwidth:100 Fheight:20 Sfont:FONTN(16.0f)];
				imageviewpoint.frame = CGRectMake(XYViewLeft(labeltitle)+size.width+10, XYViewTop(imageviewpoint), XYViewWidth(imageviewpoint), XYViewHeight(imageviewpoint));
				[cell.contentView addSubview:imageviewpoint];
			}
			break;
		case 2:
			labeltitle.text = @"卡券";
			imageview.image = LOADIMAGE(@"my_卡券icon", @"png");
			imageview.frame = CGRectMake(20, 15, 19, 19);
			if([self getredpointflag:@"card"])
			{
				size = [AddInterface getlablesize:@"卡券" Fwidth:100 Fheight:20 Sfont:FONTN(16.0f)];
				imageviewpoint.frame = CGRectMake(XYViewLeft(labeltitle)+size.width+10, XYViewTop(imageviewpoint), XYViewWidth(imageviewpoint), XYViewHeight(imageviewpoint));
				[cell.contentView addSubview:imageviewpoint];
			}
			break;
		case 3:
			labeltitle.text = @"购物车";
			imageview.image = LOADIMAGE(@"my_购物车icon", @"png");
			imageview.frame = CGRectMake(20, 15, 19, 19);
			if([self getredpointflag:@"cart"])
			{
				size = [AddInterface getlablesize:@"购物车" Fwidth:100 Fheight:20 Sfont:FONTN(16.0f)];
				imageviewpoint.frame = CGRectMake(XYViewLeft(labeltitle)+size.width+10, XYViewTop(imageviewpoint), XYViewWidth(imageviewpoint), XYViewHeight(imageviewpoint));
				[cell.contentView addSubview:imageviewpoint];
			}
			break;
		case 4:
			labeltitle.text = @"我的订单";
			imageview.image = LOADIMAGE(@"my_订单icon", @"png");
			imageview.frame = CGRectMake(20, 15, 19, 19);
			if([self getredpointflag:@"order"])
			{
				size = [AddInterface getlablesize:@"我的订单" Fwidth:100 Fheight:20 Sfont:FONTN(16.0f)];
				imageviewpoint.frame = CGRectMake(XYViewLeft(labeltitle)+size.width+10, XYViewTop(imageviewpoint), XYViewWidth(imageviewpoint), XYViewHeight(imageviewpoint));
				[cell.contentView addSubview:imageviewpoint];
			}
			break;
//		case 5:
//			labeltitle.text = @"活动";
//			imageview.image = LOADIMAGE(@"my_活动icon", @"png");
//			imageview.frame = CGRectMake(20, 15, 19, 19);
//			if([self getredpointflag:@"activity"])
//			{
//				size = [AddInterface getlablesize:@"活动" Fwidth:100 Fheight:20 Sfont:FONTN(16.0f)];
//				imageviewpoint.frame = CGRectMake(XYViewLeft(labeltitle)+size.width+10, XYViewTop(imageviewpoint), XYViewWidth(imageviewpoint), XYViewHeight(imageviewpoint));
//				[cell.contentView addSubview:imageviewpoint];
//			}
//			break;
		case 5:
			labeltitle.text = @"设置";
			imageview.image = LOADIMAGE(@"my_设置icon", @"png");
			imageview.frame = CGRectMake(20, 15, 19, 19);
			if([self getredpointflag:@"config"])
			{
				size = [AddInterface getlablesize:@"设置" Fwidth:100 Fheight:20 Sfont:FONTN(16.0f)];
				imageviewpoint.frame = CGRectMake(XYViewLeft(labeltitle)+size.width+10, XYViewTop(imageviewpoint), XYViewWidth(imageviewpoint), XYViewHeight(imageviewpoint));
				[cell.contentView addSubview:imageviewpoint];
			}
			break;
		default:
			break;
	}
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	SettingViewController *setting;
	switch (indexPath.row)
	{
		case 0://历史
			[self gotowkwebview:URLUserReadHistory URLType:URLHeader];
			break;
		case 1://通知
			[self gotowkwebview:URLUsernotification URLType:URLHeader];
			break;
		case 2: //卡券
			[self gotowkwebview:URLKaQuanHtml URLType:URLHeader];
			break;
		case 3://购物车
			[self gotowkwebview:URLShopCart URLType:URLShopHeader];
			break;
		case 4://我的订单
			[self gotowkwebview:URLShopOrder URLType:URLShopHeader];
			break;
//		case 5://活动
//			[self gotowkwebview:URLUserActivityList URLType:URLUserHeader];
//			break;
		case 5:
			setting = [[SettingViewController alloc] init];
			[self.navigationController pushViewController:setting animated:YES];
			break;

	}
}

-(BOOL)getredpointflag:(NSString *)strflag
{
	if([[dicuserredpoint objectForKey:strflag] isEqualToString:@"true"])
	{
		return YES;
	}
	return NO;
}
#pragma mark 接口
-(void)getUserInfo
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
    
	[RequestInterface doGetJsonWithParametersForUser:params App:app ReqUrl:InterfaceUserGetInfo ShowView:app.window alwaysdo:^{
		
	} Success:^(NSDictionary *dic) {
		DLog(@"dic====%@",dic);
		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		{
			dicuserredpoint = [dic objectForKey:@"data"];
			PersonalHeaderView *personheader = (PersonalHeaderView *)[tableview tableHeaderView];
			[personheader refreshhotred:[dic objectForKey:@"data"]];
			
			[tableview reloadData];
			
		}
		else
		{
			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
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
