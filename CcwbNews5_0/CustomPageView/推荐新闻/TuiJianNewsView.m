//
//  TuiJianNewsView.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/8/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "TuiJianNewsView.h"

@implementation TuiJianNewsView

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

-(void)initview:(NSDictionary *)dic
{
    NSArray *arraynews = [dic objectForKey:@"listItems"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, self.frame.size.height-3)];
    imageview.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageview];
    
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 15,SCREEN_WIDTH-40, 20)];
    labelname.text = @"-猜你喜欢-";
    labelname.font = FONTB(17.0f);
    labelname.textAlignment = NSTextAlignmentCenter;
    labelname.textColor = COLORNOW(232, 40, 63);
    [self addSubview:labelname];
    
    UIButton *buttonchange = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonchange.frame = CGRectMake(SCREEN_WIDTH-80, 10, 70, 30);
    [buttonchange setTitle:@"换一批" forState:UIControlStateNormal];
    buttonchange.titleLabel.font = FONTN(15.0f);
    [buttonchange setTitleColor:COLORNOW(232, 40, 63) forState:UIControlStateNormal];
    [buttonchange addTarget:self action:@selector(clickchangenews:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonchange];
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    imageviewline.backgroundColor = COLORNOW(235, 235, 235);
    [self addSubview:imageviewline];
    
    for(int i=0;i<[arraynews count];i++)
    {
        NSDictionary *dicnews = [arraynews objectAtIndex:i];
        UIView *view = [self initviewsudden:dicnews Frame:CGRectMake(0, 50+100*i, SCREEN_WIDTH, 100)];
        [self addSubview:view];
        
        UIButton *buttonnews = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonnews.frame = CGRectMake(0, 50+100*i, SCREEN_WIDTH, 100);
        buttonnews.tag = EnTuiJianNewsButtonTag+i;
        [buttonnews addTarget:self action:@selector(gotonewsdetail:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonnews];
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 50+100*[arraynews count]);
    imageview.frame = CGRectMake(imageview.frame.origin.x, imageview.frame.origin.y, imageview.frame.size.width, self.frame.size.height-3);
    DLog(@"self.frame====%f",self.frame.size.height);
}

-(UIView *)initviewsudden:(NSDictionary *)dicdata Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    NSArray *arrayimage = [dicdata objectForKey:@"imgs"];
    NSString *picpath;
    if([arrayimage count]>0)
    {
        picpath = [[arrayimage objectAtIndex:0] objectForKey:@"url"];
    }
    else
        picpath = @"noimage.png";

    UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 90, 70)];
    [imagepic setImageWithURL:[NSURL URLWithString:picpath] placeholderImage:LOADIMAGE(@"noimage", @"png")];
    imagepic.contentMode = UIViewContentModeScaleAspectFill;
    imagepic.clipsToBounds = YES;
    [view addSubview:imagepic];

    
    
    NSString *texttitle = [dicdata objectForKey:@"title"];
    UIFont *fontname = FONTN(15.0f);
    UIFont *fonttime = FONTN(12.0f);
    float space = 4;
    if(iphone6p)
    {
        fontname = FONTN(17.0f);
        fonttime = FONTN(14.0f);
        space = 6;
    }
    else if(iphone6)
    {
        fontname = FONTN(16.0f);
        fonttime = FONTN(13.0f);
        space = 5;
    }
    
    
    
    NSDictionary *dictitle = [NSDictionary dictionaryWithObjectsAndKeys:fontname,NSFontAttributeName, nil];
    CGSize sizetitle = [texttitle boundingRectWithSize:CGSizeMake(self.frame.size.width-120, 70) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictitle context:nil].size;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:texttitle];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:space];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [texttitle length])];
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(110, 15,sizetitle.width, sizetitle.height)];
    labelname.font = fontname;
    labelname.numberOfLines = 2;
    [labelname setAttributedText:attributedString1];
    [labelname sizeToFit];
    labelname.textColor = COLORNOW(48, 48, 48);
    [view addSubview:labelname];
    
    
    
    
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(XYViewLeft(labelname), view.frame.size.height-30,150, 20)];
    labeltime.text = [[dicdata objectForKey:@"showTime"] length]>11?[[dicdata objectForKey:@"showTime"] substringToIndex:11]:[dicdata objectForKey:@"showTime"];
    labeltime.font = FONTN(14.0f);
    labeltime.textColor = COLORNOW(153, 153, 153);
    [view addSubview:labeltime];
    
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 97, SCREEN_WIDTH, 3)];
    imageviewline.backgroundColor = COLORNOW(235, 235, 235);
    [view addSubview:imageviewline];
    
    return view;
}

-(void)gotonewsdetail:(id)sender
{
    NSArray *arraynews = [dicsrc objectForKey:@"listItems"];
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag] - EnTuiJianNewsButtonTag;
    NSDictionary *dictemp = [arraynews objectAtIndex:tagnow];
    if([_delegate1 respondsToSelector:@selector(DGClickTuiJianNews:)])
    {
        [_delegate1 DGClickTuiJianNews:dictemp];
    }
}
//
-(void)clickchangenews:(id)sender
{
    if([_delegate1 respondsToSelector:@selector(DGClicknewrecommend:)])
    {
        [_delegate1 DGClicknewrecommend:sender];
    }
}

@end
