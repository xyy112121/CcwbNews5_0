//
//  SingleTuJiView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/7.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "SingleTuJiView.h"

@implementation SingleTuJiView

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

-(void)clickevent:(UIGestureRecognizer*)sender
{
	UIView *viewtemp = (UIView *)[sender view];
	int tagnow = (int)viewtemp.tag - EnSingleTujiItemImageViewTag;
	NSDictionary *dictemp = [[dicsrc objectForKey:@"list"] objectAtIndex:tagnow];
	if([self.delegate1 respondsToSelector:@selector(DGClickSingleTuJipic:)])
	{
		[self.delegate1 DGClickSingleTuJipic:dictemp];
	}
}

-(void)initview:(NSDictionary *)dic
{
	//	235   125
	arraydata = [[NSMutableArray alloc] init];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, self.frame.size.height-5)];
	imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 15,150, 20)];
	labelname.text = [dic objectForKey:@"type_name"];
	labelname.font = FONTN(15.0f);
	labelname.textColor = COLORNOW(153, 153, 153);
	[self addSubview:labelname];
	
	//	UIButton *buttonzhuanfa = [UIButton buttonWithType:UIButtonTypeCustom];
	//	buttonzhuanfa.frame = CGRectMake(self.frame.size.width-40, 0, 40, 40);
	//	[buttonzhuanfa setBackgroundColor:[UIColor clearColor]];
	//	[buttonzhuanfa setImage:LOADIMAGE(@"转发", @"png") forState:UIControlStateNormal];
	//	[buttonzhuanfa addTarget:self action:@selector(clickzhuanfa:) forControlEvents:UIControlEventTouchUpInside];
	//	[self addSubview:buttonzhuanfa];
	
	arraydata = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"list"]];
	
	UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 140)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsHorizontalScrollIndicator = NO;
	scrollview.showsVerticalScrollIndicator = NO;
	scrollview.delegate = self;
	scrollview.tag = 14091;
	scrollview.contentSize = CGSizeMake(243*[arraydata count]+20, 140);
	[self addSubview:scrollview];
	
	
	[self adddatatoscrollview:scrollview ArraySrc:arraydata Offset:0];
	
	UIFont *fontnow = FONTN(15.0f);
	UIFont *fonttime = FONTN(13.0f);
	if(iphone6)
	{
		fontnow = FONTN(16.0f);
		fonttime = FONTN(14.0f);
	}
	else if(iphone6p)
	{
		fontnow = FONTN(17.0f);
		fonttime = FONTN(15.0f);
	}
	
	
	NSString *texttitle = [dic objectForKey:@"title"];
	NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:fontnow,NSFontAttributeName, nil];
	CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-(labelname.frame.origin.x *2), 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;
	
	UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, scrollview.frame.origin.y+scrollview.frame.size.height+10,sizetitle.width,sizetitle.height)];
	labeltitle.text = texttitle;
	labeltitle.font = fontnow;
	labeltitle.numberOfLines = 0;
	labeltitle.adjustsFontSizeToFitWidth = YES;
	labeltitle.backgroundColor = [UIColor clearColor];
	labeltitle.textColor = COLORNOW(48, 48, 48);
	[self addSubview:labeltitle];
	
//	UIImageView *imageclock = [[UIImageView alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x, imageview.frame.origin.y+imageview.frame.size.height-15, 8, 8)];
//	imageclock.image = LOADIMAGE(@"clockicon", @"png");
//	imageclock.contentMode = UIViewContentModeScaleAspectFill;
//	imageclock.clipsToBounds = YES;
//	[self addSubview:imageclock];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x, imageview.frame.origin.y+imageview.frame.size.height-25,150, 20)];
	labeltime.text = [dic objectForKey:@"add_time"];
	labeltime.font = FONTN(14.0f);
	labeltime.textColor = COLORNOW(153, 153, 153);
	[self addSubview:labeltime];
}


-(void)reloadnewsdata:(NSArray *)arraysrc
{
	UIScrollView *scrollview = (UIScrollView *)[self viewWithTag:14091];
	[self adddatatoscrollview:scrollview ArraySrc:arraysrc Offset:scrollview.contentSize.width-20];
	scrollview.contentSize = CGSizeMake(243*[arraydata count]+20, 140);
}

-(void)adddatatoscrollview:(UIScrollView *)scrollview ArraySrc:(NSArray *)arraysrc Offset:(float)offset
{
	for(int i=0;i<[arraysrc count];i++)
	{
		NSDictionary *dicdata = [arraysrc objectAtIndex:i];
		
		UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(8+243*i+offset, 0, 235, 140)];
		[imagepic setImageWithURL:[NSURL URLWithString:[dicdata objectForKey:@"pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
		imagepic.contentMode = UIViewContentModeScaleAspectFill;
		imagepic.userInteractionEnabled = YES;
		UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickevent:)];
		[imagepic addGestureRecognizer:tapGesture];
		imagepic.tag = EnSingleTujiItemImageViewTag+i;
		
		imagepic.clipsToBounds = YES;
		[scrollview addSubview:imagepic];
		
	}
}


@end
