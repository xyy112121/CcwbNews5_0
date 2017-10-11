//
//  WkWebViewLocationHtmlViewController.h
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UShareUI/UShareUI.h>
#import "WXApiManager.h"
#import <AVKit/AVKit.h>
@interface WkWebViewLocationHtmlViewController : UIViewController<AVPlayerViewControllerDelegate,WXApiManagerDelegate,UMSocialShareMenuViewDelegate,ActionDelegate,AVAudioPlayerDelegate,AVAudioSessionDelegate>
{
    UIButton *playButton;
    AVAudioSession *session;
    NSURL *recordedFile;
    
    AVAudioRecorder *recorder;
    NSTimer *timer;
    int timerflag;
    int audiotimesecond;
    
    int flagloading;
    
    EnNavigationFlag ennctl;
    HpNavigateView *hpna;
    EnWebViewWindowsType webviewtype;
    WKUserContentController * userContentController;
    int reloadflag;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)AppDelegate *app;
@property(nonatomic,strong)NSString *strurl;

@end
