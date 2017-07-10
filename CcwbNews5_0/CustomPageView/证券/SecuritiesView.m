//
//  SecuritiesView.m
//  CcwbNews
//
//  Created by xyy520 on 16/10/19.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "SecuritiesView.h"
#import "Header.h"
@implementation SecuritiesView

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
	NSArray *arrydata = [dicdata objectForKey:@"stockList"];
	NSDictionary *dic1 = [arrydata objectAtIndex:0];
	NSDictionary *dic2 = [arrydata objectAtIndex:1];
	NSDictionary *dic3 = [arrydata objectAtIndex:2];
	
	
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
	imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
	UIImageView *imageline0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
	imageline0.backgroundColor = COLORNOW(151, 151, 151);
	imageline0.alpha = 0.6;
	[self addSubview:imageline0];
	
	UIFont *fontname = FONTB(15.0f);
	UIFont *fontlatest = FONTN(17.0f);
	UIFont *fontsub = FONTHelve(15.0f);
	float space = 10;
	float spaceheight = 0;
	float spaceleft = 10;
	if(iphone6p)
	{
		fontname = FONTB(17.0f);
		fontlatest = FONTN(21.0f);
		fontsub = FONTHelve(17.0f);
		space = 20;
		spaceheight = 5;
		spaceleft = 20;
	}
	else if(iphone6)
	{
		fontname = FONTB(16.0f);
		fontlatest = FONTN(20.0f);
		fontsub = FONTHelve(16.0f);
		space = 10;
		spaceheight = 5;
		spaceleft = 20;
	}
	
	UILabel *labelname1 = [[UILabel alloc] initWithFrame:CGRectMake(spaceleft, 10,SCREEN_WIDTH/3-35, 20)];
	labelname1.text = [dic1 objectForKey:@"title"];
	labelname1.font = fontname;
	labelname1.textColor = COLORNOW(51, 51, 51);
	[self addSubview:labelname1];
	
	UILabel *labellatest1 = [[UILabel alloc] initWithFrame:CGRectMake(labelname1.frame.origin.x, labelname1.frame.origin.y+labelname1.frame.size.height+spaceheight,SCREEN_WIDTH/3-15, 20)];
	labellatest1.text = [dic1 objectForKey:@"latest"];
	labellatest1.font = fontlatest;
	if([[dic1 objectForKey:@"color"] isEqualToString:@"red"])
	{
		labellatest1.textColor = COLORNOW(215, 0, 15);
	}
	else
	{
		labellatest1.textColor = COLORNOW(37, 171, 100);
	}
	[self addSubview:labellatest1];
	
	CGSize subsize1 = [self getlabsub:dic1 FontSub:fontsub];
	UILabel *labelsub1 = [[UILabel alloc] initWithFrame:CGRectMake(labellatest1.frame.origin.x, labellatest1.frame.origin.y+labellatest1.frame.size.height+2,subsize1.width, subsize1.height)];
	labelsub1.font = fontsub;
	labelsub1.text = [dic1 objectForKey:@"sub"];
	[labelsub1 sizeToFit];
	
	[self addSubview:labelsub1];
	
	UILabel *labelrate1 = [[UILabel alloc] initWithFrame:CGRectMake(labelsub1.frame.origin.x+labelsub1.frame.size.width+5, labelsub1.frame.origin.y-1,(SCREEN_WIDTH/3-5)/2, 20)];
	labelrate1.text = [dic1 objectForKey:@"rate"];
	labelrate1.font = fontsub;
	labelrate1.backgroundColor = [UIColor clearColor];
	labelrate1.textColor = COLORNOW(51, 51, 51);
	[self addSubview:labelrate1];
	if([[dic1 objectForKey:@"color"] isEqualToString:@"red"])
	{
		labelsub1.textColor = COLORNOW(215, 0, 15);
		labelrate1.textColor = COLORNOW(215, 0, 15);
	}
	else
	{
		labelsub1.textColor = COLORNOW(37, 171, 100);
		labelrate1.textColor = COLORNOW(37, 171, 100);
	}
	
	
	UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, 10, 1, imageview.frame.size.height-20)];
	imageline1.backgroundColor = COLORNOW(151, 151, 151);
	imageline1.alpha = 0.7;
	[self addSubview:imageline1];
	
	UILabel *labelname2 = [[UILabel alloc] initWithFrame:CGRectMake(imageline1.frame.origin.x+space, labelname1.frame.origin.y,SCREEN_WIDTH/3-35, 20)];
	labelname2.text = [dic2 objectForKey:@"title"];
	labelname2.font = fontname;
	labelname2.textColor = COLORNOW(51, 51, 51);
	[self addSubview:labelname2];
	
	UILabel *labellatest2 = [[UILabel alloc] initWithFrame:CGRectMake(labelname2.frame.origin.x, labelname2.frame.origin.y+labelname2.frame.size.height+spaceheight,SCREEN_WIDTH/3-15, 20)];
	labellatest2.text = [dic2 objectForKey:@"latest"];
	labellatest2.font = fontlatest;
	labellatest2.backgroundColor = [UIColor clearColor];
	if([[dic2 objectForKey:@"color"] isEqualToString:@"red"])
	{
		labellatest2.textColor = COLORNOW(215, 0, 15);
	}
	else
	{
		labellatest2.textColor = COLORNOW(37, 171, 100);
	}
	[self addSubview:labellatest2];
	
	CGSize subsize2 = [self getlabsub:dic2 FontSub:fontsub];
	UILabel *labelsub2 = [[UILabel alloc] initWithFrame:CGRectMake(labellatest2.frame.origin.x, labellatest2.frame.origin.y+labellatest2.frame.size.height+2,subsize2.width, subsize2.height)];
	labelsub2.font = fontsub;
	labelsub2.text = [dic2 objectForKey:@"sub"];
	[self addSubview:labelsub2];
	
	UILabel *labelrate2 = [[UILabel alloc] initWithFrame:CGRectMake(labelsub2.frame.origin.x+labelsub2.frame.size.width+5, labelsub2.frame.origin.y-1,(SCREEN_WIDTH/3-5)/2, 20)];
	labelrate2.text = [dic2 objectForKey:@"rate"];
	labelrate2.font = fontsub;
	labelrate2.backgroundColor = [UIColor clearColor];
	labelrate2.textColor = COLORNOW(51, 51, 51);
	[self addSubview:labelrate2];
	if([[dic2 objectForKey:@"color"] isEqualToString:@"red"])
	{
		labelsub2.textColor = COLORNOW(215, 0, 15);
		labelrate2.textColor = COLORNOW(215, 0, 15);
	}
	else
	{
		labelsub2.textColor = COLORNOW(37, 171, 100);
		labelrate2.textColor = COLORNOW(37, 171, 100);
	}
	
	
	UIImageView *imageline2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 10, 1, imageview.frame.size.height-20)];
	imageline2.backgroundColor = COLORNOW(151, 151, 151);
	imageline2.alpha = 0.7;
	[self addSubview:imageline2];
	
	UILabel *labelname3 = [[UILabel alloc] initWithFrame:CGRectMake(imageline2.frame.origin.x+space, labelname2.frame.origin.y,SCREEN_WIDTH/3-35, 20)];
	labelname3.text = [dic3 objectForKey:@"title"];
	labelname3.font = fontname;
	labelname3.textColor = COLORNOW(51, 51, 51);
	[self addSubview:labelname3];
	
	UILabel *labellatest3 = [[UILabel alloc] initWithFrame:CGRectMake(labelname3.frame.origin.x, labelname3.frame.origin.y+labelname3.frame.size.height+spaceheight,SCREEN_WIDTH/3-15, 20)];
	labellatest3.text = [dic3 objectForKey:@"latest"];
	labellatest3.font = fontlatest;
	if([[dic3 objectForKey:@"color"] isEqualToString:@"red"])
	{
		labellatest3.textColor = COLORNOW(215, 0, 15);
	}
	else
	{
		labellatest3.textColor = COLORNOW(37, 171, 100);
	}
	[self addSubview:labellatest3];
	
	CGSize subsize3 = [self getlabsub:dic3 FontSub:fontsub];
	UILabel *labelsub3 = [[UILabel alloc] initWithFrame:CGRectMake(labellatest3.frame.origin.x, labellatest3.frame.origin.y+labellatest3.frame.size.height+2,subsize3.width, subsize3.height)];
	labelsub3.font = fontsub;
	labelsub3.text = [dic3 objectForKey:@"sub"];
	[self addSubview:labelsub3];
	
	UILabel *labelrate3 = [[UILabel alloc] initWithFrame:CGRectMake(labelsub3.frame.origin.x+labelsub3.frame.size.width+5, labelsub3.frame.origin.y-1,(SCREEN_WIDTH/3-5)/2, 20)];
	labelrate3.text = [dic3 objectForKey:@"rate"];
	labelrate3.font = fontsub;
	labelrate3.backgroundColor = [UIColor clearColor];
	labelrate3.textColor = COLORNOW(51, 51, 51);
	[self addSubview:labelrate3];
	if([[dic3 objectForKey:@"color"] isEqualToString:@"red"])
	{
		labelsub3.textColor = COLORNOW(215, 0, 15);
		labelrate3.textColor = COLORNOW(215, 0, 15);
	}
	else
	{
		labelsub3.textColor = COLORNOW(37, 171, 100);
		labelrate3.textColor = COLORNOW(37, 171, 100);
	}
	
}

-(CGSize)getlabsub:(NSDictionary *)dic FontSub:(UIFont *)fontsub
{
	


	
	NSDictionary *dicsub = [NSDictionary dictionaryWithObjectsAndKeys:fontsub,NSFontAttributeName, nil];
	CGSize sizesub = [[dic objectForKey:@"sub"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH/3-50, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicsub context:nil].size;
	
	return sizesub;
	
}


@end
