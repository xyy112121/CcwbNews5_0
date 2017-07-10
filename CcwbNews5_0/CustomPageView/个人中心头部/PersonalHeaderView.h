//
//  PersonalHeaderView.h
//  CcwbNews
//
//  Created by xyy520 on 16/5/5.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PersonalHeaderView : UIView<ActionDelegate>
{
	AppDelegate *app;
}
-(void)refreshhotred:(NSDictionary *)dicsrc;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
