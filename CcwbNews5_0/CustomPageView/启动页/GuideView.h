//
//  GuideView.h
//  YunBao
//
//  Created by xyy520 on 16/3/11.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "ActionDelegate.h"
#import "GuidePage1.h"
#import "GuidePage2.h"
#import "GuidePage3.h"
#import "GuidePage4.h"
@interface GuideView : UIView<ActionDelegate>
{
	GuidePage1 *viewpage1;
	GuidePage2 *viewpage2;
	GuidePage3 *viewpage3;
	GuidePage4 *viewpage4;
	int nowpage;
	
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@end
