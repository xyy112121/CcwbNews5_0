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
        [arraypiclist addObject:@"http://cwapp.ccwb.cn/NewHome/AppNews/newsDetail.html?cw_id=20170603095352MMMFNB&cw_channel_id=20170102"];
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

#pragma mark XRCarouselViewDelegate
- (void)loopView:(XLsn0wLoop *)loopView clickImageAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片", index);
    
    if([self.delegate1 respondsToSelector:@selector(DGFocusClickNumberPic:)])
    {
        NSArray *focus = [dicfocus objectForKey:@"list"];
        [self.delegate1 DGFocusClickNumberPic:[focus objectAtIndex:index]];
    }
}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
    //	int tagnow = (int)[[sender view] tag];
}

#pragma mark tableviewdelegate


@end
