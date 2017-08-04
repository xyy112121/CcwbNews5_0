//
//  FunctionView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "FunctionView.h"

@implementation FunctionView

-(id)initWithFrame:(CGRect)frame Focus:(NSDictionary *)focus EnFoledType:(EnTypeFunctionFoled)type
{
	self = [super initWithFrame:frame];
	if (self)
	{
		dicfocus = focus;
		self.backgroundColor = [UIColor whiteColor];
		if(type == EnFolded)  //折叠
		{
			entype = EnFolded;
			[self initviewfolded:[dicfocus objectForKey:@"list"]];
		}
		else  //展开
		{
			entype = EnUnFolded;
			[self initviewunfolded:[dicfocus objectForKey:@"list"]];
		}
	}
	return self;
}

-(void)initviewfolded:(NSArray *)focus
{
	
	float widthspace = (SCREEN_WIDTH-50-160)/3;
	float nowwidth = 25;//(SCREEN_WIDTH-50)/4;
	float heightnow = 15;
	int countfocus = (int)[focus count];
	if(countfocus>4)
		countfocus = 4;
	
	
	for(int i=0;i<countfocus;i++)
	{
		NSDictionary *dictemp = [focus objectAtIndex:i];
		UIButton *buttonfunction = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonfunction.layer.borderColor = [UIColor clearColor].CGColor;
		buttonfunction.frame= CGRectMake(nowwidth+i*(40+widthspace),heightnow, 40, 40);
		NSURL *urlstr = [NSURL URLWithString:[dictemp objectForKey:@"pic_path"]];
        [buttonfunction setImageForState:UIControlStateNormal withURL:urlstr];
     //    setImageForState:UIControlStateNormal withURL:urlstr];
		
		buttonfunction.tag = EnHpFunctionButtonTag+i;
		[buttonfunction addTarget:self action:@selector(clickfunction:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:buttonfunction];
		
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(buttonfunction.frame.origin.x-15, buttonfunction.frame.origin.y+buttonfunction.frame.size.height+5,buttonfunction.frame.size.width+30, 20)];
		labeltitle.text = [dictemp objectForKey:@"title"];
		labeltitle.font = FONTN(14.0f);
		labeltitle.textAlignment = NSTextAlignmentCenter;
		labeltitle.tag = EnFocusTitleLabelTag;
		labeltitle.textColor = [UIColor blackColor];
		[self addSubview:labeltitle];
		
		
		
	}
	heightnow = heightnow+40+5+20+10;
	
    if(countfocus>4)
    {
        UIButton *buttonarrow = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonarrow.layer.borderColor = [UIColor clearColor].CGColor;
        buttonarrow.frame= CGRectMake((SCREEN_WIDTH-40)/2,heightnow, 40, 30);
        [buttonarrow setImage:LOADIMAGE(@"arrowdown", @"png") forState:UIControlStateNormal];
        [buttonarrow addTarget:self action:@selector(foldedfunction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonarrow];
        buttonarrow.backgroundColor = [UIColor clearColor];
        heightnow = heightnow+buttonarrow.frame.size.height+10;
    }
	self.frame = CGRectMake(0, 0, SCREEN_WIDTH, heightnow);
	
}

-(void)initviewunfolded:(NSArray *)focus
{
	float widthspace = (SCREEN_WIDTH-50-160)/3;
	float nowwidth = 25;//(SCREEN_WIDTH-50)/4;
	float heightnow = 15;
	int counth = 0; //横
	int countv = 0; //竖
	int countfocus = (int)[focus count];
	counth = (countfocus%4==0?countfocus/4:countfocus/4+1);
	
	
	for(int i=0;i<counth;i++)
	{
		DLog(@"heightnow===%f",heightnow);
		if(i<counth-1)
		{
			countv = 4;
		}
		else
		{
			countv = countfocus%4;
		}
		nowwidth = 25;
		for(int j=0;j<countv;j++)
		{
			NSDictionary *dictemp = [focus objectAtIndex:i*4+j];
			UIButton *buttonfunction = [UIButton buttonWithType:UIButtonTypeCustom];
			buttonfunction.layer.borderColor = [UIColor clearColor].CGColor;
			buttonfunction.frame= CGRectMake(nowwidth+j*(40+widthspace), heightnow, 40, 40);
			NSURL *urlstr = [NSURL URLWithString:[dictemp objectForKey:@"pic_path"]];
			buttonfunction.tag = EnHpFunctionButtonTag+i;
			[buttonfunction addTarget:self action:@selector(clickfunction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonfunction setImageForState:UIControlStateNormal withURL:urlstr];
            //	[buttonfunction setImageForState:UIControlStateNormal withURL:urlstr];
			[self addSubview:buttonfunction];
			
			UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(buttonfunction.frame.origin.x-15, buttonfunction.frame.origin.y+buttonfunction.frame.size.height+5,buttonfunction.frame.size.width+30, 20)];
			labeltitle.text = [dictemp objectForKey:@"title"];
			labeltitle.font = FONTN(14.0f);
			labeltitle.tag = EnFocusTitleLabelTag;
			labeltitle.textAlignment = NSTextAlignmentCenter;
			labeltitle.textColor = [UIColor blackColor];
			[self addSubview:labeltitle];
			
		}
		heightnow = heightnow+40+5+20+10+10;
	}
	
	UIButton *buttonarrow = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonarrow.layer.borderColor = [UIColor clearColor].CGColor;
	buttonarrow.frame= CGRectMake((SCREEN_WIDTH-40)/2,heightnow, 40, 40);
	[buttonarrow setImage:LOADIMAGE(@"arrowup", @"png") forState:UIControlStateNormal];
	[buttonarrow addTarget:self action:@selector(foldedfunction:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonarrow];
	buttonarrow.backgroundColor = [UIColor clearColor];
	heightnow = heightnow+buttonarrow.frame.size.height+10;
	
	self.frame = CGRectMake(0, 0, SCREEN_WIDTH, heightnow);
}

-(void)foldedfunction:(id)sender
{
	UIButton *button = (UIButton *)sender;
	if(entype == EnFolded)  //当前是折叠状态
	{
		entype = EnUnFolded;
		NSArray *arraytemp = [dicfocus objectForKey:@"list"];
		if([arraytemp count] > 4)
		{
			if([self.delegate1 respondsToSelector:@selector(DGclickArrowFolded:)])
			{
				[self.delegate1 DGclickArrowFolded:entype];
			}
		}
		[button setImage:LOADIMAGE(@"arrowup", @"png") forState:UIControlStateNormal];
	}
	else if(entype == EnUnFolded) //当前是展开状态
	{
		entype = EnFolded;
		if([self.delegate1 respondsToSelector:@selector(DGclickArrowFolded:)])
		{
			[self.delegate1 DGclickArrowFolded:entype];
		}
		[button setImage:LOADIMAGE(@"arrowdown", @"png") forState:UIControlStateNormal];
	}
}

-(void)clickfunction:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnHpFunctionButtonTag;
	
	NSArray *arrayfunction = [dicfocus objectForKey:@"list"];
	NSDictionary *dictemp = [arrayfunction objectAtIndex:tagnow];
	
	if([self.delegate1 respondsToSelector:@selector(DGClickHpFunctionView:)])
	{
		[self.delegate1 DGClickHpFunctionView:dictemp];
	}
	
}

@end
