//
//  FocusApplicationView.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/12.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "FocusApplicationView.h"

@implementation FocusApplicationView

-(id)initWithFrame:(CGRect)frame Focus:(NSDictionary *)focus
{
    self = [super initWithFrame:frame];
    if (self)
    {
        dicfocus = focus;
        [self initviewloop:[dicfocus objectForKey:@"list"]];
    }
    return self;
}

-(id)initWithFrame1:(CGRect)frame Focus:(NSDictionary *)focus
{
    self = [super initWithFrame:frame];
    if (self)
    {
        dicfocus = focus;
        self.backgroundColor = [UIColor whiteColor];
        [self initviewloopapplist:[dicfocus objectForKey:@"list"]];
    }
    return self;
}

//新闻列表
-(void)initviewloop:(NSArray *)focus
{
    float nowheight = 160;
    if(iphone6)
        nowheight = nowheight*iphone6ratio;
    else if(iphone6p)
        nowheight = nowheight*iphone6pratio;
    
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, nowheight);
    self.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *arraypiclist =  [[NSMutableArray alloc] init];
    for(int i=0;i<[focus count];i++)
    {
        NSDictionary *dictemp = [focus objectAtIndex:i];
        [arraypiclist addObject:[dictemp objectForKey:@"pic_path"]];
    }
    
    self.loop = [[XLsn0wLoop alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, nowheight)];
   // tableview.tableHeaderView = self.loop;
    self.loop.xlsn0wDelegate = self;
    self.loop.time = 5;
    [self.loop setPagePosition:PositionBottomRight];
    [self.loop setPageColor:[UIColor whiteColor] andCurrentPageColor:Colorredcolor];
    //支持gif动态图
    self.loop.imageArray = arraypiclist;
    
}

//应用管理列表
-(void)initviewloopapplist:(NSArray *)focus
{
    float nowheight = 160;
    if(iphone6)
        nowheight = nowheight*iphone6ratio;
    else if(iphone6p)
        nowheight = nowheight*iphone6pratio;
    
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, nowheight);
    self.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *arraypiclist =  [[NSMutableArray alloc] init];
    for(int i=0;i<[focus count];i++)
    {
        NSDictionary *dictemp = [focus objectAtIndex:i];
        [arraypiclist addObject:[dictemp objectForKey:@"bg_pic_path"]];
    }
    
    self.loop = [[XLsn0wLoop alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, nowheight)];
    self.loop.xlsn0wDelegate = self;
    self.loop.time = 5;
    [self.loop setPagePosition:PositionBottomCenter];
    [self.loop setPageColor:[UIColor whiteColor] andCurrentPageColor:Colorredcolor];
    [self.loop.imagealpha removeFromSuperview];
    //支持gif动态图
    self.loop.imageArray = arraypiclist;
    [self addSubview:self.loop];
}

#pragma mark XRCarouselViewDelegate
- (void)loopView:(XLsn0wLoop *)loopView clickImageAtIndex:(NSInteger)index {
//    NSLog(@"点击了第%d张图片",index);
    
    if([self.delegate1 respondsToSelector:@selector(DGFocusClickNumberPic:)])
    {
        NSArray *focus = [dicfocus objectForKey:@"list"];
        [self.delegate1 DGFocusClickNumberPic:[focus objectAtIndex:index]];
    }
}

-(void)changepicdescript:(int)currentindex
{
    
}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
    //	int tagnow = (int)[[sender view] tag];
}

#pragma mark tableviewdelegate


@end
