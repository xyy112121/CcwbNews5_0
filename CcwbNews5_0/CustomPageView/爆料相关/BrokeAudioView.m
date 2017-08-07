//
//  BrokeAudioView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/4/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "BrokeAudioView.h"

@implementation BrokeAudioView

-(id)initWithFrame:(CGRect)frame FromUser:(NSString *)fromuser AudioPath:(NSString *)audiopath TimeLength:(NSString *)timelength
{
	self = [super initWithFrame:frame];
	if (self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor clearColor];
		EnFromTypeBroke broketype;
		fromaudiopath = audiopath;
		if([fromuser isEqualToString:@"1"])
			broketype= FromUser;
		else
			broketype= FromCcwb;
		playstatus = EnStop;
		[self initview:broketype AudioPath:audiopath TimeLength:timelength];
	}
	return self;
}

-(void)initview:(EnFromTypeBroke)fromuser AudioPath:(NSString *)audiopath TimeLength:(NSString *)timelength
{
	//添加汽泡底
	float nowwidth = SCREEN_WIDTH-130;
	float nowwidthpercent = nowwidth/60;
	float actwidth = 0.0f;
	if([timelength intValue]<30)
	{
		actwidth = 100;
	}
	else
	{
		actwidth = nowwidthpercent*[timelength intValue];
	}
	UIImageView *bgimageview;
	if(fromuser==FromCcwb)
	{
		bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(60, 10, actwidth, 40)];
		UIImage *imageleft = LOADIMAGE(@"气泡left", @"png");
		imageleft = [imageleft stretchableImageWithLeftCapWidth:floorf(imageleft.size.width/2) topCapHeight:35];
		bgimageview.image = imageleft;
	}
	else
	{
		bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-actwidth, 10, actwidth, 40)];
		UIImage *imageright = LOADIMAGE(@"气泡right", @"png");
		imageright = [imageright stretchableImageWithLeftCapWidth:floorf(imageright.size.width/2) topCapHeight:35];
		bgimageview.image = imageright;
	}
	bgimageview.userInteractionEnabled = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappednews:)];
	[bgimageview addGestureRecognizer:singleTap];
	[self addSubview:bgimageview];
	
	//添加图片
	UIImageView *imageviewpic = [[UIImageView alloc] initWithFrame:CGRectMake(bgimageview.frame.origin.x+bgimageview.frame.size.width-40, bgimageview.frame.origin.y+9, 17, 22)];
	imageviewpic.image = LOADIMAGE(@"brokeaudioicon", @"png");
	[self addSubview:imageviewpic];
	
	//添加多少秒
	UILabel *labelsecond = [[UILabel alloc] initWithFrame:CGRectMake(imageviewpic.frame.origin.x-50, bgimageview.frame.origin.y+10, 45, 20)];
	labelsecond.text = [timelength stringByAppendingString:@"″"];
	labelsecond.textColor = [UIColor whiteColor];
	labelsecond.font = FONTN(14.0f);
	[self addSubview:labelsecond];
	
	
	//添加头像
	UIImageView *imageviewheader = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	[self addSubview:imageviewheader];
	
	if(fromuser==FromCcwb)
	{
		imageviewheader.frame = CGRectMake(10, 10, 40, 40);
		imageviewheader.image  = LOADIMAGE(@"CWHeader", @"png");
		
	}
	else
	{
		imageviewheader.frame = CGRectMake(SCREEN_WIDTH-50, 10, 40, 40);
		imageviewheader.image  = LOADIMAGE(@"用户头像test", @"png");
        imageviewheader.layer.cornerRadius = 20;
        imageviewheader.clipsToBounds = YES;
        [imageviewheader setImageWithURL:URLSTRING(app.userinfo.userheader) placeholderImage:LOADIMAGE(@"用户头像test", @"png")];
		
	}
	
}

-(void)photoTappednews:(UIGestureRecognizer*)sender
{
	if(playstatus==EnStop) //当前状态是未播放状态
	{
		playstatus = EnPlay;  //修改状态为播放
	}
	else
	{
		playstatus = EnStop;
	}
	
	if([self.delegate1 respondsToSelector:@selector(DGPlayaudio:PlayStatus:)])
	{
		[self.delegate1 DGPlayaudio:fromaudiopath PlayStatus:playstatus];
	}
	
	
}

@end
