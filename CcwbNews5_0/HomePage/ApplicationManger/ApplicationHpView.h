//
//  ApplicationHpView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/7/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationHpView : UIView<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
	AppDelegate *app;
    UITableView *tableview;
    NSMutableArray *arrayheight;
    NSMutableArray *arraydata;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
