//
//  CustomNewsView.m
//  CcwbNews
//
//  Created by xyy520 on 16/4/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "CustomNewsView.h"
#import "Header.h"
@implementation CustomNewsView

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
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, self.frame.size.height-3)];
	imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
	NSString *picpath = [dicdata objectForKey:@"pic_path"];
	if([[picpath lastPathComponent] isEqualToString:@"gif"])
	{
		YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(10, 16, 90, 70)];
		[self addSubview:imageViewgif];
		imageViewgif.tag = EnYLImageViewTag;
		imageViewgif.image = [YLGIFImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dicdata objectForKey:@"pic_path"]]]];
		
	}
	else
	{
		UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 90, 70)];
		[imagepic setImageWithURL:[NSURL URLWithString:[dicdata objectForKey:@"pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
		imagepic.contentMode = UIViewContentModeScaleAspectFill;
		imagepic.clipsToBounds = YES;
		[self addSubview:imagepic];
	}

	
	NSString *texttitle = [dicdata objectForKey:@"title"];
	UIFont *fontname = FONTN(15.0f);
	UIFont *fonttime = FONTN(12.0f);
	float space = 4;
	if(iphone6p)
	{
		fontname = FONTN(17.0f);
		fonttime = FONTN(14.0f);
		space = 6;
	}
	else if(iphone6)
	{
		fontname = FONTN(16.0f);
		fonttime = FONTN(13.0f);
		space = 5;
	}

	
	
	NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:fontname,NSFontAttributeName, nil];
	CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(self.frame.size.width-120, 70) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;
	
	NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:texttitle];
	NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
	[paragraphStyle1 setLineSpacing:space];
	[attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [texttitle length])];
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(105, 15,sizetitle.width, sizetitle.height)];
	labelname.font = fontname;
	labelname.numberOfLines = 2;
	[labelname setAttributedText:attributedString1];
	[labelname sizeToFit];
	labelname.textColor = COLORNOW(48, 48, 48);
	[self addSubview:labelname];
	
	UILabel *labelappname = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, self.frame.size.height-30, 50, 20)];
	labelappname.text = [dicdata objectForKey:@"app_name"];
	labelappname.font = fonttime;
	labelappname.textColor = COLORNOW(232, 56, 47);
	[self addSubview:labelappname];
	
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(labelappname.frame.origin.x+labelappname.frame.size.width, labelappname.frame.origin.y,150, 20)];
	labeltime.text = [dicdata objectForKey:@"add_time"];
	labeltime.font = FONTN(14.0f);
	labeltime.textColor = COLORNOW(153, 153, 153);
	[self addSubview:labeltime];
	if([[dicdata objectForKey:@"app_name"] length]==0)
	{
		labeltime.frame = CGRectMake(labelappname.frame.origin.x, labelappname.frame.origin.y,150, 20);
	}
    
    if([[dicdata objectForKey:@"click_num"] length]>0)
    {
        UIImageView *imagelook = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-70, XYViewTop(labeltime)+6, 14, 8)];
        imagelook.image = LOADIMAGE(@"点击次数查看", @"png");
        [self addSubview:imagelook];
        
        UILabel *labelnum = [[UILabel alloc] initWithFrame:CGRectMake(XYViewRight(imagelook)+3, XYViewTop(labeltime), 63, 20)];
        labelnum.text = [dicdata objectForKey:@"click_num"];
        labelnum.font = FONTN(12.0f);
        labelnum.textColor = COLORNOW(192, 192, 192);
        [self addSubview:labelnum];
    }	
}

@end
