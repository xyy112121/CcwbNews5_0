//
//  JGMSGCommon.h
//  JMessageDemo
//
//  Created by YxxxHao on 16/3/29.
//  Copyright © 2016年 HXHG. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef JMSGCommon_h
#define JMSGCommon_h

/*========================================User============================================*/
// 需要填写为您自己的 Appkey
#define JMSSAGE_APPKEY @"0172df3fcf9c44f950b00eeb"
#define CHANNEL @""

#define kuserName @"userName"

#define kPassword @"password"
#define kLogin_NotifiCation @"loginNotification"
#define kFirstLogin @"firstLogin"
#define kHaveLogin @"haveLogin"

#define kimgKey @"imgKey"
#define kmessageKey @"messageKey"
#define kupdateUserInfo @"updateUserInfo"

#define kDBMigrateStartNotification @"DBMigrateStartNotification"
#define kDBMigrateFinishNotification @"DBMigrateFinishNotification"

#define kFriendInvitationNotification @"friendInvitationNotification"

// 弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/*========================================屏幕适配============================================*/

#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue] //获得iOS版本
#define kUIWindow    [[[UIApplication sharedApplication] delegate] window] //获得window
#define kUnderStatusBarStartY (kIOSVersions>=7.0 ? 20 : 0)                 //7.0以上stautsbar不占位置，内容视图的起始位置要往下20

#define kScreenSize           [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight  (kIOSVersions>=7.0 ? [[UIScreen mainScreen] bounds].size.height + 64 : [[UIScreen mainScreen] bounds].size.height)
#define kIOS7OffHeight (kIOSVersions>=7.0 ? 64 : 0)

#define kApplicationSize      [UIScreen mainScreen].bounds.size       //(e.g. 320,460)
#define kApplicationWidth     [UIScreen mainScreen].bounds.size.width //(e.g. 320)
#define kApplicationHeight    [UIScreen mainScreen].bounds.size.height//不包含状态bar的高度(e.g. 460)

#define kStatusBarHeight         20
#define kNavigationBarHeight     44
#define kNavigationheightForIOS7 64
#define kContentHeight           (kApplicationHeight - kNavigationBarHeight)
#define kTabBarHeight            49
#define kTableRowTitleSize       14
#define maxPopLength             170

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,alp) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(alp)]

#define UIColorFromRGB(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue) [UIColor  colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.7]

#define kNavigationBarColor    UIColorFromRGB(0x3f80de)
#define headDefaltWidth             46
#define headDefaltHeight            46
#define upLoadImgWidth            720

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

// UI 相关
#define JMSG_UIIMAGE(_FILE_)          ([UIImage imageNamed:(_FILE_)])
#define JMSG_CLEARCOLOR               ([UIColor clearColor])
#define JMSG_FONTSIZE(_SIZE_)         ([UIFont systemFontOfSize:_SIZE_])

// View的right、left、bottom、top、width、height
#define JMSG_ViewRight(View)              (View.frame.origin.x + View.frame.size.width)
#define JMSG_ViewLeft(View)               (View.frame.origin.x)
#define JMSG_ViewBottom(View)             (View.frame.origin.y + View.frame.size.height)
#define JMSG_ViewTop(View)                (View.frame.origin.y)
#define JMSG_ViewWidth(View)              (View.frame.size.width)
#define JMSG_ViewHeight(View)             (View.frame.size.height)


// 版本大于iOS7
#define     IOS7_OR_HIGHER         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define     IOS8_OR_HIGHER         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define     IOS8_3_OR_HIGHER       ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3f)
#define     IOS9_0_OR_HIGHER       ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)

//GCD
#define JMSGMAINTHREAD(block) dispatch_async(dispatch_get_main_queue(), block)

#endif
