//
//  SettingViewController.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

-(void)returnback
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
	app.gnctl = self.navigationController;
	[self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
	self.view.backgroundColor = COLORNOW(237, 237, 237);
	
	
	
	UIImageView *imagenctl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
	imagenctl.backgroundColor = COLORNOW(253, 253, 253);
	[self.view addSubview:imagenctl];
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(100,32,SCREEN_WIDTH-200,20)];
	labeltitle.font = FONTB(16.0f);
	labeltitle.text = @"设置";
	labeltitle.textAlignment = NSTextAlignmentCenter;
	labeltitle.backgroundColor = [UIColor clearColor];
	labeltitle.textColor = COLORNOW(48, 48, 48);
	[self.view addSubview:labeltitle];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
	imageline.backgroundColor = COLORNOW(230, 230, 230);
	[self.view addSubview:imageline];
	
	//返回按钮
	UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
	btreturn.layer.borderColor = [UIColor clearColor].CGColor;
	btreturn.frame = CGRectMake(10, 22, 40, 40);
	[btreturn setImage:LOADIMAGE(@"arrowleftred", @"png") forState:UIControlStateNormal];
	[btreturn addTarget:self action:@selector(returnback) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btreturn];
	
	[self initparament:nil];
	
	// Do any additional setup after loading the view.
}

-(void)initparament:(id)sender
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self setExtraCellLineHidden:tableview];
	[self.view addSubview:tableview];
	
	[self initfootview:nil];
	
}


-(void)initfootview:(id)sender
{
	UIView *viewfoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
	viewfoot.backgroundColor = [UIColor clearColor];
	tableview.tableFooterView = viewfoot;
	
	UIButton *buttonlogout = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonlogout.layer.borderColor = [UIColor clearColor].CGColor;
	buttonlogout.frame = CGRectMake(15, 20, SCREEN_WIDTH-30, 40);
	[buttonlogout setBackgroundColor:COLORNOW(232, 56, 47)];
	buttonlogout.titleLabel.font = FONTN(17.0f);
	buttonlogout.layer.cornerRadius = 5.0f;
	buttonlogout.clipsToBounds = YES;
	[buttonlogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[buttonlogout setTitle:@"登出" forState:UIControlStateNormal];
	[buttonlogout addTarget:self action:@selector(clicklogout:) forControlEvents:UIControlEventTouchUpInside];
	[viewfoot addSubview:buttonlogout];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
	imageview.image = LOADIMAGE(@"my_春城晚报logo", @"png");
	imageview.center = CGPointMake(SCREEN_WIDTH/2, buttonlogout.frame.size.height+buttonlogout.frame.origin.y+60);
	[viewfoot addSubview:imageview];
	
	NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
	NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageview.frame.origin.x,imageview.frame.origin.y+imageview.frame.size.height+5,imageview.frame.size.width,20)];
	labelname.font = FONTN(16.0f);
	labelname.text = currentVersion;
	labelname.textAlignment = NSTextAlignmentCenter;
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = COLORNOW(148, 148, 148);
	[viewfoot addSubview:labelname];
}

-(void)clicklogout:(id)sender
{
//	app.userinfo.userstate = @"0";
//	NSDictionary *userdic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:app.userinfo.userid, app.userinfo.username,app.userinfo.userpermission,app.userinfo.userheader,app.userinfo.usertel,@"0", nil] forKeys:[NSArray arrayWithObjects:@"userid", @"username", @"userpermission", @"userheader", @"usertel", @"userstate", nil]];
//	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//	[userDefaults setObject:userdic forKey:DefaultUserInfo];
//	[userDefaults synchronize];
//	
//	NSUserDefaults *userDefaultestemp = [NSUserDefaults standardUserDefaults];
//	NSDictionary *userdictemp = [userDefaultestemp dictionaryForKey:DefaultUserInfo];
//	DLog(@"userdic====%@",userdictemp);
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:DefaultUserInfo];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[self.navigationController popToRootViewControllerAnimated:YES];
	app.userinfo.userheader = @"";
	app.userinfo.userid = @"";
}

#pragma mark tableview 代理
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
	UIView *view = [UIView new];
	view.backgroundColor = [UIColor clearColor];
	[tableView setTableFooterView:view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//	if(indexPath.section == 2)
	return 40;
	//	return 5;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	if(section == 2)
		return 3;
	return 1;
	
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
	
	cell.backgroundColor = [UIColor whiteColor];
	
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20,10,200,20)];
	labelname.font = FONTN(16.0f);
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = COLORNOW(48, 48, 48);
	[cell.contentView addSubview:labelname];
	
	UILabel *labelcache = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 5, 80, 30)];
	labelcache.font = FONTN(16.0f);
	labelcache.backgroundColor = [UIColor clearColor];
	labelcache.textAlignment = NSTextAlignmentRight;
	labelcache.textColor = COLORNOW(48, 48, 48);
	
	
	LQXSwitch *swit2 = [[LQXSwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 5, 60, 30) onColor:COLORNOW(232, 56, 47) offColor:COLORNOW(230, 230, 230) font:[UIFont systemFontOfSize:15] ballSize:22];
	swit2.onText = @"开";
	swit2.offText = @"关";
	swit2.on = YES;
	switch (indexPath.section)
	{
		case 0:
			labelname.text = @"推送通知";
			[cell.contentView addSubview:swit2];
			[swit2 addTarget:self action:@selector(switchSex:) forControlEvents:UIControlEventTouchUpInside];
			break;
		case 1:
			//			labelcache.text = @"12.4M";
			[cell.contentView addSubview:labelcache];
			labelname.text = @"清除缓存";
			break;
		case 2:
			switch (indexPath.row)
		{
			case 0:
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				labelname.text = @"账号管理";
				break;
			case 1:
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				labelname.text = @"应用分享";
				break;
			case 2:
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				labelname.text = @"意见反馈";
				break;
			case 3:
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				labelname.text = @"AR测试";
				break;
				
		}
			break;
			
	}
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
}

-(void)clickdeletebroke:(id)sender
{
	
	float floatsize = [AddInterface folderSizeAtPath:Cache_path];
	float floatdocment = [AddInterface folderSizeAtPath:DOCUMENTS_FOLDER];
	float floattmp = [AddInterface folderSizeAtPath:Tmp_path];
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"你需要清除的缓存大小约为%0.1f M",floatsize+floatdocment+floattmp] message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		
	}];
	
	UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		[AddInterface clearCache:Cache_path];
		[AddInterface clearCache:DOCUMENTS_FOLDER];
		[AddInterface clearCache:Tmp_path];
		[MBProgressHUD showError:@"已清除" toView:self.view];
	}];
	
	// Add the actions.
	[alertController addAction:cancelAction];
	[alertController addAction:otherAction];
	
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)switchSex:(LQXSwitch *)swit
{
	
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
