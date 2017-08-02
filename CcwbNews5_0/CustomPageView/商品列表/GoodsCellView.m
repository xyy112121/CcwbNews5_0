//
//  GoodsCellView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "GoodsCellView.h"

@implementation GoodsCellView
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
    NSArray *arrayfocuslist = [dic objectForKey:@"focus"];
    NSArray *arrayhelist = [dic objectForKey:@"list"];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, self.frame.size.height-3)];
    imageview.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageview];
    
    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 21, 14)];
    imageicon.image = LOADIMAGE(@"购物车", @"png");
    [self addSubview:imageicon];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageicon.frame.origin.x+imageicon.frame.size.width+10, imageicon.frame.origin.y-3,150, 20)];
    labelname.text = [dic objectForKey:@"type_name"];
    labelname.font = FONTMEDIUM(16.0f);
    labelname.textColor = COLORNOW(128, 128, 128);
    [self addSubview:labelname];
    
    UIButton *buttonmore = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonmore.layer.borderColor = [UIColor clearColor].CGColor;
    buttonmore.frame = CGRectMake(SCREEN_WIDTH-80, imageicon.frame.origin.y-5, 75, 24);
    [buttonmore setTitle:@"更多" forState:UIControlStateNormal];
    [buttonmore setImage:LOADIMAGE(@"arrowrightred", @"png") forState:UIControlStateNormal];
    [buttonmore setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
    [buttonmore setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    buttonmore.titleLabel.font = FONTN(15.0f);
    [buttonmore addTarget:self action:@selector(gotomoreandmorenews:) forControlEvents:UIControlEventTouchUpInside];
    [buttonmore setTitleColor:COLORNOW(128, 128, 128) forState:UIControlStateNormal];
    [self addSubview:buttonmore];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, labelname.frame.size.height+labelname.frame.origin.y+5, SCREEN_WIDTH, 0.5)];
    imageline.backgroundColor = COLORNOW(240, 240, 240);
    [self addSubview:imageline];
    
    float nowheight = 150;
    UIFont *fontnow = FONTN(15.0f);
    UIFont *fontnow2 = FONTN(14.0f);
    UIFont *fontno3 = FONTN(13.0f);
    if(iphone6)
    {
        nowheight = 150*(iphone6ratio);
        fontnow = FONTN(16.0f);
        fontnow2 = FONTN(15.0f);
        fontno3 = FONTN(14.0f);
    }
    else if(iphone6p)
    {
        nowheight = 150*(iphone6pratio);
        fontnow = FONTN(17.0f);
        fontnow2 = FONTN(16.0f);
        fontno3 = FONTN(15.0f);
    }
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, imageline.frame.origin.y+1, SCREEN_WIDTH, 150)];
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.delegate = self;
    scrollview.tag = EnGoodsCellFocusScrollviewTag;
    [self addSubview:scrollview];
    
    scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*[arrayfocuslist count], 100);
    for(int i=0;i<[arrayfocuslist count];i++)
    {
        NSDictionary *dictemp = [arrayfocuslist objectAtIndex:i];
        
        UIView *goodsview = [[UIView alloc] initWithFrame:CGRectMake(scrollview.frame.size.width*i, 0, scrollview.frame.size.width, scrollview.frame.size.height)];
        goodsview.tag = EnGoodsCellOneViewTag+i;
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClicGoodsViewAction:)];
        [goodsview addGestureRecognizer:tapGesture];
        [scrollview addSubview:goodsview];
        
        UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-160), 20, 140, 90)];
        [imagepic setImageWithURL:[NSURL URLWithString:[dictemp objectForKey:@"pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
        imagepic.contentMode = UIViewContentModeScaleAspectFill;
        imagepic.clipsToBounds = YES;
        imagepic.userInteractionEnabled = YES;
        imagepic.tag = EnActivityImageviewTag+i;
        [goodsview addSubview:imagepic];
        
        NSString *texttitle = [dictemp objectForKey:@"title"];
        NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:fontnow,NSFontAttributeName, nil];
        CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(self.frame.size.width-180, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;
        UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 20,sizetitle.width,sizetitle.height)];
        labeltitle.text = texttitle;
        labeltitle.font = fontnow;
        labeltitle.numberOfLines = 0;
        labeltitle.backgroundColor = [UIColor clearColor];
        labeltitle.textColor = COLORNOW(48, 48, 48);
        [goodsview addSubview:labeltitle];
        
        UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(20,labeltitle.frame.origin.y+labeltitle.frame.size.height+5,100,20)];
        labelprice.text = [dictemp objectForKey:@"price"];
        labelprice.font = fontnow2;
        labelprice.backgroundColor = [UIColor clearColor];
        labelprice.textColor = COLORNOW(232, 56, 47);
        [goodsview addSubview:labelprice];
        
        UILabel *labelstore = [[UILabel alloc] initWithFrame:CGRectMake(20,imagepic.frame.origin.y+imagepic.frame.size.height-20,100,20)];
        labelstore.text = [dictemp objectForKey:@"store"];
        labelstore.font = fontnow2;
        labelstore.backgroundColor = [UIColor clearColor];
        labelstore.textColor = COLORNOW(140, 140, 140);
        [goodsview addSubview:labelstore];
        
    }
    
    SMPageControl *spacePageControl1 = [[SMPageControl alloc] initWithFrame:CGRectMake(0,230, SCREEN_WIDTH,20)];
    spacePageControl1.center = CGPointMake(scrollview.frame.size.width/2,scrollview.frame.size.height+scrollview.frame.origin.y-15);
    spacePageControl1.indicatorDiameter = 6.0f;
    spacePageControl1.indicatorMargin = 5.0f;
    spacePageControl1.alignment = SMPageControlAlignmentCenter;
    spacePageControl1.tag = EnGoodsCellSMPageControlTag;
    spacePageControl1.numberOfPages = [arrayfocuslist count];
    spacePageControl1.currentPage = 0;
    spacePageControl1.backgroundColor = [UIColor clearColor];
    [spacePageControl1 setPageIndicatorImage:LOADIMAGE(@"diangray", @"png")];
    [spacePageControl1 setCurrentPageIndicatorImage:LOADIMAGE(@"dianblack", @"png")];
    [self addSubview:spacePageControl1];
    
    if([arrayhelist count]>0)
    {
        UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollview.frame.size.height+scrollview.frame.origin.y-0.5, SCREEN_WIDTH, 0.5)];
        imageline1.backgroundColor = COLORNOW(230, 230, 230);
        [self addSubview:imageline1];
        
        [self inithegoodslist:arrayhelist Frame:CGRectMake(0, imageline1.frame.origin.y+1, SCREEN_WIDTH, 170)];
    }
    
    
    DLog(@"self.frame====%f",self.frame.size.height);
}

-(void)initview:(NSDictionary *)dic
{
	NSArray *arrayfocuslist = [dic objectForKey:@"focus"];
	NSArray *arrayhelist = [dic objectForKey:@"list"];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, self.frame.size.height-3)];
	imageview.backgroundColor = [UIColor whiteColor];
	[self addSubview:imageview];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 21, 14)];
	imageicon.image = LOADIMAGE(@"购物车", @"png");
	[self addSubview:imageicon];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(imageicon.frame.origin.x+imageicon.frame.size.width+10, imageicon.frame.origin.y-3,150, 20)];
	labelname.text = [dic objectForKey:@"type_name"];
	labelname.font = FONTMEDIUM(16.0f);
	labelname.textColor = COLORNOW(128, 128, 128);
	[self addSubview:labelname];
	
	UIButton *buttonmore = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonmore.layer.borderColor = [UIColor clearColor].CGColor;
	buttonmore.frame = CGRectMake(SCREEN_WIDTH-80, imageicon.frame.origin.y-5, 75, 24);
	[buttonmore setTitle:@"更多" forState:UIControlStateNormal];
	[buttonmore setImage:LOADIMAGE(@"arrowrightred", @"png") forState:UIControlStateNormal];
	[buttonmore setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
	[buttonmore setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
	buttonmore.titleLabel.font = FONTN(15.0f);
	[buttonmore addTarget:self action:@selector(gotomoreandmorenews:) forControlEvents:UIControlEventTouchUpInside];
	[buttonmore setTitleColor:COLORNOW(128, 128, 128) forState:UIControlStateNormal];
	[self addSubview:buttonmore];
	
	UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, labelname.frame.size.height+labelname.frame.origin.y+5, SCREEN_WIDTH, 0.5)];
	imageline.backgroundColor = COLORNOW(240, 240, 240);
	[self addSubview:imageline];
	
	float nowheight = 150;
	UIFont *fontnow = FONTN(15.0f);
	UIFont *fontnow2 = FONTN(14.0f);
	UIFont *fontno3 = FONTN(13.0f);
	if(iphone6)
	{
		nowheight = 150*(iphone6ratio);
		fontnow = FONTN(16.0f);
		fontnow2 = FONTN(15.0f);
		fontno3 = FONTN(14.0f);
	}
	else if(iphone6p)
	{
		nowheight = 150*(iphone6pratio);
		fontnow = FONTN(17.0f);
		fontnow2 = FONTN(16.0f);
		fontno3 = FONTN(15.0f);
	}
	
	UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, imageline.frame.origin.y+1, SCREEN_WIDTH, 150)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsHorizontalScrollIndicator = NO;
	scrollview.pagingEnabled = YES;
	scrollview.delegate = self;
	scrollview.tag = EnGoodsCellFocusScrollviewTag;
	[self addSubview:scrollview];
	
	scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*[arrayfocuslist count], 100);
	for(int i=0;i<[arrayfocuslist count];i++)
	{
		NSDictionary *dictemp = [arrayfocuslist objectAtIndex:i];
		
		UIView *goodsview = [[UIView alloc] initWithFrame:CGRectMake(scrollview.frame.size.width*i, 0, scrollview.frame.size.width, scrollview.frame.size.height)];
		goodsview.tag = EnGoodsCellOneViewTag+i;
		UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClicGoodsViewAction:)];
		[goodsview addGestureRecognizer:tapGesture];
		[scrollview addSubview:goodsview];
		
		UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-160), 20, 140, 90)];
		[imagepic setImageWithURL:[NSURL URLWithString:[dictemp objectForKey:@"pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
		imagepic.contentMode = UIViewContentModeScaleAspectFill;
		imagepic.clipsToBounds = YES;
		imagepic.userInteractionEnabled = YES;
		imagepic.tag = EnActivityImageviewTag+i;
		[goodsview addSubview:imagepic];
		
		NSString *texttitle = [dictemp objectForKey:@"title"];
		NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:fontnow,NSFontAttributeName, nil];
		CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(self.frame.size.width-180, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 20,sizetitle.width,sizetitle.height)];
		labeltitle.text = texttitle;
		labeltitle.font = fontnow;
		labeltitle.numberOfLines = 0;
		labeltitle.backgroundColor = [UIColor clearColor];
		labeltitle.textColor = COLORNOW(48, 48, 48);
		[goodsview addSubview:labeltitle];

		UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(20,labeltitle.frame.origin.y+labeltitle.frame.size.height+5,100,20)];
		labelprice.text = [dictemp objectForKey:@"price"];
		labelprice.font = fontnow2;
		labelprice.backgroundColor = [UIColor clearColor];
		labelprice.textColor = COLORNOW(232, 56, 47);
		[goodsview addSubview:labelprice];

		UILabel *labelstore = [[UILabel alloc] initWithFrame:CGRectMake(20,imagepic.frame.origin.y+imagepic.frame.size.height-20,100,20)];
		labelstore.text = [dictemp objectForKey:@"store"];
		labelstore.font = fontnow2;
		labelstore.backgroundColor = [UIColor clearColor];
		labelstore.textColor = COLORNOW(140, 140, 140);
		[goodsview addSubview:labelstore];

	}

	SMPageControl *spacePageControl1 = [[SMPageControl alloc] initWithFrame:CGRectMake(0,230, SCREEN_WIDTH,20)];
	spacePageControl1.center = CGPointMake(scrollview.frame.size.width/2,scrollview.frame.size.height+scrollview.frame.origin.y-15);
	spacePageControl1.indicatorDiameter = 6.0f;
	spacePageControl1.indicatorMargin = 5.0f;
	spacePageControl1.alignment = SMPageControlAlignmentCenter;
	spacePageControl1.tag = EnGoodsCellSMPageControlTag;
	spacePageControl1.numberOfPages = [arrayfocuslist count];
	spacePageControl1.currentPage = 0;
	spacePageControl1.backgroundColor = [UIColor clearColor];
	[spacePageControl1 setPageIndicatorImage:LOADIMAGE(@"diangray", @"png")];
	[spacePageControl1 setCurrentPageIndicatorImage:LOADIMAGE(@"dianblack", @"png")];
	[self addSubview:spacePageControl1];
	
	if([arrayhelist count]>0)
	{
		UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, scrollview.frame.size.height+scrollview.frame.origin.y-0.5, SCREEN_WIDTH, 0.5)];
		imageline1.backgroundColor = COLORNOW(230, 230, 230);
		[self addSubview:imageline1];
		
		[self inithegoodslist:arrayhelist Frame:CGRectMake(0, imageline1.frame.origin.y+1, SCREEN_WIDTH, 170)];
	}
	
	
	DLog(@"self.frame====%f",self.frame.size.height);
}

-(void)inithegoodslist:(NSArray *)arrayhelist Frame:(CGRect)frame
{
	UIView *view = [[UIView alloc] initWithFrame:frame];
	view.backgroundColor = [UIColor whiteColor];
	[self addSubview:view];
	
	UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsHorizontalScrollIndicator = NO;
	scrollview.showsVerticalScrollIndicator = NO;
	scrollview.delegate = self;
	scrollview.contentSize = CGSizeMake(160*[arrayhelist count]+20, 140);
	[view addSubview:scrollview];
	
	UIFont *fontnow = FONTN(14.0f);
	UIFont *fontprice = FONTN(13.0f);
	if(iphone6)
	{
		fontnow = FONTN(15.0f);
		fontprice = FONTN(14.0f);
	}
	else if(iphone6p)
	{
		fontnow = FONTN(16.0f);
		fontprice = FONTN(15.0f);
	}
	
	for(int i=0;i<[arrayhelist count];i++)
	{
		NSDictionary *dicdata = [arrayhelist objectAtIndex:i];
		
		UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(10+150*i, 10, 140, 90)];
		[imagepic setImageWithURL:[NSURL URLWithString:[dicdata objectForKey:@"pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
		imagepic.contentMode = UIViewContentModeScaleAspectFill;
		imagepic.userInteractionEnabled = YES;
		UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimagehegoods:)];
		[imagepic addGestureRecognizer:tapGesture];
		imagepic.tag = EnSingleTujiItemImageViewTag+i;
		
		imagepic.clipsToBounds = YES;
		[scrollview addSubview:imagepic];
		

		NSString *texttitle = [dicdata objectForKey:@"title"];
		NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:fontnow,NSFontAttributeName, nil];
		CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(140, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;
		
		UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(imagepic.frame.origin.x, imagepic.frame.origin.y+imagepic.frame.size.height+10,sizetitle.width,sizetitle.height)];
		labeltitle.text = texttitle;
		labeltitle.font = fontnow;
		labeltitle.numberOfLines = 0;
		labeltitle.backgroundColor = [UIColor clearColor];
		labeltitle.textColor = COLORNOW(48, 48, 48);
		[scrollview addSubview:labeltitle];
		
		UILabel *labelprice = [[UILabel alloc] initWithFrame:CGRectMake(labeltitle.frame.origin.x,labeltitle.frame.origin.y+labeltitle.frame.size.height+5,100,20)];
		labelprice.text = [dicdata objectForKey:@"price"];
		labelprice.font = fontprice;
		labelprice.backgroundColor = [UIColor clearColor];
		labelprice.textColor = COLORNOW(232, 56, 47);
		[scrollview addSubview:labelprice];
		
	}
	
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if(scrollView.tag == EnGoodsCellFocusScrollviewTag)
	{
		SMPageControl *spacePageControl1 = [self viewWithTag:EnGoodsCellSMPageControlTag];
		int page = scrollView.contentOffset.x / (SCREEN_WIDTH-10);//通过滚动的偏移量来判断目前页面所对应的小白点
		spacePageControl1.currentPage = page;
	}
}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
	
}

-(void)clickimagehegoods:(UIGestureRecognizer*)sender
{
//	int tagnow = (int)[[sender view] tag];
}

-(void)ClicGoodsViewAction:(UIGestureRecognizer*)sender
{
	int tagnow = (int)[[sender view] tag]-EnGoodsCellOneViewTag;
	NSArray *arrayfocuslist = [dicsrc objectForKey:@"focus"];
	NSDictionary *dictemp = [arrayfocuslist objectAtIndex:tagnow];
	if([self.delegate1 respondsToSelector:@selector(DGGotoGoodsDetailView:)])
	{
		[self.delegate1 DGGotoGoodsDetailView:dictemp];
	}
	DLog(@"tagnow====%d",tagnow);
	
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
