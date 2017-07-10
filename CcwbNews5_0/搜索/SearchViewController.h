//
//  SearchViewController.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<ActionDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	UITableView *tableview;
	NSMutableArray  *arraydata;
	NSMutableArray *arrayheight;
	NSArray *arrayhot;
	AppDelegate *app;
	int nowpage;
	UIView *viewheader;
}
@end
