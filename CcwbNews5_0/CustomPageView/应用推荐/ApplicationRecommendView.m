//
//  ApplicationRecommendView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ApplicationRecommendView.h"

@implementation ApplicationRecommendView

-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dicsrc
{
	self = [super initWithFrame:frame];
	if (self)
	{
		dicdata = dicsrc;
		self.backgroundColor = COLORNOW(240, 240, 240);
		[self initview:dicsrc];
	}
	return self;
}

-(void)initview:(NSDictionary *)dicsrc
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, self.frame.size.height-3)];
	imagebg.backgroundColor = [UIColor whiteColor];
	[self addSubview:imagebg];
	
	UILabel *labelgray = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 3)];
	labelgray.backgroundColor = COLORNOW(240, 240, 240);
	[self addSubview:labelgray];
	
	UILabel *labeltypename = [[UILabel alloc] initWithFrame:CGRectMake(15, 11,150, 20)];
	labeltypename.text = [dicsrc objectForKey:@"type_name"];
	labeltypename.font = FONTN(16.0f);
	labeltypename.textColor = COLORNOW(128, 128, 128);
	[self addSubview:labeltypename];
	
	UIButton *buttonmore = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmore.layer.borderColor = [UIColor clearColor].CGColor;
	buttonmore.frame = CGRectMake(SCREEN_WIDTH-80, labeltypename.frame.origin.y-2, 75, 24);
	[buttonmore setTitle:@"更多" forState:UIControlStateNormal];
	[buttonmore setImage:LOADIMAGE(@"arrowrightred", @"png") forState:UIControlStateNormal];
	[buttonmore setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
	[buttonmore setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
	buttonmore.titleLabel.font = FONTN(15.0f);
	[buttonmore addTarget:self action:@selector(gotomoreandmorenews:) forControlEvents:UIControlEventTouchUpInside];
	[buttonmore setTitleColor:COLORNOW(128, 128, 128) forState:UIControlStateNormal];
	[self addSubview:buttonmore];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 0.5)];
	imageline.backgroundColor = COLORNOW(230, 230, 230);
	[self addSubview:imageline];
	
	NSArray *arraylist = app.arrapprecommend;//[dicsrc objectForKey:@"list"];
	UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, imageline.frame.origin.y+1, SCREEN_WIDTH, self.frame.size.height-40)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsHorizontalScrollIndicator = NO;
	scrollview.contentSize = CGSizeMake(160*[arraylist count]+10, 100);
	[self addSubview:scrollview];

	for(int i=0;i<[arraylist count];i++)
	{
		NSDictionary *dictemp = [arraylist objectAtIndex:i];
		UIView *viewapp = [self setappview:dictemp Frame:CGRectMake(10+160*i, 10, 150, scrollview.frame.size.height-20) IndexNow:i];
		[scrollview addSubview:viewapp];
	}
	
	
	
}


-(UIView *)setappview:(NSDictionary *)dic Frame:(CGRect)frame IndexNow:(int)indexnow
{
	UIView *view = [[UIView alloc] initWithFrame:frame];
	view.backgroundColor = [UIColor whiteColor];
	view.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
	view.layer.borderWidth = 1.0;
	
	UIImageView *imageviewpic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
	[imageviewpic setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"bg_pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
	imageviewpic.contentMode = UIViewContentModeScaleAspectFill;
	imageviewpic.clipsToBounds = YES;
	[view addSubview:imageviewpic];
	
	UIButton *buttonadd = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonadd.layer.borderColor = [UIColor clearColor].CGColor;
	buttonadd.frame = CGRectMake(imageviewpic.frame.size.height/2-20, imageviewpic.frame.origin.y+imageviewpic.frame.size.height-20, 40, 40);
	if([[dic objectForKey:@"checked"] isEqualToString:@"true"])
	{
		[buttonadd setImage:LOADIMAGE(@"haveapplication", @"png") forState:UIControlStateNormal];
	}
	else
	{
		[buttonadd setImage:LOADIMAGE(@"addapplication", @"png") forState:UIControlStateNormal];
	}
	buttonadd.tag = EnAppRecommendBtTag+indexnow;
	[buttonadd addTarget:self action:@selector(clickaddapplication:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:buttonadd];

	UIImageView *imageviewheader = [[UIImageView alloc] initWithFrame:CGRectMake(imageviewpic.frame.origin.x+10, buttonadd.frame.origin.y+buttonadd.frame.size.height+20, 35, 35)];
	[imageviewheader setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"logo_pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
	imageviewheader.contentMode = UIViewContentModeScaleAspectFill;
	imageviewheader.clipsToBounds = YES;
	[view addSubview:imageviewheader];
	
	UILabel *labeltypename = [[UILabel alloc] initWithFrame:CGRectMake(imageviewheader.frame.origin.x+imageviewheader.frame.size.width+5, imageviewheader.frame.origin.y-2,90, 20)];
	labeltypename.text = [dic objectForKey:@"title"];
	labeltypename.font = FONTN(14.0f);
	labeltypename.textColor = COLORNOW(128, 128, 128);
	[view addSubview:labeltypename];
	
	UILabel *labeltypesummary = [[UILabel alloc] initWithFrame:CGRectMake(labeltypename.frame.origin.x, labeltypename.frame.origin.y+labeltypename.frame.size.height-3,95, 20)];
	labeltypesummary.text = [dic objectForKey:@"summary"];
	labeltypesummary.font = FONTN(12.0f);
	labeltypesummary.adjustsFontSizeToFitWidth = YES;
	labeltypesummary.textColor = COLORNOW(128, 128, 128);
	[view addSubview:labeltypesummary];
	
	return view;
	
}

-(void)clickaddapplication:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tagnow = (int)[button tag]-EnAppRecommendBtTag;
	
	NSMutableDictionary *dictemp = [app.arrapprecommend objectAtIndex:tagnow];
	if([[dictemp objectForKey:@"checked"] isEqualToString:@"false"])
	{
		[self addappmachine:[dictemp objectForKey:@"id"] Dictemp:dictemp Button:button];
	}
	else
	{
		[self deleteappmachine:[dictemp objectForKey:@"id"] Dictemp:dictemp Button:button];
	}

}

#pragma mark interface

-(void)addappmachine:(NSString *)appid Dictemp:(NSMutableDictionary *)dictemp Button:(UIButton *)button
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_app_id"] = appid;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceAddApp ShowView:app.window alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [dictemp setObject:@"true" forKey:@"checked"];
			 [button setImage:LOADIMAGE(@"haveapplication", @"png") forState:UIControlStateNormal];
			 if([self.delegate1 respondsToSelector:@selector(DGclickAddAppMachine:)])
			 {
				 NSArray *arrayapp = [dic objectForKey:@"appList"];
				 if([arrayapp count]>0)
				 {
					 [app.arrayaddapplication addObject:[arrayapp objectAtIndex:0]];
					 [self.delegate1 DGclickAddAppMachine:[arrayapp objectAtIndex:0]];
					 
				 }
			 }
			 
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
	 }];
	
}

-(void)deleteappmachine:(NSString *)appid Dictemp:(NSMutableDictionary *)dictemp Button:(UIButton *)button
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	params[@"cw_app_id"] = appid;
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceDeleteApp ShowView:app.window alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 [dictemp setObject:@"false" forKey:@"checked"];
			 [button setImage:LOADIMAGE(@"addapplication", @"png") forState:UIControlStateNormal];
			 if([self.delegate1 respondsToSelector:@selector(DGclickAddAppMachine:)])
			 {
				 NSArray *arrayapp = [dic objectForKey:@"appList"];
				 if([arrayapp count]>0)
				 {
					 NSDictionary *dic2 = [arrayapp objectAtIndex:0];
					 for(int i=0;i<[app.arrayaddapplication count];i++)
					 {
						 NSDictionary *dic1 = [app.arrayaddapplication objectAtIndex:i];
						 if([[dic1 objectForKey:@"id"] isEqualToString:[dic2 objectForKey:@"id"]])
						 {
							 [app.arrayaddapplication removeObject:dic1];
							 [self.delegate1 DGclickAddAppMachine:[arrayapp objectAtIndex:0]];
							 break;
						 }
						 
					 }
					
					
				 }
			 }
			 
//			 if([self.delegate1 respondsToSelector:@selector(DGclickAddAppMachine:)])
//			 {
//				 [app.arrayaddapplication removeObject:sender];
//				 [arraynowapplication removeObject:sender];
//				 [self.delegate1 DGclickAddAppMachine:sender];
//				 [tableview reloadData];
//			 }

			 
		 }
		 else
		 {
			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
	 }];
	
}

-(void)gotomoreandmorenews:(id)sender
{
//	NSString *strmoreurl = [dicdata objectForKey:@"more_url"];
	if([self.delegate1 respondsToSelector:@selector(DGClickMoreNewsUrl:)])
	{
		[self.delegate1 DGClickMoreNewsUrl:dicdata];
	}
}


@end
