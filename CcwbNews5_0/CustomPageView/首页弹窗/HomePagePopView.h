//
//  HomePagePopView.h
//  CcwbNews
//
//  Created by xyy520 on 16/6/20.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePagePopView : UIView
{
	UIScrollView *scrollview;
//	NSArray *arraysrc;
	NSDictionary *dicsrc;
}
@property(nonatomic,strong)id<ActionDelegate> delegate1;
-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)arr;
@end
