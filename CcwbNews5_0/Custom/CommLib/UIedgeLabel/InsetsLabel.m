//
//  InsetsLabel.m
//  Truckdriver
//
//  Created by xyy520 on 16/1/18.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "InsetsLabel.h"


@implementation InsetsLabel
@synthesize insets=_insets;
-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
	self = [super initWithFrame:frame];
	if(self){
		self.insets = insets;
	}
	return self;
}
-(id) initWithInsets:(UIEdgeInsets)insets {
	self = [super init];
	if(self){
		self.insets = insets;
	}
	return self;
}
-(void) drawTextInRect:(CGRect)rect {
	return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
