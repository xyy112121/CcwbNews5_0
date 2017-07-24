//
//  AppDelegate.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/13.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiliWeiZhi.h"
#import "UserInfo.h"
#import <JMessage/JMessageDelegate.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

static NSString *appKey = @"a9511ac380c5bf1cec9ea50f";  //测试用推送appkey
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate,JMessageDelegate,JPUSHRegisterDelegate,BMKLocationServiceDelegate,BMKGeneralDelegate,BMKGeoCodeSearchDelegate>
{
	BMKLocationService* locService;
	BMKMapManager* mapManager;
	BMKGeoCodeSearch* geocodesearch;
	
}
@property(nonatomic,strong)NSString *cwtoken;
@property (atomic) bool active;
@property(nonatomic,strong)UINavigationController *gnctl;
@property(nonatomic,strong)NSString *pushflag;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)DiliWeiZhi *diliweizhi;
@property(nonatomic,strong)UserInfo *userinfo;
@property(nonatomic,strong)NSString *Gmachid;  //machid
@property(nonatomic,strong)NSMutableArray *arrapprecommend;  //首页的应用推荐列表   用于存储首页应用推荐
@property(nonatomic,strong)NSMutableArray *arrayallapplication;
@property(nonatomic,strong)NSMutableArray *arrayaddapplication; //用户添加的应用列表
@property(nonatomic,strong)NSMutableArray *arrayfixedapplication;//表示前排固定的application
@property (assign, nonatomic)BOOL isDBMigrating;
@property (nonatomic, assign) NSInteger allowRotation;

@property(nonatomic,strong)NSString *strregiestpushid;


@end

