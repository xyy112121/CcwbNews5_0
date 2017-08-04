//
//  GuidePage4.m
//  CcwbNews
//
//  Created by xyy520 on 16/7/8.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "GuidePage4.h"

@implementation GuidePage4
@synthesize delegate1;

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.tag = 7204;
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
    imageviediwen.image = LOADIMAGE(@"guide4", @"jpg");
    [self addSubview:imageviediwen];

}

-(void)closeguide:(id)sender
{
	if([delegate1 respondsToSelector:@selector(gotoguidenextpage:)])
	{
		[delegate1 gotoguidenextpage:7204];
	}
}

- (IBAction)handleSwipeFrom:( UISwipeGestureRecognizer *)sender
{
	DLog(@"UISwipeGestureRecognizerDirectionRight");
	
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
	float widthnow = 231;
	float heightnow = 242;
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
	imageviediwen.image = LOADIMAGE(@"pagebg4", @"png");
	[self addSubview:imageviediwen];
	[imageviediwen reboundEffectAnimationDuration:0.7 Dele:self Flag:1];
	
	float widthnow1 = 195;
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
	imageins.image = LOADIMAGE(@"guidepage1_4", @"png");
	[self addSubview:imageins];
	
	
	float widthnow2 = 123;
	float heightnow2 = 34;
	if(iphone6p)
	{
		widthnow2 = widthnow2*iphone6pratio;
		heightnow2 = heightnow2*iphone6pratio;
	}
	else if(iphone6)
	{
		widthnow2 = widthnow2*iphone6ratio;
		heightnow2 = heightnow2*iphone6ratio;
	}
	
	
//	UIButton *buttongude = [UIButton buttonWithType:UIButtonTypeCustom];
//	buttongude.layer.borderColor = [UIColor clearColor].CGColor;
//	buttongude.frame = CGRectMake((SCREEN_WIDTH-widthnow2)/2, imageins.frame.origin.y +imageins.frame.size.height+40, widthnow2, heightnow2);
//	[buttongude setBackgroundImage:LOADIMAGE(@"guidebt", @"png") forState:UIControlStateNormal];
//	[buttongude addTarget:self action:@selector(closeguide:) forControlEvents:UIControlEventTouchUpInside];
//	[self addSubview:buttongude];
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
