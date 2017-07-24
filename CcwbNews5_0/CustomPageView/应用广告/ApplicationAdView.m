//
//  ApplicationAdView.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ApplicationAdView.h"

@implementation ApplicationAdView

-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic
{
    self = [super initWithFrame:frame];
    if (self)
    {
        float nowheight = 200;
        if(iphone6p)
            nowheight = 200*iphone6pratio;
        else if(iphone6)
            nowheight = 200*iphone6ratio;
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, nowheight);
        self.backgroundColor = [UIColor whiteColor];
        dicsrc = dic;
        [self initview:dicsrc];
    }
    return self;
}

-(void)initview:(NSDictionary *)dicdata
{
    UILabel *labelgray = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 5)];
    labelgray.backgroundColor = COLORNOW(240, 240, 240);
    [self addSubview:labelgray];
//
//    UILabel *labeltypename = [[UILabel alloc] initWithFrame:CGRectMake(15, 11,150, 20)];
//    labeltypename.text = [dicdata objectForKey:@"name"];
//    labeltypename.font = FONTN(16.0f);
//    labeltypename.textColor = COLORNOW(128, 128, 128);
//    [self addSubview:labeltypename];
//
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, self.frame.size.height-5)];
    scrollview.backgroundColor = [UIColor redColor];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    [self addSubview:scrollview];
    
    DLog(@"scrollview====%f",scrollview.frame.size.height);
    
    NSArray *arrayactivity = [dicdata objectForKey:@"list"];
    scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*[arrayactivity count], 100);
    
    for(int i=0;i<[arrayactivity count];i++)
    {
        NSDictionary *dicad = [arrayactivity objectAtIndex:i];
        NSString *picpath = [dicad objectForKey:@"bg_pic_path"];
        if([[picpath lastPathComponent] isEqualToString:@"gif"])
        {
            YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 5,SCREEN_WIDTH, XYViewHeight(self)-5)];
            [scrollview addSubview:imageViewgif];
            imageViewgif.tag = EnYLImageViewTag;
            imageViewgif.image = [YLGIFImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dicad objectForKey:@"bg_pic_path"]]]];
            
        }
        else
        {
            UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 5, SCREEN_WIDTH, XYViewHeight(self)-5)];
            [imagepic setImageWithURL:[NSURL URLWithString:[dicad objectForKey:@"bg_pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
            imagepic.contentMode = UIViewContentModeScaleAspectFill;
            imagepic.clipsToBounds = YES;
            [scrollview addSubview:imagepic];
        }
    }
}

-(void)gotomoreandmorenews:(id)sender
{
//    NSString *strmoreurl = [dicsrc objectForKey:@"more_url"];
//    if([self.delegate1 respondsToSelector:@selector(DGClickMoreNewsUrl:)])
//    {
//        [self.delegate1 DGClickMoreNewsUrl:strmoreurl];
//    }
}

@end
