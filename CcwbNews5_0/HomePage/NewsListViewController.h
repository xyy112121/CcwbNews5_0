//
//  NewsListViewController.h
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
  
    AppDelegate *app;
    NSMutableArray *arraydata;
    NSMutableArray *arrayheight;
    UITableView *tableview;

    
    NSString *strcw_time;
    int nowpage;
}
@property(nonatomic,strong)NSString *fccw_type;
@end
