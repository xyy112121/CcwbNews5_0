//
//  GuideView.m
//  YunBao
//
//  Created by xyy520 on 16/3/11.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "GuideView.h"
#import "Header.h"
#import "GuidePage1.h"
#import "AppDelegate.h"
@implementation GuideView
@synthesize delegate1;

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.tag = 7200;
		[self initview];
	}
	return self;
}

-(void)initview
{
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
//	UIImageView *imageviewblack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//	imageviewblack.backgroundColor = [UIColor blackColor];
//	imageviewblack.alpha = 0.2;
//	[self addSubview:imageviewblack];
	
	// 第一页
	viewpage1 = [[GuidePage1 alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	viewpage1.clipsToBounds = YES;
//	[viewpage1 addparament:nil];
	viewpage1.delegate1 = self;
	[self addSubview:viewpage1];
	nowpage = 7201;
	// 第二页
	
	
}

-(void)gotoguidenextpage:(int)sender
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.6];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(nextpageend:)];
	switch (sender)
	{
		case 7201:
			nowpage = 7202;
			viewpage1.frame = CGRectMake(-SCREEN_WIDTH,0,viewpage1.frame.size.width,viewpage1.frame.size.height);
			viewpage2 = [[GuidePage2 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, self.frame.size.width, self.frame.size.height)];
			viewpage2.clipsToBounds = YES;
			viewpage2.delegate1 = self;
			[self addSubview:viewpage2];
			viewpage2.frame = CGRectMake(0,0,viewpage2.frame.size.width,viewpage2.frame.size.height);
			break;
		case 7202:
			nowpage = 7203;
			viewpage2.frame = CGRectMake(-SCREEN_WIDTH,0,viewpage2.frame.size.width,viewpage2.frame.size.height);
			viewpage3 = [[GuidePage3 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, self.frame.size.width, self.frame.size.height)];
			viewpage3.clipsToBounds = YES;
			viewpage3.delegate1 = self;
			[self addSubview:viewpage3];
			viewpage3.frame = CGRectMake(0,0,viewpage3.frame.size.width,viewpage3.frame.size.height);
			break;
		case 7203:
			nowpage = 7204;
			viewpage3.frame = CGRectMake(-SCREEN_WIDTH,0,viewpage3.frame.size.width,viewpage3.frame.size.height);
			viewpage4 = [[GuidePage4 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, self.frame.size.width, self.frame.size.height)];
			viewpage4.clipsToBounds = YES;
			viewpage4.delegate1 = self;
			[self addSubview:viewpage4];
			viewpage4.frame = CGRectMake(0,0,viewpage4.frame.size.width,viewpage4.frame.size.height);
			break;
        case 7204:
            nowpage = 7205;
            viewpage4.frame = CGRectMake(-SCREEN_WIDTH,0,viewpage3.frame.size.width,viewpage3.frame.size.height);
            viewpage5 = [[GuidePage5 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, self.frame.size.width, self.frame.size.height)];
            viewpage5.clipsToBounds = YES;
            viewpage5.delegate1 = self;
            [self addSubview:viewpage5];
            viewpage5.frame = CGRectMake(0,0,viewpage4.frame.size.width,viewpage4.frame.size.height);
            break;
		case 7205:
			if([delegate1 respondsToSelector:@selector(guideviewsnift:)])
			{
				[self.delegate1 guideviewsnift:nil];
			}
			break;
			

	}
	[UIView commitAnimations];
	
}

-(void)gotoprepage:(int)sender
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.6];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(prepageend:)];
	switch (sender)
	{
		case 7202:
			nowpage = 7201;
			viewpage2.frame = CGRectMake(SCREEN_WIDTH,0,viewpage2.frame.size.width,viewpage2.frame.size.height);
			viewpage1 = [[GuidePage1 alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, self.frame.size.width, self.frame.size.height)];
			viewpage1.clipsToBounds = YES;
			viewpage1.delegate1 = self;
			[self addSubview:viewpage1];
			viewpage1.frame = CGRectMake(0,0,viewpage1.frame.size.width,viewpage1.frame.size.height);
			break;
		case 7203:
			nowpage = 7202;
			viewpage3.frame = CGRectMake(SCREEN_WIDTH,0,viewpage3.frame.size.width,viewpage3.frame.size.height);
			viewpage2 = [[GuidePage2 alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, self.frame.size.width, self.frame.size.height)];
			viewpage2.clipsToBounds = YES;
			viewpage2.delegate1 = self;
			[self addSubview:viewpage2];
			viewpage2.frame = CGRectMake(0,0,viewpage2.frame.size.width,viewpage2.frame.size.height);
			break;
		case 7204:
			nowpage = 7203;
			viewpage4.frame = CGRectMake(SCREEN_WIDTH,0,viewpage4.frame.size.width,viewpage4.frame.size.height);
			viewpage3 = [[GuidePage3 alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, self.frame.size.width, self.frame.size.height)];
			viewpage3.clipsToBounds = YES;
			viewpage3.delegate1 = self;
			[self addSubview:viewpage3];
			viewpage3.frame = CGRectMake(0,0,viewpage3.frame.size.width,viewpage3.frame.size.height);
			break;
        case 7205:
            nowpage = 7204;
            viewpage5.frame = CGRectMake(SCREEN_WIDTH,0,viewpage4.frame.size.width,viewpage4.frame.size.height);
            viewpage4 = [[GuidePage4 alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, self.frame.size.width, self.frame.size.height)];
            viewpage4.clipsToBounds = YES;
            viewpage4.delegate1 = self;
            [self addSubview:viewpage4];
            viewpage4.frame = CGRectMake(0,0,viewpage3.frame.size.width,viewpage3.frame.size.height);
            break;
//		case 7205: //点击viewpage1关闭
//			if([delegate1 respondsToSelector:@selector(guideviewsnift:)])
//			{
//				[self.delegate1 guideviewsnift:nil];
//			}
//			break;
			
	}
	[UIView commitAnimations];
}

-(void)nextpageend:(id)sender
{
	if(nowpage == 7202)
	{
//		[viewpage2 addparament:nil];
		[viewpage1 removeFromSuperview];
		[viewpage3 removeFromSuperview];
		[viewpage4 removeFromSuperview];
        [viewpage5 removeFromSuperview];
	}
	else if(nowpage == 7203)
	{
//		[viewpage3 addparament:nil];
		[viewpage2 removeFromSuperview];
		[viewpage1 removeFromSuperview];
		[viewpage4 removeFromSuperview];
        [viewpage5 removeFromSuperview];
	}
	else if(nowpage == 7204)
	{
//		[viewpage4 addparament:nil];
		[viewpage2 removeFromSuperview];
		[viewpage1 removeFromSuperview];
		[viewpage3 removeFromSuperview];
        [viewpage5 removeFromSuperview];
	}
    else if(nowpage == 7205)
    {
        //		[viewpage4 addparament:nil];
        [viewpage2 removeFromSuperview];
        [viewpage1 removeFromSuperview];
        [viewpage3 removeFromSuperview];
        [viewpage4 removeFromSuperview];
    }
}

-(void)prepageend:(id)sender
{
	if(nowpage == 7202)
	{
//		[viewpage2 addparament:nil];
		[viewpage1 removeFromSuperview];
		[viewpage3 removeFromSuperview];
		[viewpage4 removeFromSuperview];
        [viewpage5 removeFromSuperview];
	}
	else if(nowpage == 7201)
	{
//		[viewpage1 addparament:nil];
		[viewpage2 removeFromSuperview];
		[viewpage3 removeFromSuperview];
		[viewpage4 removeFromSuperview];
        [viewpage5 removeFromSuperview];
	}
	else if(nowpage == 7203)
	{
//		[viewpage3 addparament:nil];
		[viewpage2 removeFromSuperview];
		[viewpage1 removeFromSuperview];
		[viewpage4 removeFromSuperview];
        [viewpage5 removeFromSuperview];
	}
    else if(nowpage == 7204)
    {
        //		[viewpage3 addparament:nil];
        [viewpage2 removeFromSuperview];
        [viewpage1 removeFromSuperview];
        [viewpage3 removeFromSuperview];
        [viewpage5 removeFromSuperview];
    }
    else if(nowpage == 7205)
    {
        //		[viewpage3 addparament:nil];
        [viewpage2 removeFromSuperview];
        [viewpage1 removeFromSuperview];
        [viewpage4 removeFromSuperview];
        [viewpage3 removeFromSuperview];
    }
}

@end
