//
//  TuJiView.h
//  CcwbNews
//
//  Created by xyy520 on 16/6/6.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuJiView : UIView<UIScrollViewDelegate>
{
	NSDictionary *dicsrc;
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate> delegate1;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic More:(NSString *)more;
@end
