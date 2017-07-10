//
//  ApplicationRecommendView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationRecommendView : UIView
{
	NSDictionary *dicdata;
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dicsrc;
@end
