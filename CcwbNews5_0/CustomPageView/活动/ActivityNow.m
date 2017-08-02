//
//  ActivityNow.m
//  CcwbNews
//
//  Created by xyy520 on 16/6/27.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "ActivityNow.h"
#import "Header.h"
@implementation ActivityNow

-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic
{
	self = [super initWithFrame:frame];
	if (self)
	{
		float nowheight = 240;
		if(iphone6p)
			nowheight = 240*iphone6pratio;
		else if(iphone6)
			nowheight = 240*iphone6ratio;
		
		self.frame = CGRectMake(0, 0, SCREEN_WIDTH, nowheight);
		self.backgroundColor = [UIColor whiteColor];
		dicsrc = dic;
		[self initview:dicsrc];
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic TypeActivity:(NSString *)typemore
{
    self = [super initWithFrame:frame];
    if (self)
    {
        float nowheight = 240;
        if(iphone6p)
            nowheight = 240*iphone6pratio;
        else if(iphone6)
            nowheight = 240*iphone6ratio;
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, nowheight);
        self.backgroundColor = [UIColor whiteColor];
        dicsrc = dic;
        [self initviewmore:dicsrc];
    }
    return self;
}


-(void)initview:(NSDictionary *)dicdata
{
	UILabel *labelgray = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 3)];
	labelgray.backgroundColor = COLORNOW(240, 240, 240);
	[self addSubview:labelgray];
	
	UILabel *labeltypename = [[UILabel alloc] initWithFrame:CGRectMake(15, 11,150, 20)];
	labeltypename.text = [dicdata objectForKey:@"type_name"];
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
	
	UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, self.frame.size.height-40)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsHorizontalScrollIndicator = NO;
	scrollview.pagingEnabled = YES;
	[self addSubview:scrollview];
	
	DLog(@"scrollview====%f",scrollview.frame.size.height);
	
	float nowheight = 140;
	UIFont *fontnow = FONTN(15.0f);
	if(iphone6)
	{
		nowheight = 150*(iphone6ratio);
		fontnow = FONTN(16.0f);
	}
	else if(iphone6p)
	{
		nowheight = 150*(iphone6pratio);
		fontnow = FONTN(17.0f);
	}
	
	
	
	NSArray *arrayactivity = [dicdata objectForKey:@"list"];
	scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*[arrayactivity count], 100);
	for(int i=0;i<[arrayactivity count];i++)
	{
		NSDictionary *dictemp = [arrayactivity objectAtIndex:i];
		
		NSString *picpath = [dicdata objectForKey:@"pic_path"];
		if([[picpath lastPathComponent] isEqualToString:@"gif"])
		{
			YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0,self.frame.size.width, nowheight)];
			[scrollview addSubview:imageViewgif];
			imageViewgif.tag = EnYLImageViewTag;
			imageViewgif.image = [YLGIFImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dicdata objectForKey:@"pic_path"]]]];
			
		}
		else
		{
			UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, self.frame.size.width, nowheight)];
			[imagepic setImageWithURL:[NSURL URLWithString:[dictemp objectForKey:@"pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
			imagepic.contentMode = UIViewContentModeScaleAspectFill;
			imagepic.clipsToBounds = YES;
			imagepic.userInteractionEnabled = YES;
			imagepic.tag = EnActivityImageviewTag+i;
			UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
			[imagepic addGestureRecognizer:singleTap];
			[scrollview addSubview:imagepic];
		}

		NSString *texttitle = [dictemp objectForKey:@"title"];
		NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:fontnow,NSFontAttributeName, nil];
		CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(self.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;

		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i+15, nowheight+6,sizetitle.width,sizetitle.height)];
		if(iphone6)
			labeltitle.frame = CGRectMake(SCREEN_WIDTH*i+15, nowheight+7,sizetitle.width,sizetitle.height);
		else if(iphone6p)
			labeltitle.frame = CGRectMake(SCREEN_WIDTH*i+15, nowheight+9,sizetitle.width,sizetitle.height);
		labeltitle.text = texttitle;
		labeltitle.font = fontnow;
		labeltitle.numberOfLines = 0;
		labeltitle.backgroundColor = [UIColor clearColor];
		labeltitle.textColor = COLORNOW(48, 48, 48);
		[scrollview addSubview:labeltitle];
		
		UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x, scrollview.frame.size.height-20,150, 20)];
		if(iphone6)
			labeltime.frame = CGRectMake(labeltitle.frame.origin.x, scrollview.frame.size.height-23,150, 20);
		else if(iphone6p)
			labeltime.frame = CGRectMake(labeltitle.frame.origin.x, scrollview.frame.size.height-25,150, 20);
		labeltime.text = [dictemp objectForKey:@"add_time"];
		labeltime.font = FONTN(14.0f);
		labeltime.textColor = COLORNOW(153, 153, 153);
		[scrollview addSubview:labeltime];
	}
}

-(void)initviewmore:(NSDictionary *)dicdata
{
    UILabel *labelgray = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 3)];
    labelgray.backgroundColor = COLORNOW(240, 240, 240);
    [self addSubview:labelgray];
    
    UILabel *labeltypename = [[UILabel alloc] initWithFrame:CGRectMake(15, 11,150, 20)];
    labeltypename.text = [dicdata objectForKey:@"type_name"];
    labeltypename.font = FONTN(16.0f);
    labeltypename.textColor = COLORNOW(128, 128, 128);
    [self addSubview:labeltypename];
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, self.frame.size.height-40)];
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    [self addSubview:scrollview];
    
    DLog(@"scrollview====%f",scrollview.frame.size.height);
    
    float nowheight = 140;
    UIFont *fontnow = FONTN(15.0f);
    if(iphone6)
    {
        nowheight = 150*(iphone6ratio);
        fontnow = FONTN(16.0f);
    }
    else if(iphone6p)
    {
        nowheight = 150*(iphone6pratio);
        fontnow = FONTN(17.0f);
    }
    
    
    
    NSArray *arrayactivity = [dicdata objectForKey:@"list"];
    scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*[arrayactivity count], 100);
    for(int i=0;i<[arrayactivity count];i++)
    {
        NSDictionary *dictemp = [arrayactivity objectAtIndex:i];
        
        NSString *picpath = [dicdata objectForKey:@"pic_path"];
        if([[picpath lastPathComponent] isEqualToString:@"gif"])
        {
            YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0,self.frame.size.width, nowheight)];
            [scrollview addSubview:imageViewgif];
            imageViewgif.tag = EnYLImageViewTag;
            imageViewgif.image = [YLGIFImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dicdata objectForKey:@"pic_path"]]]];
            
        }
        else
        {
            UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, self.frame.size.width, nowheight)];
            [imagepic setImageWithURL:[NSURL URLWithString:[dictemp objectForKey:@"pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
            imagepic.contentMode = UIViewContentModeScaleAspectFill;
            imagepic.clipsToBounds = YES;
            imagepic.userInteractionEnabled = YES;
            imagepic.tag = EnActivityImageviewTag+i;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
            [imagepic addGestureRecognizer:singleTap];
            [scrollview addSubview:imagepic];
        }
        
        NSString *texttitle = [dictemp objectForKey:@"title"];
        NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:fontnow,NSFontAttributeName, nil];
        CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(self.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;
        
        UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i+15, nowheight+6,sizetitle.width,sizetitle.height)];
        if(iphone6)
            labeltitle.frame = CGRectMake(SCREEN_WIDTH*i+15, nowheight+7,sizetitle.width,sizetitle.height);
        else if(iphone6p)
            labeltitle.frame = CGRectMake(SCREEN_WIDTH*i+15, nowheight+9,sizetitle.width,sizetitle.height);
        labeltitle.text = texttitle;
        labeltitle.font = fontnow;
        labeltitle.numberOfLines = 0;
        labeltitle.backgroundColor = [UIColor clearColor];
        labeltitle.textColor = COLORNOW(48, 48, 48);
        [scrollview addSubview:labeltitle];
        
        UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x, scrollview.frame.size.height-20,150, 20)];
        if(iphone6)
            labeltime.frame = CGRectMake(labeltitle.frame.origin.x, scrollview.frame.size.height-23,150, 20);
        else if(iphone6p)
            labeltime.frame = CGRectMake(labeltitle.frame.origin.x, scrollview.frame.size.height-25,150, 20);
        labeltime.text = [dictemp objectForKey:@"add_time"];
        labeltime.font = FONTN(14.0f);
        labeltime.textColor = COLORNOW(153, 153, 153);
        [scrollview addSubview:labeltime];
    }
}


-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
	UIView *viewclick = sender.view;
	int tagnow = (int)viewclick.tag-EnActivityImageviewTag;
	if([self.delegate1 respondsToSelector:@selector(DGClickActivityPic:)])
	{
		
		NSArray *arraydata = [dicsrc objectForKey:@"list"];
		NSDictionary *dictemp = [arraydata objectAtIndex:tagnow];
		[self.delegate1 DGClickActivityPic:dictemp];
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
