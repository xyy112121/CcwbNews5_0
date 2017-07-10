//
//  BottomView.h
//  CcwbNews
//
//  Created by xyy520 on 16/4/27.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BottomView : UIView
{
	
	AppDelegate *app;
}
@property(nonatomic,strong)UIScrollView	 *scrollview;
@property(nonatomic,strong)id<ActionDelegate> delegate1;
-(void)againarrangement:(NSString *)strid;
@end
