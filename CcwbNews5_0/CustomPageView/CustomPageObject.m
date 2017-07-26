//
//  CustomPageObject.m
//  CcwbNews
//
//  Created by xyy520 on 16/6/13.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "CustomPageObject.h"
#import "sys/utsname.h"
#import "Reachability.h"
#import "DiscorverView.h"
#import "CustomNewsView.h"
#import "PopularizeView.h"
#import "BurstNewsView.h"
#import "CcwbNewsSaidView.h"
#import "TuJiView.h"
#import <CommonCrypto/CommonDigest.h>
@implementation CustomPageObject

+(NSMutableArray *)computeheight:(NSDictionary *)dic ArrayHeght:(NSMutableArray *)arrayheight
{
	for(int i=0;i<[(NSArray *)[dic objectForKey:@"newsList"] count];i++)
	{
		NSDictionary *dictemp = [[dic objectForKey:@"newsList"] objectAtIndex:i];
		NSString *strtype = [dictemp objectForKey:@"show_type"];
		if([strtype isEqualToString:TYNormal])  //普通新闻列表
		{
			float nowheight = SCREEN_WIDTH/3;
			UIView *customnews = [[CustomNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp];
			[arrayheight addObject:[NSString stringWithFormat:@"%f",customnews.frame.size.height]];
		}
		else if([strtype isEqualToString:TYImageText]) //图文 视频，直播，活动，发现
		{
			float nowheight = 260;
			if(iphone6p)
				nowheight = 260*iphone6pratio;
			else if(iphone6)
				nowheight = 260*iphone6ratio;
			UIView *discoryview = [[DiscorverView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp];
			[arrayheight addObject:[NSString stringWithFormat:@"%f",discoryview.frame.size.height]];
		}
		else if([strtype isEqualToString:TYImage]) //推广，广告
		{
			float nowheight = 150;
			if(iphone6p)
				nowheight = 150*iphone6pratio;
			else if(iphone6)
				nowheight = 150*iphone6ratio;
			UIView *popularizeview = [[PopularizeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp];
			[arrayheight addObject:[NSString stringWithFormat:@"%f",popularizeview.frame.size.height]];
		}
		else if([strtype isEqualToString:TYSudden]) //突发
		{
			UIView *burstnews = [[BurstNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 417) Dicsrc:dictemp];
			[arrayheight addObject:[NSString stringWithFormat:@"%f",burstnews.frame.size.height]];
		}
		else if([strtype isEqualToString:TYHorizontal]) //晚报说，横向滑动
		{
			UIView *ccwbnews = [[CcwbNewsSaidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 255) Dicsrc:dictemp];
			[arrayheight addObject:[NSString stringWithFormat:@"%f",ccwbnews.frame.size.height]];
		}
		else if([strtype isEqualToString:TYImageArray]) //图集
		{
			UIView *ccwbnews = [[TuJiView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 255) Dicsrc:dictemp];
			[arrayheight addObject:[NSString stringWithFormat:@"%f",ccwbnews.frame.size.height]];
		}
		else if([strtype isEqualToString:TYActivity])
		{
			float nowheight = 200;
			if(iphone6p)
				nowheight = 200*iphone6pratio;
			else if(iphone6)
				nowheight = 200*iphone6ratio;
			
			UIView *discoryview = [[ActivityNow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp];
			[arrayheight addObject:[NSString stringWithFormat:@"%f",discoryview.frame.size.height]];
		}
		
	}
	
	return arrayheight;
}

+(NSString *)computeheight:(NSDictionary *)dic
{
	NSString *strheght=@"0";
	if([[dic objectForKey:@"show_type"] isEqualToString:TYStock])
	{
		float nowheight = 70;
		if(iphone6p)
			nowheight = 70*iphone6pratio;
		else if(iphone6)
			nowheight = 70*iphone6ratio;
		
		SecuritiesView *discoryview = [[SecuritiesView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dic];
		strheght = [NSString stringWithFormat:@"%f",discoryview.frame.size.height];
	}

	
	return strheght;
}


+(void)adddefaultpath
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	UIView *viewdefault = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	viewdefault.backgroundColor = [UIColor whiteColor];
	viewdefault.tag = EnHomePopAdViewTag;
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	imageview.contentMode = UIViewContentModeScaleAspectFill;
	imageview.clipsToBounds = YES;
	imageview.tag = EnHomePOPAdImageViewTag;
	if(iphone6p)
		imageview.image = LOADIMAGE(@"default_2208", @"png");
	else if(iphone6)
		imageview.image = LOADIMAGE(@"default_1334", @"png");
	else if(iphone5)
		imageview.image = LOADIMAGE(@"default_1136", @"png");
	else
		imageview.image = LOADIMAGE(@"default_960", @"png");
	[viewdefault addSubview:imageview];
	
	UIButton *buttonjump = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonjump.layer.borderColor = [UIColor clearColor].CGColor;
	buttonjump.frame = CGRectMake(SCREEN_WIDTH-80, 30, 70, 26);
	buttonjump.layer.cornerRadius = 13.0f;
	buttonjump.clipsToBounds = YES;
	buttonjump.titleLabel.font = FONTN(15.0f);
	[buttonjump setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttonjump.tag = EnHomePopAdTimeLabelTag;
	[buttonjump setBackgroundColor:COLORNOW(200, 200, 200)];
	[buttonjump setTitle:@"跳过" forState:UIControlStateNormal];
	buttonjump.alpha = 0;
	[viewdefault addSubview:buttonjump];
	
	if([app.window viewWithTag:EnGuideViewTag] == nil)
	{
		[app.window addSubview:viewdefault];
	}
}

+(void)CUgetUserInfo:(AppDelegate *)app StrJson:(NSString *)strjson
{
	if (![strjson isKindOfClass:[NSString class]]) {
		return;
	}
	strjson = [strjson  stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
	NSData *data = [strjson dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *tempdic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	DLog(@"userinfo====%@",tempdic);

	NSString *userid = [tempdic objectForKey:@"user_id"];
	NSString *username = [tempdic objectForKey:@"name"];
	NSString *userheader = [tempdic objectForKey:@"head_pic_path"];
	NSString *userheaderbg = [tempdic objectForKey:@"bg_pic_path"];
	NSString *tel = [tempdic objectForKey:@"tel"];
	NSDictionary *userdic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid, username,userheader,userheaderbg,tel,@"1", nil] forKeys:[NSArray arrayWithObjects:@"userid", @"username", @"head_pic_path",@"bg_pic_path", @"usertel", @"userstate", nil]];
	app.userinfo.userid = userid;
	app.userinfo.username = username;
	app.userinfo.userheader = userheader;
	app.userinfo.usertel = tel;
	app.userinfo.userstate = @"1";

	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:userdic forKey:DefaultUserInfo];
	[userDefaults synchronize];
}

+(void)ClickWebAddApplication:(AppDelegate *)app StrJson:(NSString *)strjson
{
	if (![strjson isKindOfClass:[NSString class]]) {
		return;
	}
	
	NSData *data = [strjson dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *tempdic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	DLog(@"userinfo====%@",tempdic);
	
//	NSString *sid = [tempdic objectForKey:@"user_id"];
//	NSString *logo_pic_path = [tempdic objectForKey:@"name"];
//	NSString *name = [tempdic objectForKey:@"head_pic_path"];
//	NSString *sort_index = [tempdic objectForKey:@"bg_pic_path"];
//	NSString *type = [tempdic objectForKey:@"tel"];
//	NSString *url = [tempdic objectForKey:@"tel"];
//	NSDictionary *userdic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userid, username,userheader,userheaderbg,tel,@"1", nil] forKeys:[NSArray arrayWithObjects:@"id", @"logo_pic_path", @"name",@"sort_index", @"type", @"url", nil]];


}


+(NSString *)getrequesturlstring:(NSString *)strsrc App:(AppDelegate *)app
{
	NSString *requeststring = strsrc;
	if([requeststring rangeOfString:@"?"].location !=NSNotFound)
	{
		requeststring = [NSString stringWithFormat:@"%@&cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requeststring,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid];
	}
	else
	{
		requeststring = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requeststring,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid];
	}
	
	return requeststring;
}

+(NSString*)DataTOjsonString:(id)object
{
	NSString *jsonString = nil;
	NSError *error;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
													   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
														 error:&error];
	if (! jsonData) {
		NSLog(@"Got an error: %@", error);
	} else {
		jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
	}
	return jsonString;
}

+ (NSString*)convertToJSONData:(id)infoDict
{
	NSError *error;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
													   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
														 error:&error];
	
	NSString *jsonString = @"";
	
	if (! jsonData)
	{
		NSLog(@"Got an error: %@", error);
	}else
	{
		jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
	}
	
	jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
	
	[jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	
	return jsonString;
}

@end
