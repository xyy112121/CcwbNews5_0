//
//  BrokeWordView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/4/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "BrokeWordView.h"

@implementation BrokeWordView

-(id)initWithFrame:(CGRect)frame FromUser:(NSString *)fromuser WordStr:(NSString *)wordstr
{
	self = [super initWithFrame:frame];
	if (self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor clearColor];
		EnFromTypeBroke broketype;
		if([fromuser isEqualToString:@"1"])
			broketype= FromUser;
		else
			broketype= FromCcwb;
		[self initview:broketype WordStr:wordstr];
	}
	return self;
}

-(void)initview:(EnFromTypeBroke)fromuser WordStr:(NSString *)wordstr
{
	CGSize sizetemp = [AddInterface getlablesize:wordstr Fwidth:SCREEN_WIDTH-130 Fheight:1000 Sfont:FONTN(14.0f)];
	//添加汽泡底
	UIImageView *bgimageview;
	if(fromuser==FromCcwb)
	{
		float widthnow = sizetemp.width<30?60:sizetemp.width+30;
		bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(60, 10, widthnow, sizetemp.height+20)];
		UIImage *imageleft = LOADIMAGE(@"气泡left", @"png");
		imageleft = [imageleft stretchableImageWithLeftCapWidth:floorf(imageleft.size.width/2) topCapHeight:35];
		bgimageview.image = imageleft;
	}
	else
	{
		float widthnow = sizetemp.width<30?60:sizetemp.width+30;
		bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-widthnow, 10, widthnow, sizetemp.height+20)];
		UIImage *imageright = LOADIMAGE(@"气泡right", @"png");
		imageright = [imageright stretchableImageWithLeftCapWidth:floorf(imageright.size.width/2) topCapHeight:35];
		bgimageview.image = imageright;
	}
	[self addSubview:bgimageview];
	
	//添加文字label
	UILabel *labelword = [[UILabel alloc] initWithFrame:CGRectMake(bgimageview.frame.origin.x+15, bgimageview.frame.origin.y+10, bgimageview.frame.size.width-30, bgimageview.frame.size.height-20)];
	labelword.numberOfLines = 0;
	labelword.text = wordstr;
	labelword.font = FONTN(14.0f);
	if(fromuser==FromCcwb)
	{
		labelword.frame = CGRectMake(bgimageview.frame.origin.x+20, bgimageview.frame.origin.y+10, bgimageview.frame.size.width-20, bgimageview.frame.size.height-20);
		labelword.textColor = [UIColor blackColor];
	}
	else
	{
		labelword.frame = CGRectMake(bgimageview.frame.origin.x+10, bgimageview.frame.origin.y+10, bgimageview.frame.size.width-30, bgimageview.frame.size.height-20);
		labelword.textColor = [UIColor whiteColor];
	}
	[self addSubview:labelword];
	
	//添加头像
	UIImageView *imageviewheader = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	if(fromuser==FromCcwb)
	{
		imageviewheader.frame = CGRectMake(10, 10, 40, 40);
		imageviewheader.image  = LOADIMAGE(@"CWHeader", @"png");
	}
	else
	{
		imageviewheader.frame = CGRectMake(SCREEN_WIDTH-50, 10, 40, 40);
		imageviewheader.image  = LOADIMAGE(@"用户头像test", @"png");
	}
	[self addSubview:imageviewheader];
}

@end
