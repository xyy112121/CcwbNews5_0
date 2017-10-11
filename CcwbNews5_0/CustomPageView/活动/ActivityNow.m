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
        arraynow = [[NSMutableArray alloc] init];
        dictimerinfo = [[NSMutableDictionary alloc] init];
        [dictimerinfo setObject:@"1" forKey:@"num"];
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
    NSArray *arraytemp = [dicdata objectForKey:@"list"];
    arraynow = [[NSMutableArray alloc] initWithArray:[dicdata objectForKey:@"list"]];
    if([arraytemp count]>1)
    {
        NSDictionary *dictemp = [arraytemp objectAtIndex:0];
        NSDictionary *dictemp1 = [arraytemp objectAtIndex:[arraytemp count]-1];
        [arraynow insertObject:dictemp1 atIndex:0];
        [arraynow addObject:dictemp];
    }
	UILabel *labelgray = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 3)];
	labelgray.backgroundColor = COLORNOW(240, 240, 240);
	[self addSubview:labelgray];
	
	UILabel *labeltypename = [[UILabel alloc] initWithFrame:CGRectMake(15, 11,150, 20)];
    labeltypename.text = [dicdata objectForKey:@"type_name"];
    if([arraynow count]>1)
    {
        NSDictionary *dictemp = [arraynow objectAtIndex:1];
        labeltypename.text = [dictemp objectForKey:@"type_name"];
    }
    else if([arraynow count]>0)
    {
        NSDictionary *dictemp = [arraynow objectAtIndex:0];
        labeltypename.text = [dictemp objectForKey:@"type_name"];
    }
    labeltypename.tag = EnActivityTypeNameLabelTag;
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
	
	scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, self.frame.size.height-40)];
	scrollview.backgroundColor = [UIColor clearColor];
	scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*[arraynow count], 100);
    if([arraynow count]>1)
        [scrollview setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
	scrollview.pagingEnabled = YES;
    scrollview.delegate = self;
	[self addSubview:scrollview];
    
    if([arraytemp count]>1)
        timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeImage:) userInfo:dictimerinfo repeats:YES];
    
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
	
	
    
	for(int i=0;i<[arraynow count];i++)
	{
		NSDictionary *dictemp = [arraynow objectAtIndex:i];
		
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
    
    spacePageControl1 = [[SMPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-55,self.frame.size.height-50, 50,20)];
    spacePageControl1.indicatorDiameter = 3.0f;
    spacePageControl1.indicatorMargin = 5.0f;
    spacePageControl1.alignment = SMPageControlAlignmentRight;
    spacePageControl1.tag = 903;
    spacePageControl1.numberOfPages = [arraytemp count];//[[self.contentarray objectForKey:@"focustotal"] intValue];
    spacePageControl1.currentPage = 0;
    spacePageControl1.backgroundColor = [UIColor clearColor];
    [spacePageControl1 setPageIndicatorImage:[UIImage imageNamed:@"pagewhite.png"]];
    [spacePageControl1 setCurrentPageIndicatorImage:[UIImage imageNamed:@"pageorange.png"]];
    [self addSubview:spacePageControl1];
    
}

-(void)initviewmore:(NSDictionary *)dicdata
{
    NSArray *arraytemp = [dicdata objectForKey:@"list"];
    arraynow = [[NSMutableArray alloc] initWithArray:[dicdata objectForKey:@"list"]];
    if([arraytemp count]>1)
    {
        NSDictionary *dictemp = [arraytemp objectAtIndex:0];
        NSDictionary *dictemp1 = [arraytemp objectAtIndex:[arraytemp count]-1];
        [arraynow insertObject:dictemp1 atIndex:0];
        [arraynow addObject:dictemp];
    }
    UILabel *labelgray = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 3)];
    labelgray.backgroundColor = COLORNOW(240, 240, 240);
    [self addSubview:labelgray];
    
    UILabel *labeltypename = [[UILabel alloc] initWithFrame:CGRectMake(15, 11,150, 20)];
    labeltypename.text = [dicdata objectForKey:@"type_name"];
    if([arraynow count]>1)
    {
        NSDictionary *dictemp = [arraynow objectAtIndex:1];
        labeltypename.text = [dictemp objectForKey:@"type_name"];
    }
    else if([arraynow count]>0)
    {
        NSDictionary *dictemp = [arraynow objectAtIndex:0];
        labeltypename.text = [dictemp objectForKey:@"type_name"];
    }
    labeltypename.tag = EnActivityTypeNameLabelTag;
    labeltypename.font = FONTN(16.0f);
    labeltypename.textColor = COLORNOW(128, 128, 128);
    [self addSubview:labeltypename];
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, self.frame.size.height-40)];
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.delegate = self;
    [self addSubview:scrollview];

    if([arraytemp count]>1)
        timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeImage:) userInfo:dictimerinfo repeats:YES];

    
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
    
    
    scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*[arraynow count], 100);
    if([arraynow count]>1)
        [scrollview setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    for(int i=0;i<[arraynow count];i++)
    {
        NSDictionary *dictemp = [arraynow objectAtIndex:i];
        
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
    
    SMPageControl* spacePageControl1 = [[SMPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-55,self.frame.size.height-50, 50,20)];
    spacePageControl1.indicatorDiameter = 3.0f;
    spacePageControl1.indicatorMargin = 5.0f;
    spacePageControl1.alignment = SMPageControlAlignmentRight;
    spacePageControl1.tag = 903;
    spacePageControl1.numberOfPages = [arraytemp count];//[[self.contentarray objectForKey:@"focustotal"] intValue];
    spacePageControl1.currentPage = 0;
    spacePageControl1.backgroundColor = [UIColor clearColor];
    [spacePageControl1 setPageIndicatorImage:[UIImage imageNamed:@"pagewhite.png"]];
    [spacePageControl1 setCurrentPageIndicatorImage:[UIImage imageNamed:@"pageorange.png"]];
    [self addSubview:spacePageControl1];
    
}


-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
	UIView *viewclick = sender.view;
	int tagnow = (int)viewclick.tag-EnActivityImageviewTag;
	if([self.delegate1 respondsToSelector:@selector(DGClickActivityPic:)])
	{
		
		//NSArray *arraydata = [arraynow objectForKey:@"list"];
 //       DLog(@"tagnow====%d,%d",tagnow,(int)[arraynow count]);
        if([arraynow count]>tagnow)
        {
            NSDictionary *dictemp = [arraynow objectAtIndex:tagnow];
            [self.delegate1 DGClickActivityPic:dictemp];
        }
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

-(void)dealloc {
    NSLog(@"%s",__func__);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    
    //获得偏移量
    CGPoint point = scrollView.contentOffset;
    //获得当前的最大x值(在可见区域内，最大的x轴上的值)
    CGFloat manX = SCREEN_WIDTH * ([arraynow count] - 1);
    
    //如果当前点已经到了最前边的一张，即坐标为0,0
    if (point.x == 0)
    {
        CGFloat x = scrollView.bounds.size.width * ([arraynow count]  - 2);
        [scrollView setContentOffset:CGPointMake(x , 0)];//立马跳到倒数第二张(因为最后一张是为了往后滚动做的铺垫视图)
    }
    
    //如果当前点已经达到最后一张图，即坐标为
    else if (point.x == manX)
    {
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];//立马跳到整数第二张，第一张同理，利用人的视觉差
    }
    
    
    //设置pageControl的点数
    int page = scrollView.contentOffset.x / (SCREEN_WIDTH-10);//自定义方法，根据偏移量设置当前页码
//    int page = [self imageIndexWithContentOffset:scrollView.contentOffset];
    UILabel *labeltypename = [self viewWithTag:EnActivityTypeNameLabelTag];
//    DLog(@"tagnow====%d,%d",page,(int)[arraynow count]);
    if([arraynow count] > page)
    {
        NSDictionary *dictemp = [arraynow objectAtIndex:page];
        labeltypename.text = [dictemp objectForKey:@"type_name"];
    }
    
    spacePageControl1.currentPage = page;
}

-(int)imageIndexWithContentOffset:(CGPoint)contentOffSet
{
    return (contentOffSet.x - scrollview.bounds.size.width) / SCREEN_WIDTH;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    [timer invalidate];//取消计时器
//    timer = nil;//避免野指针
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

}

-(void)changeImage:(NSTimer *)timerinfo
{
    NSDictionary *dictemp = [timerinfo userInfo];
    if([[dictemp objectForKey:@"num"] intValue]>15)
    {
        [timer invalidate];//取消计时器
        timer = nil;//避免野指针
        return ;
    }
    else
    {
        NSString *strnum = [NSString stringWithFormat:@"%d",[[dictemp objectForKey:@"num"] intValue]+1];
        [dictimerinfo setObject:strnum forKey:@"num"];
    }
    //获得当先scrollView滚动到的点（俗称偏移量）
    CGFloat offSetX = scrollview.contentOffset.x;//获取当前滚动视图的contentOffSet的x值
    
    //让scrollView向右滚动一个屏幕宽的距离
    offSetX += scrollview.bounds.size.width;
    
    [scrollview setContentOffset:CGPointMake(offSetX, 0) animated:YES];//开始偏移并伴有动画效果
    
 //   DLog(@"12312312312312312312312312312313132123123123");
    
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [timer invalidate];//取消计时器
    timer = nil;//避免野指针
}

@end
