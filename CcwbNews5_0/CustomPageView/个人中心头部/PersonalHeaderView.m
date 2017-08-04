//
//  PersonalHeaderView.m
//  CcwbNews
//
//  Created by xyy520 on 16/5/5.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "PersonalHeaderView.h"
@implementation PersonalHeaderView
@synthesize delegate1;

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor whiteColor];
		[self initview];
//		if([AddInterface judgeislogin])
//			[self clickgetuserinfo:app.userinfo.userid];
	}
	return self;
}

-(void)initview
{
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
	if([AddInterface judgeislogin])
        [imageview setImageWithURL:URLSTRING(app.userinfo.userheader) placeholderImage:LOADIMAGE(@"p_头像登录_icon", @"png")];
	else
		[imageview setImageWithURL:URLSTRING(app.userinfo.userheader) placeholderImage:LOADIMAGE(@"p_头像登录_icon", @"png")];
	imageview.contentMode = UIViewContentModeScaleAspectFill;
	imageview.clipsToBounds = YES;
	imageview.tag = EnPersonHeaderImageViewBgTag;
	[self addSubview:imageview];
	
	UIImageView *redbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
	redbg.backgroundColor = COLORNOW(232, 56, 47);
	redbg.alpha = 0.8;
	[self addSubview:redbg];
	
	UIImageView *imageviewheader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
	if([AddInterface judgeislogin])
		[imageviewheader setImageWithURL:URLSTRING(app.userinfo.userheader) placeholderImage:LOADIMAGE(@"p_头像登录_icon", @"png")];
	else
		[imageviewheader setImageWithURL:URLSTRING(app.userinfo.userheader) placeholderImage:LOADIMAGE(@"p_头像登录_icon", @"png")];
	imageviewheader.layer.cornerRadius = 33;
	imageviewheader.center = CGPointMake(SCREEN_WIDTH/2,90);
	imageviewheader.contentMode = UIViewContentModeScaleAspectFill;
	imageviewheader.clipsToBounds = YES;
	imageviewheader.tag = EnPersonHeaderImageViewTag;
	imageview.userInteractionEnabled = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
	[imageview addGestureRecognizer:singleTap];
	[self addSubview:imageviewheader];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewheader.frame.origin.x-20, imageviewheader.frame.origin.y+imageviewheader.frame.size.height+10,imageviewheader.frame.size.width+40, 20)];
	if([AddInterface judgeislogin])
	{
		labelname.text = app.userinfo.username;
	}
	else
	{
		labelname.text = @"点击头像登录";
	}
	labelname.tag = EnPersonHeaderNameTag;
	labelname.font = FONTN(16.0f);
	labelname.textColor = [UIColor whiteColor];
	labelname.textAlignment = NSTextAlignmentCenter;
	[self addSubview:labelname];
	
	//天气
	UILabel *labeldu = [[UILabel alloc] initWithFrame:CGRectMake(20, imageviewheader.frame.origin.y+20,imageviewheader.frame.origin.x-40, 40)];
	labeldu.text = @"";
	labeldu.font = FONTLIGHT(20.0f);
	labeldu.adjustsFontSizeToFitWidth = YES;
	labeldu.tag = EnGetWeatherInfoLabelTag1;
	labeldu.textAlignment = NSTextAlignmentCenter;
	labeldu.textColor = [UIColor whiteColor];
	[self addSubview:labeldu];
	
	
	UILabel *labeltianqi = [[UILabel alloc] initWithFrame:CGRectMake(imageviewheader.frame.origin.x+imageviewheader.frame.size.width+20, labeldu.frame.origin.y,SCREEN_WIDTH-imageviewheader.frame.origin.x-imageviewheader.frame.size.width-40, 40)];
	labeltianqi.text = @"";
	labeltianqi.font = FONTLIGHT(16.0f);
	labeltianqi.tag = EnGetWeatherInfoLabelTag2;
	labeltianqi.textAlignment = NSTextAlignmentCenter;
	labeltianqi.textColor = [UIColor whiteColor];

	[self addSubview:labeltianqi];
	
	//按钮
	float nowwidth = SCREEN_WIDTH/4;
	for(int i=0;i<4;i++)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.layer.borderColor = [UIColor clearColor].CGColor;
		button.frame = CGRectMake(nowwidth*i, imageview.frame.origin.y+imageview.frame.size.height, nowwidth, 70);
		[button setBackgroundColor:[UIColor whiteColor]];
		[button setTitleColor:COLORNOW(105, 105, 105) forState:UIControlStateNormal];
		[button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -34, 0)];
		button.titleLabel.font = FONTN(15.0f);
		button.tag = EnPersonModelBtTag+i;
		[button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
		[button addTarget:self action:@selector(clickbt:) forControlEvents:UIControlEventTouchUpInside];
		UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake((button.frame.size.width/2-15)+button.frame.size.width*i, button.frame.origin.y+9, 30, 30)];
		imageviewicon.tag = EnPersonModelImageViewTag+i;
		switch (i)
		{
			case 0:
				[button setTitle:@"收藏" forState:UIControlStateNormal];
				imageviewicon.image = LOADIMAGE(@"my_收藏icon", @"png");
				break;
			case 1:
				[button setTitle:@"评论" forState:UIControlStateNormal];
				imageviewicon.image = LOADIMAGE(@"my_评论icon", @"png");
				break;
			case 2:
				[button setTitle:@"问吧" forState:UIControlStateNormal];
				imageviewicon.image = LOADIMAGE(@"my_问吧icon", @"png");
				break;
			case 3:
				[button setTitle:@"应用" forState:UIControlStateNormal];
				imageviewicon.image = LOADIMAGE(@"my_应用icon", @"png");
				break;

		}
		[self addSubview:button];
		[self addSubview:imageviewicon];
	}
	
	for(int i=0;i<4;i++)
	{
		UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(nowwidth*(i+1), imageview.frame.origin.y+imageview.frame.size.height, 1, 70)];
		imageline.backgroundColor = COLORNOW(240, 240, 240);
		[self addSubview:imageline];
	}
	[self getwetherinfo:app.diliweizhi.dilicity];
	
	UIImageView *imagelinever = [[UIImageView alloc] initWithFrame:CGRectMake(0,imageview.frame.origin.y+imageview.frame.size.height+70, SCREEN_WIDTH, 1)];
	imagelinever.backgroundColor = COLORNOW(240, 240, 240);
	[self addSubview:imagelinever];

	UIImageView *imagegray = [[UIImageView alloc] initWithFrame:CGRectMake(0,imagelinever.frame.origin.y+imagelinever.frame.size.height, SCREEN_WIDTH, 3)];
	imagegray.backgroundColor = COLORNOW(240, 240, 240);
	[self addSubview:imagegray];
	
}


-(void)refreshhotred:(NSDictionary *)dicsrc
{
	UIImageView *imageview1 = [self viewWithTag:EnPersonHeaderImageViewBgTag];
	UIImageView *imageview2 = [self viewWithTag:EnPersonHeaderImageViewTag];
	UILabel *labelname = [self viewWithTag:EnPersonHeaderNameTag];
	[imageview1 setImageWithURL:URLSTRING([dicsrc objectForKey:@"bg_pic_path"]) placeholderImage:LOADIMAGE(@"p_头像登录_icon", @"png")];
	[imageview2 setImageWithURL:URLSTRING([dicsrc objectForKey:@"head_pic_path"]) placeholderImage:LOADIMAGE(@"p_头像登录_icon", @"png")];
	labelname.text =  [dicsrc objectForKey:@"name"];
	
	
	for(int i=0;i<4;i++)
	{
		UIImageView *imageviewicon = [self viewWithTag:EnPersonModelImageViewTag+i];
		switch (i)
		{
			case 0:
				if([[dicsrc objectForKey:@"collection"] isEqualToString:@"true"])
					imageviewicon.image = LOADIMAGE(@"my_收藏redicon", @"png");
				else
					imageviewicon.image = LOADIMAGE(@"my_收藏icon", @"png");
				break;
			case 1:
				if([[dicsrc objectForKey:@"collection"] isEqualToString:@"true"])
					imageviewicon.image = LOADIMAGE(@"my_评论redicon", @"png");
				else
					imageviewicon.image = LOADIMAGE(@"my_评论icon", @"png");
				
				break;
			case 2:
				if([[dicsrc objectForKey:@"collection"] isEqualToString:@"true"])
					imageviewicon.image = LOADIMAGE(@"my_问吧redicon", @"png");
				else
					imageviewicon.image = LOADIMAGE(@"my_问吧icon", @"png");
				
				break;
			case 3:
				if([[dicsrc objectForKey:@"collection"] isEqualToString:@"true"])
					imageviewicon.image = LOADIMAGE(@"my_应用redicon", @"png");
				else
					imageviewicon.image = LOADIMAGE(@"my_应用icon", @"png");
				break;
				
		}
	}
}

-(void)getwetherinfo:(NSString *)userid
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	
	[RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceGetWeatherInfo ShowView:app.window alwaysdo:^
	 {
		 
	 }
	 Success:^(NSDictionary *dic)
	 {
		 DLog(@"dic====%@",dic);
		 if([[dic objectForKey:@"success"] isEqualToString:@"true"])
		 {
			 UILabel *label1 = (UILabel *)[self viewWithTag:EnGetWeatherInfoLabelTag1];
			 label1.text = [[dic objectForKey:@"data"] objectForKey:@"temperature"];
			 
			 UILabel *label2 = (UILabel *)[self viewWithTag:EnGetWeatherInfoLabelTag2];
			 label2.text = [[dic objectForKey:@"data"] objectForKey:@"weather"];
		 }
		 else
		 {
//			 [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
		 }
	 } Failur:^(NSString *strmsg) {
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
	 }];

}

-(void)clickbt:(id)sender
{
	if([AddInterface judgeislogin])
	{
		UIButton *button = (UIButton *)sender;
		int tagnow = (int)[button tag]-EnPersonModelBtTag;
		if([delegate1 respondsToSelector:@selector(clickusermenu:)])
		{
			[delegate1 clickusermenu:tagnow];
		}
	}
	else if([delegate1 respondsToSelector:@selector(DGclickpersonlogin:)])
	{
		[delegate1 DGclickpersonlogin:nil];
	}
}

-(void)photoTappedAd:(id)sender
{
	if([delegate1 respondsToSelector:@selector(DGclickpersonlogin:)])
	{
		[delegate1 DGclickpersonlogin:nil];
	}
	
}



@end
