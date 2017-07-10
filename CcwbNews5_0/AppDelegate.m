//
//  AppDelegate.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize diliweizhi;
@synthesize userinfo;
@synthesize allowRotation;
-(void)configUSharePlatforms
{
	[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
	//设置用户自定义的平台
	/* 设置微信的appKey和appSecret */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx40e15e8bcce18854" appSecret:@"0269aebaa2a77888d93fbb353776f342" redirectURL:@"http://mobile.umeng.com/social"];
	
	/* 设置分享到QQ互联的appID
	 * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
	 */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1101463256"  appSecret:@"ujIK1wAbhkZofcUs" redirectURL:@"http://mobile.umeng.com/social"];
	
	/* 设置新浪的appKey和appSecret */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"853638293"  appSecret:@"85e79e5c8d10ebaca8ec13a27cc4f4ce" redirectURL:@"http://sns.whalecloud.com"];
}

-(void)initJPush:(NSDictionary *)launchOptions
{
	JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
	entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
	if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//		//可以添加自定义categories
//		[JMessage registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//													  UIUserNotificationTypeSound |
//													  UIUserNotificationTypeAlert)
//										  categories:nil];
//	} else {
//		//categories 必须为nil
//		[JMessage registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//													  UIRemoteNotificationTypeSound |
//													  UIRemoteNotificationTypeAlert)
//										  categories:nil];
	}
	[JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
	[JPUSHService setupWithOption:launchOptions appKey:appKey
						  channel:channel
				 apsForProduction:isProduction
			advertisingIdentifier:nil];
	
	[JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
		if(resCode == 0){
			NSLog(@"registrationID获取成功：%@",registrationID);
			self.strregiestpushid =registrationID; //[self updatajpushregiestid:registrationID];
		}
		else{
			NSLog(@"registrationID获取失败，code：%d",resCode);
		}
	}];
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

-(void)initdiliweizhi
{
	diliweizhi = [[DiliWeiZhi alloc] init];
	diliweizhi.dilicity = @"昆明市";
	diliweizhi.diliprovince = @"云南省";
	diliweizhi.dililocality = @"区";
	diliweizhi.latitude = 25.0678253;
	diliweizhi.longitude = 102.8522135;
	
	NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
	NSDictionary *userdic = [userDefaultes dictionaryForKey:DefaultUserInfo];
	DLog(@"userdic====%@",userdic);
	userinfo = [[UserInfo alloc] init];
	userinfo.userid = [userdic objectForKey:@"userid"];
	userinfo.username =   [userdic objectForKey:@"username"];
	userinfo.userheader =  [userdic objectForKey:@"head_pic_path"];
	userinfo.usertel =  [userdic objectForKey:@"usertel"];
	userinfo.userstate = [userdic objectForKey:@"userstate"];

	
	self.arrapprecommend = [[NSMutableArray alloc] init];
	self.arrayfixedapplication= [[NSMutableArray alloc] init];
}

-(void)initJMessage:(NSDictionary *)launchOptions
{
	[JMessage addDelegate:self withConversation:nil];
	
	[JMessage setupJMessage:launchOptions
					 appKey:JMSSAGE_APPKEY
					channel:CHANNEL
		   apsForProduction:NO
				   category:nil
			 messageRoaming:NO];
}

-(void)initGmachineid
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *machdic = [userDefaults stringForKey:@"machid"];
	if([machdic length]>0)
	{
		self.Gmachid = machdic;
	}
	else
	{
		NSString *machid = [[UIDevice currentDevice] uniqueDeviceIdentifier];
		self.Gmachid = machid;
		[userDefaults setObject:machid forKey:@"machid"];
		[userDefaults synchronize];
		
	}
	
	
	if(self.Gmachid!=nil)
	{
		
	}
	else
	{
		NSString *machid = [[UIDevice currentDevice] uniqueDeviceIdentifier];
		self.Gmachid = machid;
		[userDefaults setObject:machid forKey:@"machid"];
		[userDefaults synchronize];
	}
	DLog(@"self.Gmachid=======================%@",self.Gmachid);
}



-(void)getnowlocation
{
	mapManager = [[BMKMapManager alloc]init];
//	BOOL ret = [mapManager start:@"1Y6apm4xkxQ9AGPmfSR46Qb9gC4wfUYG" generalDelegate:self];  //正式版
	BOOL ret = [mapManager start:@"NpYiW5bMxqS9caPfLs7l95BcFA3Rae4M" generalDelegate:self];  //测试版本
	
	if (!ret) {
		NSLog(@"manager start failed!");
	}
	locService = [[BMKLocationService alloc]init];
	geocodesearch = [[BMKGeoCodeSearch alloc]init];
	locService.delegate = self;
	geocodesearch.delegate = self;
	[locService startUserLocationService];
	
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	//初始化machineid
	[self initGmachineid];
	
	//初始化地理位置
	[self initdiliweizhi];
	
	//地理位置定位
	[self getnowlocation];
	
	//极光IM JMessage
//	[self initJMessage:launchOptions];
	//极光推送
	[self initJPush:launchOptions];
	//友盟分享
	/* 设置友盟appkey */
	[[UMSocialManager defaultManager] setUmSocialAppkey:TYUMKey];
	[self configUSharePlatforms];
	//微信支付
	 [WXApi registerApp:@"wx40e15e8bcce18854" withDescription:@"ios wxpay"];
	

	
	
	self.allowRotation = 0;
	CGRect rect = [[UIScreen mainScreen] bounds];
	self.window = [[UIWindow alloc] initWithFrame:rect];
	self.window.backgroundColor = [UIColor whiteColor];
	HomePageViewController *homepage = [[HomePageViewController alloc] init];
	UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:homepage];
	self.window.rootViewController = nctl;
	self.gnctl = nctl;
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:[NSString stringWithFormat:@"%.1f",time] forKey:TYNowTime];
	[userDefaults synchronize];
	DLog(@"time_background====%f",time);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	_active = true;
	NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSString *timenow = [userDefaults stringForKey:TYNowTime];
	DLog(@"time_Foreground====%f,%d,%f",time,[timenow intValue],time-[timenow intValue]);
	if((time-[timenow floatValue]>60*30)&&[timenow intValue]>1494316000)
	{
		HomePageViewController *homepage = [[HomePageViewController alloc] init];
		UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:homepage];
		self.window.rootViewController = nctl;
		self.gnctl = nctl;
		[self.window makeKeyAndVisible];
	}
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	_active = false;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	(void)application;
	_active = false;
}

#pragma mark 横屏处理
//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//	if (ISIPAD) {
//		return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
//	} else {
//		return UIInterfaceOrientationMaskPortrait;
//	}
//}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)nowWindow {
	
	//    是非支持横竖屏
	
	if (self.allowRotation==1) {
		
		return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskPortrait;
		
	} else{
		
		return UIInterfaceOrientationMaskPortrait;
		
	}
	
}


#pragma mark JMessage
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
	[JMessage registerDeviceToken:deviceToken];
	[JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
	DLog(@"error===%@",error);
}


#pragma mark - JMessageDelegate
- (void)onDBMigrateStart {
	NSLog(@"onDBmigrateStart in appdelegate");
	_isDBMigrating = YES;
}

- (void)onDBMigrateFinishedWithError:(NSError *)error {
	NSLog(@"onDBmigrateFinish in appdelegate");
	_isDBMigrating = NO;
	[[NSNotificationCenter defaultCenter] postNotificationName:kDBMigrateFinishNotification object:nil];
}

- (void)onReceiveNotificationEvent:(JMSGNotificationEvent *)event{
	SInt32 eventType = (JMSGEventNotificationType)event.eventType;
	switch (eventType) {
		case kJMSGEventNotificationReceiveFriendInvitation:
		case kJMSGEventNotificationAcceptedFriendInvitation:
		case kJMSGEventNotificationDeclinedFriendInvitation:
		case kJMSGEventNotificationDeletedFriend:
		{
			//JMSGFriendNotificationEvent *friendEvent = (JMSGFriendNotificationEvent *)event;
			NSLog(@"Friend Notification Event");
			[[NSNotificationCenter defaultCenter] postNotificationName:kFriendInvitationNotification object:event];
		}
			break;
		case kJMSGEventNotificationReceiveServerFriendUpdate:
			NSLog(@"Receive Server Friend update Notification Event");
			break;
			
			
		case kJMSGEventNotificationLoginKicked:
			NSLog(@"LoginKicked Notification Event ");
		case kJMSGEventNotificationServerAlterPassword:{
			if (event.eventType == kJMSGEventNotificationServerAlterPassword) {
				NSLog(@"AlterPassword Notification Event ");
			}
		case kJMSGEventNotificationUserLoginStatusUnexpected:
			if (event.eventType == kJMSGEventNotificationServerAlterPassword) {
				NSLog(@"User login status unexpected Notification Event ");
			}
			
		}
			break;
			
		default:
			break;
	}
}

#pragma mark 推送处理
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
	// Required
	NSDictionary * userInfo = notification.request.content.userInfo;
	DLog(@"cccccc===%@",userInfo);
	if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
		[JPUSHService handleRemoteNotification:userInfo];
	}
	completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support  //程序 在后台的时候调用此函数
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
	// Required
	NSDictionary * userInfo = response.notification.request.content.userInfo;
	DLog(@"bbbbbbbb===%@",userInfo);
	if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
		[JPUSHService handleRemoteNotification:userInfo];
	}
	completionHandler();  // 系统要求执行这个方法
	
	[self getjpushinfo:[userInfo objectForKey:@"cw_id"] cwtype:[userInfo objectForKey:@"cw_type"]];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
	
	// Required, iOS 7 Support
	[JPUSHService handleRemoteNotification:userInfo];
	DLog(@"saaaaaa===%@",userInfo);
	completionHandler(UIBackgroundFetchResultNewData);
//	if([self.pushflag isEqualToString:@"1"])
//	{
//		NSString *urlnow = [URLHeader stringByAppendingString:[userInfo objectForKey:@"url"]];
//		urlnow = [URLHeader stringByAppendingString:[userInfo objectForKey:@"url"]];
//		urlnow = [urlnow stringByAppendingString:[NSString stringWithFormat:@"&user_id=%@",self.struserid]];
//		PushDetailView *newsweb = [[PushDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Urlstr:urlnow];
//		newsweb.tag = 98890;
//		[self.window addSubview:newsweb];
//	}
//	else
//	{
//		self.pushflag = @"0";
//		self.strpushurl = [URLHeader stringByAppendingString:[userInfo objectForKey:@"url"]];
//	}
	
	
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
	// Required,For systems with less than or equal to iOS6
	[JPUSHService handleRemoteNotification:userInfo];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
	//6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
	BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
	//6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
	if (!result) {
		result = [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];

		// 其他如支付等SDK的回调
	}
	return result;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
	if (!result) {
		result = [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
		// 其他如支付等SDK的回调
	}
	return result;
}

#pragma mark 地图
/**
 *在地图View将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
	NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
	
	NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
	NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
	[locService stopUserLocationService];
	[self onClickReverseGeocode:userLocation.location.coordinate.latitude CoordinateX:userLocation.location.coordinate.longitude];
	
	diliweizhi.latitude = userLocation.location.coordinate.latitude;
	diliweizhi.longitude = userLocation.location.coordinate.longitude;
}

/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
	NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
	
	NSLog(@"location error");
//	[self updatalocation];
}

-(void)onClickReverseGeocode:(float)coordinatey CoordinateX:(float)coordinatex
{
	CLLocationCoordinate2D pt = (CLLocationCoordinate2D){coordinatey, coordinatex};
	BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
	reverseGeocodeSearchOption.reverseGeoPoint = pt;
	BOOL flag = [geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
	if(flag)
	{
		NSLog(@"反geo检索发送成功");
	}
	else
	{
		NSLog(@"反geo检索发送失败");
//		[MBProgressHUD showError:@"你没有开启定位信息,将为你显示默认城市信息！" toView:self.window];
	}
	
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
	if (error == 0) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
		item.coordinate = result.location;
		item.title = result.address;
		NSString* titleStr;
		NSString* showmeg;
		titleStr = @"反向地理编码";
		showmeg = [NSString stringWithFormat:@"%@",item.title];
		
		
		
		diliweizhi.dilicity = result.addressDetail.city;
		diliweizhi.diliprovince = result.addressDetail.province;
		diliweizhi.dililocality =  result.addressDetail.district;
		diliweizhi.diliroad = result.addressDetail.streetName;
		diliweizhi.dilinumber = result.addressDetail.streetNumber;
		diliweizhi.latitude = result.location.latitude;
		diliweizhi.longitude = result.location.longitude;
//		[self updatalocation];
		DLog(@"≈====%@,%@,%@,%@,%@,%f,%f",result.addressDetail.streetNumber,result.addressDetail.streetName,result.addressDetail.district,result.addressDetail.city,result.addressDetail.province,diliweizhi.latitude,diliweizhi.longitude);
		
	}
}

- (void)onGetNetworkState:(int)iError
{
	if (0 == iError) {
		NSLog(@"联网成功");
	}
	else{
		NSLog(@"onGetNetworkState %d",iError);
	}
	
}

- (void)onGetPermissionState:(int)iError
{
	if (0 == iError) {
		NSLog(@"授权成功");
	}
	else {
		NSLog(@"onGetPermissionState %d",iError);
	}
}



#pragma mark 接口
-(void)gotowkwebview:(NSString *)str
{
	WkWebViewCustomViewController *webviewcustom = [[WkWebViewCustomViewController alloc] init];
	NSString *requeststring = str;
	if([requeststring rangeOfString:@"?"].location !=NSNotFound)
	{
		requeststring = [NSString stringWithFormat:@"%@&cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requeststring,CwVersion,CwDevice,self.Gmachid,self.userinfo.userid!=nil?self.userinfo.userid:@""];
	}
	else
	{
		requeststring = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requeststring,CwVersion,CwDevice,self.Gmachid,self.userinfo.userid!=nil?self.userinfo.userid:@""];
	}
	webviewcustom.strurl = requeststring;
	[self.gnctl pushViewController:webviewcustom animated:YES];
}

-(void)getjpushinfo:(NSString *)cwid cwtype:(NSString *)cwtype
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_id"] = cwid;
	params[@"cw_type"] = cwtype;//第一次的时候传1 ,以后传0
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:self ReqUrl:Interfacegetjpushinfo ShowView:self.window alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [self gotowkwebview:[dic objectForKey:@"url"]];
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:self.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.window];
	 }];
	
}



@end
