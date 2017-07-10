//
//  FocusNewsView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "FocusNewsView.h"

@implementation FocusNewsView

-(id)initWithFrame:(CGRect)frame Focus:(NSDictionary *)focus
{
	self = [super initWithFrame:frame];
	if (self)
	{
		dicfocus = focus;
		[self initviewloop:[dicfocus objectForKey:@"list"]];
	}
	return self;
}

-(void)initviewloop:(NSArray *)focus
{
	float nowheight = 160;
	if(iphone6)
		nowheight = nowheight*iphone6ratio;
	else if(iphone6p)
		nowheight = nowheight*iphone6pratio;
	
	
	self.frame = CGRectMake(0, 0, SCREEN_WIDTH, nowheight);
	self.backgroundColor = [UIColor clearColor];

	NSMutableArray *arraypiclist =  [[NSMutableArray alloc] init];
	for(int i=0;i<[focus count];i++)
	{
		NSDictionary *dictemp = [focus objectAtIndex:i];
		[arraypiclist addObject:[dictemp objectForKey:@"pic_path"]];
	}
	
	self.loop = [[XLsn0wLoop alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, nowheight)];
	[self addSubview:self.loop];
	self.loop.xlsn0wDelegate = self;
	self.loop.time = 5;
	[self.loop setPagePosition:PositionBottomRight];
	[self.loop setPageColor:[UIColor whiteColor] andCurrentPageColor:Colorredcolor];
	//支持gif动态图
	self.loop.imageArray = arraypiclist;
	

	
	if([focus count]>0)
	{
		NSDictionary *dictemp = [focus objectAtIndex:0];
		NSString *strtext = [dictemp objectForKey:@"title"];
		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strtext];
		NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
		[paragraphStyle setLineSpacing:0];
		[attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, strtext.length)];
		
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(15, self.loop.imagealpha.frame.origin.y+5,SCREEN_WIDTH-75, 20)];
		labeltitle.attributedText = attributedString;
		labeltitle.font = FONTN(15.0f);
		labeltitle.tag = EnFocusTitleLabelTag;
		labeltitle.textColor = [UIColor whiteColor];
		[self addSubview:labeltitle];
	}	
}

#pragma mark XRCarouselViewDelegate
- (void)loopView:(XLsn0wLoop *)loopView clickImageAtIndex:(NSInteger)index {
	NSLog(@"点击了第%ld张图片", index);
	
	if([self.delegate1 respondsToSelector:@selector(DGFocusClickNumberPic:)])
	{
		NSArray *focus = [dicfocus objectForKey:@"list"];
		[self.delegate1 DGFocusClickNumberPic:[focus objectAtIndex:index]];
	}
	
	
}


-(void)changepicdescript:(int)currentindex
{
	NSArray *arrayfocus = [dicfocus objectForKey:@"list"];
	NSDictionary *dictemp = [arrayfocus objectAtIndex:currentindex];
	UILabel *labeltitle = [self viewWithTag:EnFocusTitleLabelTag];
	labeltitle.text = [dictemp objectForKey:@"title"];
}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
//	int tagnow = (int)[[sender view] tag];
}


@end
