//
//  HomePageViewController.h
//  CcwbNews
//
//  Created by xyy520 on 16/4/27.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomView.h"
#import "OpenGLView.h"
@interface HomePageViewController : UIViewController<ActionDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UIScrollView *scrollviewbg;
	AppDelegate *app;
	BottomView *bottomview;
	NSMutableArray *arraydata;
	int repatcount;
	EnTypeFunctionFoled entypefoled;
	NSString *SelectedApp;  //当前 选择的哪个应用的ID
	
	NSArray *arrayappchannellist;
	NSArray *arrayfocuschannellist;
	
	
	NSMutableArray *arrayheight;
	NSArray *arrayneed;
	NSArray *photourls;
	NSDictionary *dicadver;
	NSMutableArray *arrayactivity;
	NSDictionary *dicactivity;
	NSString *strlastappid;
	NSTimer *timerad; //广告定时器
	UITableView *tableview;
	NSMutableArray *arrayapplicationfirstin;//记录每个app是不是第一次进入
	
	NSString *strcw_time;
	int nowpage;
	
}
//@property(nonatomic, strong) OpenGLView *glView;

@property(nonatomic,strong,nonnull)NSString *strchannelid;
@property (nonatomic, assign) CGFloat topContentInset;
@property (nonatomic, assign) CGFloat alphaMemory;
@property (nonatomic, assign) BOOL statusBarStyleControl;
@end
