//
//  GuidePage2.m
//  YunBao
//
//  Created by xyy520 on 16/3/12.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "GuidePage2.h"
#import "Header.h"
#import "UIView+Extension.h"
@implementation GuidePage2
@synthesize delegate1;
-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.tag = 7202;
		anmitionflag = 1;
		[self initview];
	}
	return self;
}

-(void)initview
{
	UISwipeGestureRecognizer *recognizer;
	recognizer = [[ UISwipeGestureRecognizer alloc ] initWithTarget : self action : @selector (handleSwipeFrom:)];
	[recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
	[self addGestureRecognizer:recognizer];
	
	recognizer = [[ UISwipeGestureRecognizer alloc ] initWithTarget : self action : @selector (handleSwipeFrom:)];
	[recognizer setDirection :( UISwipeGestureRecognizerDirectionLeft)];
	[self addGestureRecognizer :recognizer];
	
    UIImageView *imageviediwen = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imageviediwen.image = LOADIMAGE(@"guide2", @"png");
    [self addSubview:imageviediwen];

}

-(void)closeguide:(id)sender
{
	if([delegate1 respondsToSelector:@selector(gotoprepage:)])
	{
		[delegate1 gotoprepage:7204];
	}
}

- (IBAction)handleSwipeFrom:( UISwipeGestureRecognizer *)sender
{
	if ((sender. direction == UISwipeGestureRecognizerDirectionRight))
	{
		if([delegate1 respondsToSelector:@selector(gotoprepage:)])
		{
			[delegate1 gotoprepage:(int)self.tag];
		}
	}
	else if((sender. direction == UISwipeGestureRecognizerDirectionLeft))
	{
		//从右向左
		if([delegate1 respondsToSelector:@selector(gotoguidenextpage:)])
		{
			[delegate1 gotoguidenextpage:(int)self.tag];
		}
	}
}


-(void)addparament:(id)sender
{
	float widthnow = 233;
	float heightnow = 227;
	if(iphone6p)
	{
		widthnow = widthnow*iphone6pratio;
		heightnow = heightnow*iphone6pratio;
	}
	else if(iphone6)
	{
		widthnow = widthnow*iphone6ratio;
		heightnow = heightnow*iphone6ratio;
	}
	UIImageView *imageviediwen = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-widthnow)/2, 100, widthnow, heightnow)];
	imageviediwen.image = LOADIMAGE(@"pagebg1", @"png");
	[self addSubview:imageviediwen];
	[imageviediwen reboundEffectAnimationDuration:0.7 Dele:self Flag:1];
	
	float widthnow1 = 183;
	float heightnow1 = 38;
	if(iphone6p)
	{
		widthnow1 = widthnow1*iphone6pratio;
		heightnow1 = heightnow1*iphone6pratio;
	}
	else if(iphone6)
	{
		widthnow1 = widthnow1*iphone6ratio;
		heightnow1 = heightnow1*iphone6ratio;
	}
	
	UIImageView *imageins = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-widthnow1)/2, imageviediwen.frame.origin.y +imageviediwen.frame.size.height+50, widthnow1, heightnow1)];
	imageins.image = LOADIMAGE(@"guidepage1_1", @"png");
	[self addSubview:imageins];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	if(anmitionflag == 1)
	{
		anmitionflag = 2;
		UIView *viewword1 = [self viewWithTag:201];
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(displayword2:)];
		viewword1.alpha = 1;
		[UIView commitAnimations];
	}
}

-(void)displayword2:(id)sender
{
	UIView *viewword2 = [self viewWithTag:202];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	//	[UIView setAnimationDidStopSelector:@selector(displayword2:)];
	viewword2.alpha = 1;
	[UIView commitAnimations];
}

@end
