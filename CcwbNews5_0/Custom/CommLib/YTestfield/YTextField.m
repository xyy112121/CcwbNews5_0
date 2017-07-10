//
//  YTextField.m
//  Healthaide
//
//  Created by xyy520 on 15/7/12.
//  Copyright (c) 2015年 谢 毅. All rights reserved.
//

#import "YTextField.h"

@implementation YTextField

-(id)initWithFrame:(CGRect)frame Icon:(UIImageView*)icon
{
	self = [super initWithFrame:frame];
	if (self) {
		self.leftView = icon;
		self.leftViewMode = UITextFieldViewModeAlways;
	}
	return self;
}

-(CGRect) leftViewRectForBounds:(CGRect)bounds {
	CGRect iconRect = [super leftViewRectForBounds:bounds];
	iconRect.origin.x += 10;// 右偏10
	return iconRect;
}

@end
