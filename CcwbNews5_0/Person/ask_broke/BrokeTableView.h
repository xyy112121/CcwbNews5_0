//
//  BrokeTableView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/4/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTInputToolbar.h"
#import "JMSGTools.h"
@interface BrokeTableView : UIView<UITableViewDelegate,UITableViewDataSource,MTInputToolbarDelegate,ActionDelegate,AVAudioPlayerDelegate,AVAudioSessionDelegate,JMessageDelegate,UIScrollViewDelegate>
{
	UITableView *tableview;
	AppDelegate *app;
	NSMutableArray *arraydata;
	NSMutableArray *arrayheight;
	EnJMLoginStatus jmloginstatus;
	MTInputToolbar *inputtoolbar;
	UIButton *removekeyboardbutton;
}
@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic,strong)id<ActionDelegate>deletage1;
-(void)getbrokelist:(NSString *)page PageSize:(NSString *)pagesize FreshDirect:(NSString *)direct;
- (void)sendMessage:(NSString *)sender;
@end
