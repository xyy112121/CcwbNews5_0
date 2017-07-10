//
//  ApplicationHpView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/7/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ApplicationHpView.h"

@implementation ApplicationHpView

-(id)initWithFrame:(CGRect)frame RequestDic:(NSDictionary *)dic
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		
		[self initview:dic];
	}
	return self;
}

-(void)initview:(NSDictionary *)dic
{
	
}

@end
