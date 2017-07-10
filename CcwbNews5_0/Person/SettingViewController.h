//
//  SettingViewController.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/1.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	AppDelegate *app;
	UITableView *tableview;
}

@end
