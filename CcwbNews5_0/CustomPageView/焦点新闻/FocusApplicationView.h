//
//  FocusApplicationView.h
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/12.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusApplicationView : UIView<UIScrollViewDelegate,XLsn0wLoopDelegate>
{
    UIScrollView *scrollviewtop;
    NSTimer *timeernow;
    NSDictionary *dicfocus;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property (nonatomic, strong) XLsn0wLoop *loop;
-(id)initWithFrame:(CGRect)frame Focus:(NSDictionary *)focus;
-(id)initWithFrame1:(CGRect)frame Focus:(NSDictionary *)focus;

@end
