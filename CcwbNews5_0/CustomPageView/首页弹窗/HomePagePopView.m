//
//  HomePagePopView.m
//  CcwbNews
//
//  Created by xyy520 on 16/6/20.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "HomePagePopView.h"

@interface HomePagePopView ()

@end

@implementation HomePagePopView

//-(id)initWithFrame:(CGRect)frame Dic:(NSArray *)arrayactivity
-(id)initWithFrame:(CGRect)frame Dic:(NSDictionary *)arrayactivity
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		dicsrc = arrayactivity;
		[self initview:dicsrc];
	}
	return self;
}

//-(void)initview:(NSArray *)arr
-(void)initview:(NSDictionary *)arr
{
	
	[self adddicsrc:arr];

}

-(void)adddicsrc:(NSDictionary *)dic
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	button.backgroundColor = [UIColor blackColor];
	button.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	[button addTarget:self action:@selector(clickremovepop:) forControlEvents:UIControlEventTouchUpInside];
	button.alpha = 0.4;
	[self addSubview:button];
	
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-280)/2, (SCREEN_HEIGHT-390)/2, 280, 390)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsVerticalScrollIndicator = NO;
	scrollview.pagingEnabled = YES;
	scrollview.showsHorizontalScrollIndicator = NO;
	[self addSubview:scrollview];
	
	
	if(iphone6p)
	{
		scrollview.frame=CGRectMake((SCREEN_WIDTH-280*iphone6pratio)/2, (SCREEN_HEIGHT-390*iphone6pratio)/2, 280*iphone6pratio, 390*iphone6pratio);
	}
	else if(iphone6)
	{
		scrollview.frame=CGRectMake((SCREEN_WIDTH-280*iphone6ratio)/2, (SCREEN_HEIGHT-390*iphone6ratio)/2, 280*iphone6ratio, 390*iphone6ratio);
		
	}
	scrollview.contentSize = CGSizeMake(scrollview.frame.size.width,10);

	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollview.frame.size.width, scrollview.frame.size.height)];
	view.backgroundColor = [UIColor whiteColor];
	view.layer.cornerRadius = 4.0f;
	view.clipsToBounds = YES;
	[scrollview addSubview:view];
	
	UIImageView *imageviewpop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
	[imageviewpop setImageWithURL:URLSTRING([dic objectForKey:@"pic_path"]) placeholderImage:nil];
	imageviewpop.contentMode = UIViewContentModeScaleAspectFill;
	imageviewpop.userInteractionEnabled = YES;
	imageviewpop.layer.cornerRadius = 4.0f;
	imageviewpop.clipsToBounds = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
	[imageviewpop addGestureRecognizer:singleTap];
	imageviewpop.clipsToBounds = YES;
	[view addSubview:imageviewpop];
	
	UIButton *buttonclose = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonclose.layer.borderColor = [UIColor clearColor].CGColor;
	buttonclose.frame= CGRectMake(scrollview.frame.origin.x+scrollview.frame.size.width-40, scrollview.frame.origin.y, 40, 40);
	[buttonclose setImage:LOADIMAGE(@"关闭icon", @"png") forState:UIControlStateNormal];
	[buttonclose addTarget:self action:@selector(clickremovepop:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonclose];
}

-(void)addarraysrc:(NSArray *)arr
{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	button.backgroundColor = [UIColor blackColor];
	button.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	[button addTarget:self action:@selector(clickremovepop:) forControlEvents:UIControlEventTouchUpInside];
	button.alpha = 0.4;
	[self addSubview:button];

	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-280)/2, (SCREEN_HEIGHT-390)/2, 280, 390)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsVerticalScrollIndicator = NO;
	scrollview.pagingEnabled = YES;
	scrollview.showsHorizontalScrollIndicator = NO;
	[self addSubview:scrollview];


	if(iphone6p)
	{
		scrollview.frame=CGRectMake((SCREEN_WIDTH-280*iphone6pratio)/2, (SCREEN_HEIGHT-390*iphone6pratio)/2, 280*iphone6pratio, 390*iphone6pratio);
	}
	else if(iphone6)
	{
		scrollview.frame=CGRectMake((SCREEN_WIDTH-280*iphone6ratio)/2, (SCREEN_HEIGHT-390*iphone6ratio)/2, 280*iphone6ratio, 390*iphone6ratio);

	}
	scrollview.contentSize = CGSizeMake(scrollview.frame.size.width*4,10);
	for(int i=0;i<[arr count];i++)
	{
		NSDictionary *dictemp = [arr objectAtIndex:i];

		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollview.frame.size.width*i, 0, scrollview.frame.size.width, scrollview.frame.size.height)];
		view.backgroundColor = [UIColor whiteColor];
		view.layer.cornerRadius = 4.0f;
		view.clipsToBounds = YES;
		[scrollview addSubview:view];

		if([[dictemp objectForKey:@"type"] isEqualToString:@"1"])
		{
			YLImageView* imageView = [[YLImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.width)];
			[view addSubview:imageView];
			view.clipsToBounds = YES;
			UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
			[view addGestureRecognizer:singleTap];
			imageView.image = [YLGIFImage imageNamed:@"005.gif"];
		}
		else if([[dictemp objectForKey:@"type"] isEqualToString:@"2"])
		{

			UIImageView *imageviewpop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
			[imageviewpop setImageWithURL:URLSTRING([dictemp objectForKey:@"pic_path"]) placeholderImage:nil];
			imageviewpop.contentMode = UIViewContentModeScaleAspectFill;
			imageviewpop.userInteractionEnabled = YES;
			imageviewpop.layer.cornerRadius = 4.0f;
			imageviewpop.clipsToBounds = YES;
			UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
			[imageviewpop addGestureRecognizer:singleTap];
			imageviewpop.clipsToBounds = YES;
			[view addSubview:imageviewpop];
		}

	}

	UIButton *buttonclose = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonclose.layer.borderColor = [UIColor clearColor].CGColor;
	buttonclose.frame= CGRectMake(scrollview.frame.origin.x+scrollview.frame.size.width-40, scrollview.frame.origin.y, 40, 40);
	[buttonclose setImage:LOADIMAGE(@"关闭icon", @"png") forState:UIControlStateNormal];
	[buttonclose addTarget:self action:@selector(clickremoveiconpop:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonclose];

}


-(void)photoTappedAd:(id)sender
{
	DLog(@"123123");
	if([_delegate1 respondsToSelector:@selector(clickpoppush:)])
	{
		[_delegate1 clickpoppush:dicsrc];
	}
}

-(void)clickremovepop:(id)sender
{
//	UIButton *button = (UIButton *)sender;
//	DLog(@"=====%ld",(long)button.tag);
//	if(button.tag == HomePopBtCloseTag)
//	{
//		NSFileManager * filemanger = [NSFileManager defaultManager];
//		if([filemanger fileExistsAtPath:Has_activity])
//		{
//			NSMutableArray * closeactivity= [NSMutableArray arrayWithContentsOfFile:Has_activity];
//			NSMutableDictionary *params = [NSMutableDictionary dictionary];
//			[params setObject:[dicsrc objectForKey:@"activity_id"] forKey:@"id"];
//			[closeactivity addObject:params];
//			[closeactivity writeToFile:Has_activity atomically:NO];
//		}
//		else
//		{
//			NSMutableArray * closeactivity= [[NSMutableArray alloc] init];
//			
//			NSMutableDictionary *params = [NSMutableDictionary dictionary];
//			[params setObject:[dicsrc objectForKey:@"activity_id"] forKey:@"id"];
//			[closeactivity addObject:params];
//			[closeactivity writeToFile:Has_activity atomically:NO];
//		}
//	}
//	
//	if([_delegate1 respondsToSelector:@selector(removehomepagepop:)])
//	{
//		[_delegate1 removehomepagepop:sender];
//	}
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
