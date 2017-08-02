//
//  TuJiView.m
//  CcwbNews
//
//  Created by xyy520 on 16/6/6.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "TuJiView.h"

@implementation TuJiView

@synthesize delegate1;

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

-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic More:(NSString *)more
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        dicsrc = dic;
        [self initviewmore:dicsrc];
        
    }
    return self;
}

-(void)initviewmore:(NSDictionary *)dic
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
    
    NSArray *arraydata = [dic objectForKey:@"list"];
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 200)];
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.contentSize = CGSizeMake(160*[arraydata count]+20, 100);
    [self addSubview:scrollview];
    
    for(int i=0;i<[arraydata count];i++)
    {
        NSDictionary *dictemp = [arraydata objectAtIndex:i];
        UIView *view = [self adddatatoscrollview:dictemp Frame:CGRectMake(10+160*i, 10, 150,scrollview.frame.size.height-20) TagNow:i];
        [scrollview addSubview:view];
    }
}

-(void)initview:(NSDictionary *)dic
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
	
	NSArray *arraydata = [dic objectForKey:@"list"];
	UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 200)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsHorizontalScrollIndicator = NO;
	scrollview.showsVerticalScrollIndicator = NO;
	scrollview.contentSize = CGSizeMake(160*[arraydata count]+20, 100);
	[self addSubview:scrollview];
	
	for(int i=0;i<[arraydata count];i++)
	{
		NSDictionary *dictemp = [arraydata objectAtIndex:i];
		UIView *view = [self adddatatoscrollview:dictemp Frame:CGRectMake(10+160*i, 10, 150,scrollview.frame.size.height-20) TagNow:i];
		[scrollview addSubview:view];
	}
}

-(UIView *)adddatatoscrollview:(NSDictionary *)dic Frame:(CGRect)frame TagNow:(int)tagnow
{
	UIView *view = [[UIView alloc] initWithFrame:frame];
	view.backgroundColor = [UIColor whiteColor];
	view.layer.borderColor = COLORNOW(230, 230, 230).CGColor;
	view.layer.borderWidth = 1.0;
	
	UIImageView *imageviewpic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
	[imageviewpic setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
	imageviewpic.contentMode = UIViewContentModeScaleAspectFill;
	imageviewpic.clipsToBounds = YES;
	imageviewpic.userInteractionEnabled = YES;
	imageviewpic.tag = EnTuJiListItemImageViewTag+tagnow;
	imageviewpic.contentMode = UIViewContentModeScaleAspectFill;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
	[imageviewpic addGestureRecognizer:singleTap];
	[view addSubview:imageviewpic];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageviewpic.frame.origin.x+8, imageviewpic.frame.origin.y+imageviewpic.frame.size.height+7,imageviewpic.frame.size.width-16, 40)];
	labelname.text = [dic objectForKey:@"title"];
	labelname.font = FONTN(14.0f);
	labelname.numberOfLines = 2;
	labelname.textColor = COLORNOW(48, 48, 48);
	[view addSubview:labelname];
	
	UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(labelname.frame.origin.x, labelname.frame.origin.y+labelname.frame.size.height+5,labelname.frame.size.width, 20)];
	labeltime.text = [dic objectForKey:@"add_time"];
	labeltime.font = FONTN(14.0f);
	labeltime.textColor = COLORNOW(148, 148, 148);
	[view addSubview:labeltime];
	
	return view;
}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
	UIView *viewclick = sender.view;
	int tagnow = (int)viewclick.tag-EnTuJiListItemImageViewTag;
	if([self.delegate1 respondsToSelector:@selector(DGclickTuJiPic:)])
	{
		
		NSArray *arraydata = [dicsrc objectForKey:@"list"];
		NSDictionary *dictemp = [arraydata objectAtIndex:tagnow];
		[self.delegate1 DGclickTuJiPic:dictemp];
	}
	
}

-(void)gotomoreandmorenews:(id)sender
{
//	NSString *strmoreurl = [dicsrc objectForKey:@"more_url"];
	if([self.delegate1 respondsToSelector:@selector(DGClickMoreNewsUrl:)])
	{
		[self.delegate1 DGClickMoreNewsUrl:dicsrc];
	}
}

@end
