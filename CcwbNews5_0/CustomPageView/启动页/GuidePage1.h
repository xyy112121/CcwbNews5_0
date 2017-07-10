//
//  GuidePage1.h
//  YunBao
//
//  Created by xyy520 on 16/3/12.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionDelegate.h"
@interface GuidePage1 : UIView<ActionDelegate>
{
	int anmitionflag;
}
-(void)addparament:(id)sender;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
