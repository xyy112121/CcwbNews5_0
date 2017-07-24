//
//  BurstNewsView.m
//  CcwbNews
//
//  Created by xyy520 on 16/4/28.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "BurstNewsView.h"
#import "Header.h"
@implementation BurstNewsView
@synthesize delegate1;

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

-(void)initview:(NSDictionary *)dic
{
	NSArray *arraynews = [dic objectForKey:@"list"];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, self.frame.size.height-3)];
	imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 14, 14)];
	imageicon.image = LOADIMAGE(@"volumeicon", @"png");
	[self addSubview:imageicon];
	
	UIImageView *imagelogo = [[UIImageView alloc] initWithFrame:CGRectMake(imageicon.frame.origin.x+imageicon.frame.size.width+5, 15, 45, 14)];
	imagelogo.image = LOADIMAGE(@"ccwblogoicon", @"png");
	[self addSubview:imagelogo];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imagelogo.frame.origin.x+imagelogo.frame.size.width+10, imageicon.frame.origin.y-3,150, 20)];
	labelname.text = [dic objectForKey:@"type_name"];
	labelname.font = FONTMEDIUM(16.0f);
	labelname.textColor = COLORNOW(128, 128, 128);
	[self addSubview:labelname];
	
	UIButton *buttonmore = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmore.layer.borderColor = [UIColor clearColor].CGColor;
	buttonmore.frame = CGRectMake(SCREEN_WIDTH-80, imageicon.frame.origin.y-5, 75, 24);
	[buttonmore setTitle:@"更多" forState:UIControlStateNormal];
	[buttonmore setImage:LOADIMAGE(@"arrowrightred", @"png") forState:UIControlStateNormal];
	[buttonmore setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
	[buttonmore setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
	buttonmore.titleLabel.font = FONTN(15.0f);
	[buttonmore addTarget:self action:@selector(gotomoreandmorenews:) forControlEvents:UIControlEventTouchUpInside];
	[buttonmore setTitleColor:COLORNOW(128, 128, 128) forState:UIControlStateNormal];
	[self addSubview:buttonmore];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, labelname.frame.size.height+labelname.frame.origin.y+5, SCREEN_WIDTH, 0.5)];
	imageline.backgroundColor = COLORNOW(240, 240, 240);
	[self addSubview:imageline];
	
	float noworiginy=labelname.frame.size.height+labelname.frame.origin.y+20;
	//多条新闻
	for(int i =0;i<[arraynews count];i++)
	{
		NSDictionary *dictemp = [arraynews objectAtIndex:i];
		UIImageView *imagepoint = [[UIImageView alloc] initWithFrame:CGRectMake(imageicon.frame.origin.x+imageicon.frame.size.width-8,noworiginy+4, 8, 8)];
		imagepoint.backgroundColor = [UIColor whiteColor];
		imagepoint.layer.cornerRadius = 4.0f;
		imagepoint.clipsToBounds = YES;
		imagepoint.layer.borderColor = COLORNOW(189, 30, 33).CGColor;
		imagepoint.layer.borderWidth = 1.0f;
		[self addSubview:imagepoint];
		
		//标题
		UIFont *fontname = FONTN(14.0f);
		float space = 4;
		if(iphone6p)
		{
			fontname = FONTN(18.0f);

		}
		else if(iphone6)
		{
			fontname = FONTN(16.0f);
		}
		
		NSString *texttitle = [dictemp objectForKey:@"title"];
		NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:fontname,NSFontAttributeName, nil];
		CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-35, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;
		
		NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:texttitle];
		NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
		[paragraphStyle1 setLineSpacing:space];
		[attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [texttitle length])];
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imageicon.frame.origin.x+imageicon.frame.size.width+5, noworiginy,sizetitle.width,sizetitle.height)];
		labeltitle.font = fontname;
		labeltitle.numberOfLines = 0;
		[labeltitle setAttributedText:attributedString1];
		[labeltitle sizeToFit];
		

		labeltitle.backgroundColor = [UIColor clearColor];
		labeltitle.textColor = COLORNOW(48, 48, 48);
		[self addSubview:labeltitle];
		
		noworiginy = noworiginy+labeltitle.frame.size.height+16;
		
		UIButton *buttonburst = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonburst.layer.borderColor = [UIColor clearColor].CGColor;
		buttonburst.frame = CGRectMake(labeltitle.frame.origin.x-10, labeltitle.frame.origin.y-7, SCREEN_WIDTH-40, labeltitle.frame.size.height+14);
		buttonburst.tag = 3400+i;
		buttonburst.backgroundColor = [UIColor clearColor];
		[buttonburst addTarget:self action:@selector(clickburst:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:buttonburst];
	}
	
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, noworiginy);
	imageview.frame = CGRectMake(imageview.frame.origin.x, imageview.frame.origin.y, imageview.frame.size.width, self.frame.size.height-3);
	DLog(@"self.frame====%f",self.frame.size.height);
}

-(void)clickburst:(id)sender
{
	NSArray *arraynews = [dicsrc objectForKey:@"list"];
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-3400;
	NSDictionary *dictemp = [arraynews objectAtIndex:tagnow];
	if([delegate1 respondsToSelector:@selector(DGClickBurstNews:)])
	{
		[delegate1 DGClickBurstNews:dictemp];
	}
}

-(void)gotomoreandmorenews:(id)sender
{
//	NSString *strmoreurl = [dicsrc objectForKey:@"more_url"];
	if([delegate1 respondsToSelector:@selector(DGClickMoreNewsUrl:)])
	{
		[delegate1 DGClickMoreNewsUrl:dicsrc];
	}
}


@end
