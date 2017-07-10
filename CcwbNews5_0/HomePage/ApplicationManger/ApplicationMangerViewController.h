//
//  ApplicationMangerViewController.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXCardSwitchView.h"
@interface ApplicationMangerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	AppDelegate *app;
	NSMutableArray *arraynowapplication;
	UITableView *tableview;
	int changeflag;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *popflag;

@end
