//
//  BrokeWordView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/4/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrokeWordView : UIView
{
	AppDelegate *app;
}
-(id)initWithFrame:(CGRect)frame FromUser:(NSString *)fromuser WordStr:(NSString *)wordstr;
@end
