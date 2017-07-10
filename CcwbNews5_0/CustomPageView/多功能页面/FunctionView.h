//
//  FunctionView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionView : UIView
{
	UIScrollView *scrollviewtop;
	NSDictionary *dicfocus;
	EnTypeFunctionFoled entype;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame Focus:(NSDictionary *)focus EnFoledType:(EnTypeFunctionFoled)type;
@end
