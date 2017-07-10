//
//  UIMyLabel.m
//  TbeaWaterElectrician
//
//  Created by xyy520 on 16/12/22.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "UIMyLabel.h"

@implementation UIMyLabel

-(id)initWithFrame:(CGRect)frame Text:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color
{
	self = [super initWithFrame:frame];
	if(self)
	{
		self.text = text;
		self.textColor = color;
		self.font = font;
	}
	return self;
}


-(id)initWithFrame:(CGRect)frame Text:(NSString *)text
{
	self = [super initWithFrame:frame];
	if(self)
	{
		self.text = text;
	}
	return self;
}

@end
