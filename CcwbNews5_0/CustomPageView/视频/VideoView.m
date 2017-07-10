//
//  VideoView.m
//  CcwbNews
//
//  Created by xyy520 on 16/4/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "VideoView.h"
#import "Header.h"
@implementation VideoView

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		[self initview];
	}
	return self;
}

-(void)initview
{
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, self.frame.size.height-5)];
	imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(25, 15,150, 20)];
	labelname.text = @"视频";
	labelname.font = FONTN(15.0f);
	labelname.textColor = COLORNOW(153, 153, 153);
	[self addSubview:labelname];
	
//	UIButton *buttonzhuanfa = [UIButton buttonWithType:UIButtonTypeCustom];
//	buttonzhuanfa.frame = CGRectMake(self.frame.size.width-40, 0, 40, 40);
//	[buttonzhuanfa setBackgroundColor:[UIColor clearColor]];
//	[buttonzhuanfa setImage:LOADIMAGE(@"转发", @"png") forState:UIControlStateNormal];
//	[buttonzhuanfa addTarget:self action:@selector(clickzhuanfa:) forControlEvents:UIControlEventTouchUpInside];
//	[self addSubview:buttonzhuanfa];
	
	float nowheight = 130;
	float spaceheight = 6;
	if(iphone6)
	{
		spaceheight = 2;
		nowheight = 145;
	}
	else if(iphone6p)
	{
		spaceheight = 2;
		nowheight = 165;
	}
	
	UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(0, labelname.frame.origin.y+labelname.frame.size.height+5, self.frame.size.width, nowheight)];
	imagepic.image = LOADIMAGE(@"noimage", @"png");
	imagepic.contentMode = UIViewContentModeScaleAspectFill;
	imagepic.clipsToBounds = YES;
	[self addSubview:imagepic];
	
	NSString *texttitle = @"他用了14个月重建了圆明园！！";
	NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:FONTB(14.0f),NSFontAttributeName, nil];
	CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(self.frame.size.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(25, imagepic.frame.origin.y+imagepic.frame.size.height+spaceheight,sizetitle.width,sizetitle.height)];
	labeltitle.text = texttitle;
	labeltitle.font = FONTB(14.0f);
	labeltitle.numberOfLines = 0;
	labeltitle.backgroundColor = [UIColor clearColor];
	labeltitle.textColor = COLORNOW(48, 48, 48);
	[self addSubview:labeltitle];
	
	UIImageView *imageclock = [[UIImageView alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x, imageview.frame.origin.y+imageview.frame.size.height-14, 8, 8)];
	imageclock.image = LOADIMAGE(@"clockicon", @"png");
	imageclock.contentMode = UIViewContentModeScaleAspectFill;
	imageclock.clipsToBounds = YES;
	[self addSubview:imageclock];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(imageclock.frame.origin.x+imageclock.frame.size.width+5, imageclock.frame.origin.y-6,150, 20)];
	labeltime.text = @"2012-12-01";
	labeltime.font = FONTN(10.0f);
	labeltime.textColor = COLORNOW(153, 153, 153);
	[self addSubview:labeltime];
	
	UIImageView *imagesticky = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-35, imageclock.frame.origin.y-2, 21, 11)];
	imagesticky.image = LOADIMAGE(@"test3", @"png");
	[self addSubview:imagesticky];
}

-(void)clickzhuanfa:(id)sender
{
	
}

@end
