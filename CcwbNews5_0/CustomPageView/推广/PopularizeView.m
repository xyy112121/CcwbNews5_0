//
//  PopularizeView.m
//  CcwbNews
//
//  Created by xyy520 on 16/4/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "PopularizeView.h"
#import "Header.h"
@implementation PopularizeView

-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		dicsrc = dic;
		[self initview:dicsrc];
	}
	return self;
}

-(void)initview:(NSDictionary *)dicdata
{
	UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, self.frame.size.height-5)];
	[imagepic setImageWithURL:[NSURL URLWithString:[dicdata objectForKey:@"pic"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
	imagepic.contentMode = UIViewContentModeScaleAspectFill;
	imagepic.clipsToBounds = YES;
	[self addSubview:imagepic];
	
	if([[dicdata objectForKey:@"tagpic"] length]>0)
	{
		UIImageView *imagesticky = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-35, self.frame.size.height-20, 21, 11)];
		[imagesticky setImageWithURL:[NSURL URLWithString:[dicdata objectForKey:@"tagpic"]]];
		[self addSubview:imagesticky];
	}
}

@end
