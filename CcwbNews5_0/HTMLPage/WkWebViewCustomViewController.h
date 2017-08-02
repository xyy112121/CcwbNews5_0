//
//  WkWebViewCustomViewController.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UShareUI/UShareUI.h>
#import "WXApiManager.h"
#import <AVKit/AVKit.h>
@interface WkWebViewCustomViewController : UIViewController<AVPlayerViewControllerDelegate,WXApiManagerDelegate,UMSocialShareMenuViewDelegate,ActionDelegate,AVAudioPlayerDelegate,AVAudioSessionDelegate>
{
	UIButton *playButton;
	AVAudioSession *session;
	NSURL *recordedFile;
	
	AVAudioRecorder *recorder;
	NSTimer *timer;
	int timerflag;
	int audiotimesecond;
	
	int flagloading;
	
    NSDictionary *dicdata;
    
	EnNavigationFlag ennctl;
	HpNavigateView *hpna;
	EnWebViewWindowsType webviewtype;
	WKUserContentController * userContentController;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)AppDelegate *app;
@property(nonatomic,strong)NSString *strurl;
@property(nonatomic,strong)NSString *strtitle;
@end
