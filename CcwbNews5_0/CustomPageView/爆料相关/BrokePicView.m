//
//  BrokePicView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/4/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "BrokePicView.h"

@implementation BrokePicView

-(id)initWithFrame:(CGRect)frame FromUser:(NSString *)fromuser PicPath:(NSString *)picpath
{
	self = [super initWithFrame:frame];
	if (self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor clearColor];
		EnFromTypeBroke broketype;
		frompicpath = picpath;
		if([fromuser isEqualToString:@"1"])
			broketype= FromUser;
		else
			broketype= FromCcwb;
		[self initview:broketype PicPath:picpath];
	}
	return self;
}

-(void)initview:(EnFromTypeBroke)fromuser PicPath:(NSString *)picpath
{
	//添加汽泡底
	UIImageView *bgimageview;
	if(fromuser==FromCcwb)
	{
		float widthnow = 120;
		bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(60, 10, widthnow, 150)];
		UIImage *imageleft = LOADIMAGE(@"气泡left", @"png");
		imageleft = [imageleft stretchableImageWithLeftCapWidth:floorf(imageleft.size.width/2) topCapHeight:40];
		bgimageview.image = imageleft;
	}
	else
	{
		float widthnow = 120;
		bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-widthnow, 10, widthnow, 150)];
		UIImage *imageright = LOADIMAGE(@"气泡right", @"png");
		imageright = [imageright stretchableImageWithLeftCapWidth:floorf(imageright.size.width/2) topCapHeight:40];
		bgimageview.image = imageright;
	}
	[self addSubview:bgimageview];
	
	//添加图片
	imageviewpic = [[UIImageView alloc] initWithFrame:CGRectMake(bgimageview.frame.origin.x+2, bgimageview.frame.origin.y+2, 104-4, 150-4)];
	[imageviewpic setImageWithURL:[NSURL URLWithString:picpath] placeholderImage:LOADIMAGE(@"noimage", @"png")];
	imageviewpic.layer.cornerRadius = 10.0f;
	imageviewpic.contentMode = UIViewContentModeScaleAspectFill;
	imageviewpic.clipsToBounds = YES;
	imageviewpic.userInteractionEnabled = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappednews:)];
	[imageviewpic addGestureRecognizer:singleTap];
	[self addSubview:imageviewpic];
	
	//添加头像
	UIImageView *imageviewheader = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	[self addSubview:imageviewheader];
	
	if(fromuser==FromCcwb)
	{
		imageviewheader.frame = CGRectMake(10, 10, 40, 40);
		imageviewheader.image  = LOADIMAGE(@"CWHeader", @"png");
		imageviewpic.frame = CGRectMake(bgimageview.frame.origin.x+16, bgimageview.frame.origin.y+1, 104-2, 150-2);
	}
	else
	{
		imageviewheader.frame = CGRectMake(SCREEN_WIDTH-50, 10, 40, 40);
		imageviewheader.image  = LOADIMAGE(@"用户头像test", @"png");
		imageviewpic.frame = CGRectMake(bgimageview.frame.origin.x+1, bgimageview.frame.origin.y+1, 104-2, 150-2);
        imageviewheader.layer.cornerRadius = 20;
        imageviewheader.clipsToBounds = YES;
        [imageviewheader setImageWithURL:URLSTRING(app.userinfo.userheader) placeholderImage:LOADIMAGE(@"用户头像test", @"png")];
	}
	
	
}

-(void)photoTappednews:(UIGestureRecognizer*)sender
{
	
	
	if([self.delegate1 respondsToSelector:@selector(DGClickBrokeDisPlayPic:ConView:FormImage:)])
	{
		[self.delegate1 DGClickBrokeDisPlayPic:frompicpath ConView:imageviewpic FormImage:imageviewpic.image];
	}
}


@end
