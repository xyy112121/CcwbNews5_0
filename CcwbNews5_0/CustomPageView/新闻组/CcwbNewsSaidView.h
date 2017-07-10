//
//  CcwbNewsSaidView.h
//  CcwbNews
//
//  Created by xyy520 on 16/4/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CcwbNewsSaidView : UIView<UIScrollViewDelegate>
{
	NSDictionary *dicsrc;
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate> delegate1;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic;
@end
