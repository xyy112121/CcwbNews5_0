//
//  FocusNewsView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLsn0wLoop.h"
@interface FocusNewsView : UIView<UIScrollViewDelegate,XLsn0wLoopDelegate>
{
	UIScrollView *scrollviewtop;
	NSTimer *timeernow;
	NSDictionary *dicfocus;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property (nonatomic, strong) XLsn0wLoop *loop;
-(id)initWithFrame:(CGRect)frame Focus:(NSDictionary *)focus;
@end
