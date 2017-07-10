//
//  PersonCenterViewController.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/27.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCenterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ActionDelegate>
{
	AppDelegate *app;
	UITableView *tableview;
	NSDictionary *dicuserredpoint;
}
@end
