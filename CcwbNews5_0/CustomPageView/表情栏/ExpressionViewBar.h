//
//  ExpressionViewBar.h
//  CcwbNews5_0
//
//  Created by xyy on 2017/9/5.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressionViewBar : UIView<UIScrollViewDelegate>
{
    AppDelegate *app;
    SMPageControl *spacePageControl1;
    UIScrollView *scrollviewtop;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
