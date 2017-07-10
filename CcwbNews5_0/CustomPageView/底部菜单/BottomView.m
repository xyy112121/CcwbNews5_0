//
//  BottomView.m
//  CcwbNews
//
//  Created by xyy520 on 16/4/27.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "BottomView.h"
@implementation BottomView
@synthesize delegate1;
@synthesize scrollview;
-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = COLORNOW(245, 245, 245);
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		[self initview];
	}
	return self;
}

-(void)initview
{
	//前面固定的按钮
	float nowwidth = SCREEN_WIDTH/5;
	for(int i=0;i<[app.arrayfixedapplication count];i++)
	{
		UIView *view;
		NSDictionary *dictemp = [app.arrayfixedapplication objectAtIndex:i];
		view = [self applicationleftcell:nil Frame:CGRectMake(i*nowwidth, 0, nowwidth, self.frame.size.height) SelectedId:[dictemp objectForKey:@"id"] Nindex:i AddApp:dictemp];
		[self addSubview:view];
	}
	
	//scrollview添加到固定的位置后面
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake([app.arrayfixedapplication count]*nowwidth, 0, SCREEN_WIDTH/5*4-[app.arrayfixedapplication count]*nowwidth, 47)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsVerticalScrollIndicator = NO;
	scrollview.showsHorizontalScrollIndicator = NO;
	[scrollview setContentSize:CGSizeMake(SCREEN_WIDTH/5*([app.arrayaddapplication count]+1), 47)];
	[self addSubview:scrollview];
//	if([app.arrayaddapplication count]>0)
//	{
		[self addapplication:@""]; //第一次的时候，不需要
		
//		
//	}
	//最右边的添加按钮
	UIView *rightbt = [self addrightaddapplicationbt:nil Frame:CGRectMake(SCREEN_WIDTH/5*4, 0, SCREEN_WIDTH/5, self.frame.size.height)];
	[self addSubview:rightbt];
}

-(void)againarrangement:(NSString *)strid
{
	for(UIView *view in [scrollview subviews])
	{
		[view removeFromSuperview];
	}
	
	[self addapplication:strid];
	[scrollview setContentSize:CGSizeMake(SCREEN_WIDTH/5*([app.arrayaddapplication count]+1), 47)];
}

//最右边的添加应用按钮
-(UIView *)addrightaddapplicationbt:(id)sender Frame:(CGRect)rect
{
	UIView *view = [[UIView alloc] initWithFrame:rect];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 1, rect.size.height-20)];
	imageline.backgroundColor = COLORNOW(208, 208, 208);
	[view addSubview:imageline];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((rect.size.width-20)/2, 8, 20, 20)];
	imageview.image = LOADIMAGE(@"addappicon", @"png");
	[view addSubview:imageview];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height-14,view.frame.size.width, 16)];
	labelname.text = @"添加应用";
	labelname.font = FONTLIGHT(10.0f);
	
	labelname.textColor = COLORNOW(121, 121, 121);
	labelname.textAlignment = NSTextAlignmentCenter;
	[view addSubview:labelname];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	button.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
	[button setBackgroundColor:[UIColor clearColor]];
	button.tag = EnAddApplicationRightBtTag;
	[button addTarget:self action:@selector(clickbt:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:button];
	return view;
}



//scrollview上的的添加应用按钮
-(UIView *)addscrollviewaddappbt:(id)sender Frame:(CGRect)rect
{
	UIView *view = [[UIView alloc] initWithFrame:rect];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((rect.size.width-20)/2, 8, 20, 20)];
	imageview.image = LOADIMAGE(@"addappicon2", @"png");
	[view addSubview:imageview];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height-14,view.frame.size.width, 16)];
	labelname.text = @"添加";
	labelname.font = FONTLIGHT(10.0f);
	labelname.textColor = COLORNOW(121, 121, 121);
	labelname.textAlignment = NSTextAlignmentCenter;
	[view addSubview:labelname];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	button.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
	[button setBackgroundColor:[UIColor clearColor]];
	button.tag = EnAddApplicationScrollviewRightBtTag;
	[button addTarget:self action:@selector(clickbt:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:button];
	return view;
	
}

-(void)addapplication:(NSString *)sender
{
	float nowwidth = SCREEN_WIDTH/5;
	
	for(int i=0;i<[app.arrayaddapplication count];i++)
	{
		UIView *view;
		NSDictionary *dictemp = [app.arrayaddapplication objectAtIndex:i];
		view = [self applicationcell:nil Frame:CGRectMake(i*nowwidth, 0, nowwidth, self.frame.size.height) SelectedId:sender	Nindex:i AddApp:dictemp];
		[scrollview addSubview:view];
	}

	//scrollview的添加应用按钮
	UIView *viewadd = [self addscrollviewaddappbt:nil Frame:CGRectMake(SCREEN_WIDTH/5*([app.arrayaddapplication count]), 0, SCREEN_WIDTH/5, scrollview.frame.size.height)];
	[scrollview addSubview:viewadd];
	
}

//左边固定的按钮
-(UIView *)applicationleftcell:(id)sender Frame:(CGRect)rect SelectedId:(NSString *)selectedid Nindex:(int)nindex AddApp:(NSDictionary *)dicapp
{
	UIView *view = [[UIView alloc] initWithFrame:rect];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((rect.size.width-23)/2, 8, 23, 23)];
	imageview.alpha = 0.7;
	if(([[dicapp objectForKey:@"id"] isEqualToString:selectedid])&&nindex==0)
	{
		imageview.alpha = 1.0;
		imageview.frame = CGRectMake((rect.size.width-30)/2, 5, 30, 30);
	}
	imageview.tag = EnBottomApplicationLeftFixedImageviewTag+nindex;
	[view addSubview:imageview];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height-14,view.frame.size.width, 16)];
	labelname.text = [dicapp objectForKey:@"name"];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.font = FONTLIGHT(10.0f);
	labelname.textColor = COLORNOW(121, 121, 121);
	labelname.textAlignment = NSTextAlignmentCenter;
	[view addSubview:labelname];
	
	imageview.image = LOADIMAGE(@"春城晚报icon", @"png");

	DLog(@"NSURL URLWithString:[dicapp objectForKey===%@",[NSURL URLWithString:[dicapp objectForKey:@"logo_pic_path"]]);
	[imageview setImageWithURL:[NSURL URLWithString:[dicapp objectForKey:@"logo_pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
	labelname.text = [dicapp objectForKey:@"name"];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	button.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
	[button setBackgroundColor:[UIColor clearColor]];
	button.tag = nindex+EnAddApplicationLeftFixedBtTag;
	[button addTarget:self action:@selector(clickbt:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:button];
	return view;
}

//scrollview滚动上的application
-(UIView *)applicationcell:(id)sender Frame:(CGRect)rect SelectedId:(NSString *)selectedid Nindex:(int)nindex AddApp:(NSDictionary *)dicapp
{
	UIView *view = [[UIView alloc] initWithFrame:rect];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((rect.size.width-23)/2, 8, 23, 23)];
	imageview.alpha = 0.7;
	if([[dicapp objectForKey:@"id"] isEqualToString:selectedid])
	{
		imageview.alpha = 1.0;
		imageview.frame = CGRectMake((rect.size.width-30)/2, 5, 30, 30);
	}
	imageview.tag = EnBottomApplicationImageviewTag+nindex;
	[view addSubview:imageview];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height-14,view.frame.size.width, 16)];
	labelname.text = [dicapp objectForKey:@"name"];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.font = FONTLIGHT(10.0f);
	labelname.textColor = COLORNOW(121, 121, 121);
	labelname.textAlignment = NSTextAlignmentCenter;
	[view addSubview:labelname];
	
	imageview.image = LOADIMAGE(@"春城晚报icon", @"png");
	

	DLog(@"NSURL URLWithString:[dicapp objectForKey===%@",[NSURL URLWithString:[dicapp objectForKey:@"logo_pic_path"]]);
	[imageview setImageWithURL:[NSURL URLWithString:[dicapp objectForKey:@"logo_pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
	labelname.text = [dicapp objectForKey:@"name"];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	button.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
	[button setBackgroundColor:[UIColor clearColor]];
	button.tag = nindex+EnBottomApplicationBtTag;
	[button addTarget:self action:@selector(clickbt:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:button];
	return view;
}

-(void)clickbt:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagcha = (int)[button tag]-EnAddApplicationLeftFixedBtTag;
	//添加 应用 最右边 的固定按钮
	if([button tag] == EnAddApplicationRightBtTag)
	{
		for(int i=0;i<[app.arrayaddapplication count];i++)
		{
			UIImageView *imageview = [scrollview viewWithTag:EnBottomApplicationImageviewTag+i];
			[UIView transitionWithView:imageview duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				imageview.frame = CGRectMake((SCREEN_WIDTH/5-23)/2, 8, 23, 23);
				imageview.alpha = 0.7;
			} completion:^(BOOL finished) {
				//finished判断动画是否完成
				if (finished) {
					
				}
			}];
		}
		if([self.delegate1 respondsToSelector:@selector(DGclickAddApplication:)])
		{
			[self.delegate1 DGclickAddApplication:1];//点击最右边的添加应用
		}
	}
	else if([button tag] == EnAddApplicationScrollviewRightBtTag)
	{
		for(int i=0;i<[app.arrayaddapplication count];i++)
		{
			UIImageView *imageview = [scrollview viewWithTag:EnBottomApplicationImageviewTag+i];
			[UIView transitionWithView:imageview duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				imageview.frame = CGRectMake((SCREEN_WIDTH/5-23)/2, 8, 23, 23);
				imageview.alpha = 0.7;
			} completion:^(BOOL finished) {
				//finished判断动画是否完成
				if (finished) {
					
				}
			}];
		}
		if([self.delegate1 respondsToSelector:@selector(DGclickAddApplication:)])
		{
			[self.delegate1 DGclickAddApplication:2];//点击最右边的添加应用
		}
	}
	else if(tagcha<5 && tagcha > -1)
	{
		//将之前 的全部变小
		for(int i=0;i<[app.arrayfixedapplication count];i++)
		{
			UIImageView *leftimage = [self viewWithTag:EnBottomApplicationLeftFixedImageviewTag+i];
			[UIView transitionWithView:leftimage duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				leftimage.frame = CGRectMake((SCREEN_WIDTH/5-23)/2, 8, 23, 23);
				leftimage.alpha = 0.7;
			} completion:^(BOOL finished) {
				//finished判断动画是否完成
				if (finished) {
					
				}
			}];
		}
		
		
		int tagnow = (int)[button tag]-EnAddApplicationLeftFixedBtTag;
		NSDictionary *dicselectclick = [app.arrayfixedapplication objectAtIndex:tagnow];
		[delegate1 DGclickApplicationItem:dicselectclick];
		
		UIImageView *clickimage = [self viewWithTag:EnAddApplicationLeftFixedBtTag+100+tagnow];
		
		for(int i=0;i<[app.arrayaddapplication count];i++)
		{
			UIImageView *imageview = [scrollview viewWithTag:EnBottomApplicationImageviewTag+i];
			[UIView transitionWithView:imageview duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				imageview.frame = CGRectMake((SCREEN_WIDTH/5-23)/2, 8, 23, 23);
				imageview.alpha = 0.7;
				clickimage.frame = CGRectMake((SCREEN_WIDTH/5-30)/2, 5, 30, 30);
				clickimage.alpha = 1;
			} completion:^(BOOL finished) {
				//finished判断动画是否完成
				if (finished) {
					
				}
			}];
		}
	}
	else
	{
		//已添加的应用依次
		int tagnow = (int)[button tag]-EnBottomApplicationBtTag;
		NSDictionary *dicselectclick = [app.arrayaddapplication objectAtIndex:tagnow];
		[delegate1 DGclickApplicationItem:dicselectclick];
		
		
		UIImageView *clickimage = [scrollview viewWithTag:EnBottomApplicationBtTag+100+tagnow];
		for(int i=0;i<[app.arrayaddapplication count];i++)
		{
			UIImageView *imageview = [scrollview viewWithTag:EnBottomApplicationImageviewTag+i];
			[UIView transitionWithView:imageview duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				imageview.frame = CGRectMake((SCREEN_WIDTH/5-23)/2, 8, 23, 23);
				imageview.alpha = 0.7;
				clickimage.frame = CGRectMake((SCREEN_WIDTH/5-30)/2, 5, 30, 30);
				clickimage.alpha = 1;
			} completion:^(BOOL finished) {
				//finished判断动画是否完成
				if (finished) {
					
				}
			}];
		}
		for(int i=0;i<[app.arrayfixedapplication count];i++)
		{
			UIImageView *leftimage = [self viewWithTag:EnBottomApplicationLeftFixedImageviewTag+i];
			[UIView transitionWithView:leftimage duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
				leftimage.frame = CGRectMake((SCREEN_WIDTH/5-23)/2, 8, 23, 23);
				leftimage.alpha = 0.7;
			} completion:^(BOOL finished) {
				//finished判断动画是否完成
				if (finished) {
					
				}
			}];
		}
	}
}

@end
