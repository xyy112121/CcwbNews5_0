//
//  ApplicationMangerViewController.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ApplicationMangerViewController.h"

@interface ApplicationMangerViewController ()

@end

@implementation ApplicationMangerViewController
@synthesize popflag;

-(void)returnback:(id)sender
{
	if(changeflag == 1)
	{
		[self donecommit:sender];
	}
	else
	{
		[self.navigationController dismissViewControllerAnimated:YES completion:nil];
	}
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
		self.edgesForExtendedLayout = UIRectEdgeNone;
	}
//	self.navigationController.navigationBar.translucent = NO;
//	[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//	self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
	self.view.backgroundColor = COLORNOW(237, 237, 237);
	
	self.title = @"应用管理";
	
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	[button setImage:LOADIMAGE(@"arrowleftred", @"png") forState:UIControlStateNormal];
	button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	
//	UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
//	UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
//	buttonright.titleLabel.font = FONTN(16.0f);
//	[buttonright setTitleColor:COLORNOW(50, 50, 50) forState:UIControlStateNormal];
//	[buttonright setTitle:@"完成" forState:UIControlStateNormal];
//	[buttonright addTarget:self action: @selector(donecommit:) forControlEvents: UIControlEventTouchUpInside];
//	[contentViewright addSubview:buttonright];
//	UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
//	self.navigationItem.rightBarButtonItem = barButtonItemright;
	
	
	[self initparament:nil];
	
	// Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated
{
	
}

-(void)viewWillAppear:(BOOL)animated
{
	app.gnctl = self.navigationController;
}


-(void)initparament:(id)sender
{
	[self setNeedsStatusBarAppearanceUpdate];
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	changeflag = 0;
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor whiteColor];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.delegate = self;
	tableview.dataSource = self;
	[self setExtraCellLineHidden:tableview];
	[self.view addSubview:tableview];
//	self.tableview.delegate = self;
//	self.tableview.dataSource = self;
//	[self.tableview reloadData];
	[self initview:nil];
	
	arraynowapplication = [[NSMutableArray alloc] init];
	for(int i=0;i<[app.arrayaddapplication count];i++)
	{
		NSDictionary *dictemp = [app.arrayaddapplication objectAtIndex:i];
		if(![[dictemp objectForKey:@"type"] isEqualToString:@"sys"])
		{
			[arraynowapplication addObject:dictemp];
		}
	}
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
											   initWithTarget:self action:@selector(longPressGestureRecognized:)];
	[tableview addGestureRecognizer:longPress];
}

-(void)initview:(id)sender
{
	
}

-(void)donecommit:(id)sender
{
	for(int i=0;i<[arraynowapplication count];i++)
	{
		NSMutableDictionary *dictemp = [arraynowapplication objectAtIndex:i];
		[dictemp setObject:[NSString stringWithFormat:@"%d",i] forKey:@"sort_index"];
	}
	
	NSData *jsonData = [NSJSONSerialization
						dataWithJSONObject:arraynowapplication options:NSJSONWritingPrettyPrinted error:nil];
	NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
	[self commitchangesort:app.Gmachid AppJson:jsonString];
}

//长按手势方法
- (void)longPressGestureRecognized:(id)sender {
	
	UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
	UIGestureRecognizerState state = longPress.state;
	
	CGPoint location = [longPress locationInView:tableview];
	NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:location];
	
	static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
	static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
	
	switch (state) {
		case UIGestureRecognizerStateBegan: {
			if (indexPath) {
				sourceIndexPath = indexPath;
				
				UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexPath];
				
				
				// Take a snapshot of the selected row using helper method.
				snapshot = [self customSnapshotFromView:cell];
				
				// Add the snapshot as subview, centered at cell's center...
				__block CGPoint center = cell.center;
				snapshot.center = center;
				snapshot.alpha = 0.0;
				[tableview addSubview:snapshot];
				[UIView animateWithDuration:0.25 animations:^{
					
					// Offset for gesture location.
					center.y = location.y;
					snapshot.center = center;
					snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
					snapshot.alpha = 0.98;
					
					// Black out.
					cell.backgroundColor = COLORNOW(240, 240, 240);
				} completion:nil];
			}
			break;
		}
		case UIGestureRecognizerStateChanged: {
			
			changeflag = 1;
			
			CGPoint center = snapshot.center;
			center.y = location.y;
			snapshot.center = center;
			
			// Is destination valid and is it different from source?
			if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
				
				// ... update data source.
				[arraynowapplication exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
				
				// ... move the rows.
				[tableview moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
				
				// ... and update source so it is in sync with UI changes.
				sourceIndexPath = indexPath;
				
			}
			break;
		}
		default: {
			// Clean up.
			UITableViewCell *cell = [tableview cellForRowAtIndexPath:sourceIndexPath];
			[UIView animateWithDuration:0.25 animations:^{
				
				snapshot.center = cell.center;
				snapshot.transform = CGAffineTransformIdentity;
				snapshot.alpha = 0.0;
				
				// Undo the black-out effect we did.
				cell.backgroundColor = [UIColor whiteColor];
				
			} completion:^(BOOL finished) {
				
				[snapshot removeFromSuperview];
				snapshot = nil;
				
			}];
			sourceIndexPath = nil;
			break;
		}
	}
	// More coming soon...
}

- (UIView *)customSnapshotFromView:(UIView *)inputView {
	
	UIView *snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
	snapshot.layer.masksToBounds = NO;
	snapshot.layer.cornerRadius = 0.0;
	snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
	snapshot.layer.shadowRadius = 5.0;
	snapshot.layer.shadowOpacity = 0.4;
	
	return snapshot;
}

#pragma mark tableview delegate

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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,40)];
	view.backgroundColor = [UIColor clearColor];
	
	UILabel *labhot = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 20)];
	labhot.text = @"我的应用";
	labhot.font = FONTN(15.0f);
	labhot.textColor = COLORNOW(51, 51, 51);
	[view addSubview:labhot];
	
	UILabel *labsum = [[UILabel alloc] initWithFrame:CGRectMake(labhot.frame.origin.x+labhot.frame.size.width, labhot.frame.origin.y, 120, 20)];
	labsum.text = @"(长按      可排序)";
	labsum.font = FONTN(15.0f);
	labsum.textAlignment = NSTextAlignmentCenter;
	labsum.textColor = COLORNOW(128, 128, 128);
	[view addSubview:labsum];
	
	UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(labsum.frame.origin.x+42, labsum.frame.origin.y+7, 19, 8)];
	imageviewline.image = LOADIMAGE(@"三横线", @"png");
	[view addSubview:imageviewline];
	
	UIImageView *imageviewline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,view.frame.size.height, SCREEN_WIDTH, 0.5)];
	imageviewline1.backgroundColor = COLORNOW(220,220, 220);
	[view addSubview:imageviewline1];
	
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	
	return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [arraynowapplication count];
	
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
	
	NSDictionary *dictemp = [arraynowapplication objectAtIndex:indexPath.row];
	
	UIImageView *appheader = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
	appheader.backgroundColor = [UIColor clearColor];
	appheader.clipsToBounds = YES;
	appheader.layer.cornerRadius = 4;
	[appheader setImageWithURL:[NSURL URLWithString:[dictemp objectForKey:@"logo_pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
	[cell.contentView addSubview:appheader];
	
	UILabel *labtitle = [[UILabel alloc] initWithFrame:CGRectMake(appheader.frame.origin.x+appheader.frame.size.width+10,appheader.frame.origin.y+15, 100, 20)];
	labtitle.text = [dictemp objectForKey:@"name"];
	labtitle.font = FONTN(15.0f);
	labtitle.textColor = [UIColor blackColor];
	[cell.contentView addSubview:labtitle];
	
	
	UIButton *buttonadd = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonadd.layer.borderColor = [UIColor clearColor].CGColor;
	buttonadd.frame = CGRectMake(SCREEN_WIDTH-90, 20, 40, 40);
	[buttonadd setBackgroundColor:[UIColor clearColor]];
	[buttonadd setImage:LOADIMAGE(@"删除app", @"png") forState:UIControlStateNormal];
	buttonadd.tag = 300+indexPath.row;
	[buttonadd addTarget:self action:@selector(clickdeleteapp:) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:buttonadd];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 25, 1, 30)];
	imageline.backgroundColor = COLORNOW(200, 200, 200);
	[cell.contentView addSubview:imageline];
	
	UIImageView *imagesanheng = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 36, 19, 8)];
	imagesanheng.image = LOADIMAGE(@"三横线", @"png");
	[cell.contentView addSubview:imagesanheng];
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *dictemp = [arraynowapplication objectAtIndex:indexPath.row];
	if([self.delegate1 respondsToSelector:@selector(openapplication:)])
	{
		[self.delegate1 openapplication:dictemp];
		[self.navigationController dismissViewControllerAnimated:NO completion:nil];
	}
}

-(void)clickdeleteapp:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-300;
	
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定删除此应用" preferredStyle: UIAlertControllerStyleAlert];
 
	[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		//点击按钮的响应事件；
		
	}]];
	
	[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		//点击按钮的响应事件；
		NSDictionary *dictemp = [arraynowapplication objectAtIndex:tagnow];
		[self clickuserdeletelication:dictemp];
	}]];
	
	
 
	//弹出提示框；
	[self presentViewController:alert animated:true completion:nil];
	
	
	
}

#pragma mark deleteapp
-(void)clickuserdeletelication:(NSDictionary *)sender
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_app_id"] = [sender objectForKey:@"id"];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceDeleteApp ShowView:app.window alwaysdo:^
	 {
		 
	 }
		 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {

			 if([self.delegate1 respondsToSelector:@selector(DGclickAddAppMachine:)])
			 {
				[app.arrayaddapplication removeObject:sender];
				 [arraynowapplication removeObject:sender];
				[self.delegate1 DGclickAddAppMachine:sender];
				 [tableview reloadData];
			 }
		 }
		 else
		 {
			 
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
	 }];
	
}


-(void)commitchangesort:(NSString *)sender AppJson:(NSString *)appjson
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_appList"] = appjson;
	DLog(@"appjson====%@",appjson);
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceSortApp ShowView:app.window alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 app.arrayaddapplication = [[NSMutableArray alloc] initWithArray: [dic objectForKey:@"appList"]];
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
			 [self.navigationController dismissViewControllerAnimated:YES completion:nil];
		 }
		 else
		 {
			 
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 }Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
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
