//
//  MoreNewsView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/22.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MoreNewsView.h"

@implementation MoreNewsView

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = COLORNOW(240, 240, 240);
		[self initview];
	}
	return self;
}

-(void)initview
{
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10,SCREEN_WIDTH-20, 20)];
	labeltitle.text = @"又有新内容推荐，点此查看";
	labeltitle.font = FONTN(15.0f);
	labeltitle.textAlignment = NSTextAlignmentCenter;
	labeltitle.textColor = COLORNOW(166, 166, 166);
	[self addSubview:labeltitle];

	
}
@end
