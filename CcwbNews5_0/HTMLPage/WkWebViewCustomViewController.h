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
@interface WkWebViewCustomViewController : UIViewController<AVPlayerViewControllerDelegate,WXApiManagerDelegate,UMSocialShareMenuViewDelegate,ActionDelegate,AVAudioPlayerDelegate,AVAudioSessionDelegate,CLBottomCommentViewDelegate,UIScrollViewDelegate>
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
    
    //发表评论调用原生评论时需要使用
    NSString *strnewsid;
}

@property (nonatomic, strong) CLBottomCommentView *bottomView;
@property(nonatomic,strong)NSString *fromaskorother;//来自ask的话导航栏的回退按钮用白色 其余用红色
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)AppDelegate *app;
@property(nonatomic,strong)NSString *strurl;
@property(nonatomic,strong)NSString *strtitle;
@property(nonatomic,strong)NSString *FCfromintype;
@property(nonatomic,strong)NSString *FCnewsid;
@end
