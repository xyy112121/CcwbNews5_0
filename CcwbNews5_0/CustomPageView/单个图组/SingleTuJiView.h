//
//  SingleTuJiView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleTuJiView : UIView<UIScrollViewDelegate>
{
	NSDictionary *dicsrc;
	int nowpage;
	NSMutableArray *arraydata;
}
@property(nonatomic,strong)id<ActionDelegate> delegate1;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic;


@end
