//
//  DiscorverView.m
//  CcwbNews
//
//  Created by xyy520 on 16/4/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "DiscorverView.h"
#import "Header.h"
@implementation DiscorverView

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
//	DLog(@"height=====%@",self.frame.size.height);
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, self.frame.size.height-5)];
	imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 15,150, 20)];
	labelname.text = [dicdata objectForKey:@"type_name"];
	labelname.font = FONTN(15.0f);
	labelname.textColor = COLORNOW(153, 153, 153);
	[self addSubview:labelname];
	
	float nowheight = 160;
	float spaceheight = 10;
	if(iphone6)
	{
		spaceheight = 5;
		nowheight = nowheight*(iphone6ratio+0.05);
	}
	else if(iphone6p)
	{
		spaceheight = 6;
		nowheight = nowheight*(iphone6pratio+0.1);
	}
	
	
	UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(0, labelname.frame.origin.y+labelname.frame.size.height+5, self.frame.size.width, nowheight)];
	[imagepic setImageWithURL:[NSURL URLWithString:[dicdata objectForKey:@"pic"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
	imagepic.contentMode = UIViewContentModeScaleAspectFill;
	imagepic.clipsToBounds = YES;
	[self addSubview:imagepic];
	
	UIFont *fontnow = FONTB(15.0f);
	UIFont *fonttime = FONTN(11.0f);
	if(iphone6)
	{
		fontnow = FONTB(16.0f);
		fonttime = FONTN(12.0f);
	}
	else if(iphone6p)
	{
		fontnow = FONTB(17.0f);
		fonttime = FONTN(13.0f);
	}
	
	NSString *texttitle = [dicdata objectForKey:@"title"];
	NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:fontnow,NSFontAttributeName, nil];
	CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(self.frame.size.width-(labelname.frame.origin.x*2), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, imagepic.frame.origin.y+imagepic.frame.size.height+spaceheight,sizetitle.width,sizetitle.height)];
	labeltitle.text = texttitle;
	labeltitle.font = fontnow;
	
	labeltitle.numberOfLines = 0;
	labeltitle.backgroundColor = [UIColor clearColor];
	labeltitle.textColor = COLORNOW(48, 48, 48);
	[self addSubview:labeltitle];
	
	UIImageView *imageclock = [[UIImageView alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x, imageview.frame.origin.y+imageview.frame.size.height-13, 8, 8)];
	imageclock.image = LOADIMAGE(@"clockicon", @"png");
	imageclock.contentMode = UIViewContentModeScaleAspectFill;
	imageclock.clipsToBounds = YES;
	[self addSubview:imageclock];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(imageclock.frame.origin.x+imageclock.frame.size.width+5, imageclock.frame.origin.y-6,150, 20)];
	labeltime.text = [dicdata objectForKey:@"addtime"];
	labeltime.font = fonttime;
	labeltime.textColor = COLORNOW(153, 153, 153);
	[self addSubview:labeltime];
	
	if([[dicdata objectForKey:@"tagpic"] length]>0)
	{
		UIImageView *imagesticky = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-35, imageclock.frame.origin.y-2, 21, 11)];
		[imagesticky setImageWithURL:[NSURL URLWithString:[dicdata objectForKey:@"tagpic"]]];
		[self addSubview:imagesticky];
	}
}

-(void)clickzhuanfa:(id)sender
{
	
}

@end
