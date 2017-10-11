//
//  ExpressionViewBar.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/9/5.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ExpressionViewBar.h"

@implementation ExpressionViewBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = COLORNOW(220, 220, 220);
        [self initview];
    }
    return self;
}

-(void)initview
{
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    scrollviewtop = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, XYViewHeight(self))];
    scrollviewtop.backgroundColor = COLORNOW(220, 220, 220);
    scrollviewtop.pagingEnabled = YES;
    scrollviewtop.delegate = self;
    scrollviewtop.showsHorizontalScrollIndicator = NO;
    float nowwidth = SCREEN_WIDTH/5;
    [scrollviewtop setContentSize:CGSizeMake(nowwidth*14, scrollviewtop.frame.size.height)];
    [self addSubview:scrollviewtop];
    for(int i=0;i<14;i++)
    {
        NSString *strpic = [NSString stringWithFormat:@"%02d",i+1];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(nowwidth*i, 0, nowwidth, 50);
        [button setImage: LOADIMAGE(strpic, @"png") forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(clickselectexpression:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = EnExpressionBtTag+i;
        [scrollviewtop addSubview:button];
        
        
//        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+scrollviewtop.frame.size.width*i, 0,scrollviewtop.frame.size.width, scrollviewtop.frame.size.height)];
//        imageview.tag = 800+i;
//        imageview.image
//        imageview.userInteractionEnabled = YES;
//        imageview.contentMode = UIViewContentModeScaleAspectFill;
//        imageview.clipsToBounds = YES;
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
//        [imageview addGestureRecognizer:singleTap];
//        [scrollviewtop addSubview:imageview];
    }
    
    
    spacePageControl1 = [[SMPageControl alloc] initWithFrame:CGRectMake(0,230, SCREEN_WIDTH,20)];
    spacePageControl1.center = CGPointMake(XYViewWidth(scrollviewtop)/2,self.frame.size.height-10);
    spacePageControl1.indicatorDiameter = 6.0f;
    spacePageControl1.indicatorMargin = 5.0f;
    spacePageControl1.alignment = SMPageControlAlignmentCenter;
    spacePageControl1.numberOfPages = 3;
    spacePageControl1.currentPage = 0;
    spacePageControl1.backgroundColor = [UIColor clearColor];
    [spacePageControl1 setPageIndicatorTintColor:[UIColor whiteColor]];
    [spacePageControl1 setCurrentPageIndicatorTintColor:COLORNOW(192, 42, 45)];
    [self addSubview:spacePageControl1];
}

-(void)clickselectexpression:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnExpressionBtTag;
    
    NSString *strexpression =[self returnexpressionstr:tagnow];
    if([self.delegate1 respondsToSelector:@selector(DGClickSelectExpression:)])
    {
        [self.delegate1 DGClickSelectExpression:strexpression];
    }
}

-(NSString *)returnexpressionstr:(int)tagnow
{
    NSString *strexpre = @"";
    switch (tagnow)
    {
        case 0:
            strexpre = @"[cw:bqcl]";
            break;
        case 1:
            strexpre = @"[cw:bc]";
            break;
        case 2:
            strexpre = @"[cw:dm]";
            break;
        case 3:
            strexpre = @"[cw:hh]";
            break;
        case 4:
            strexpre = @"[cw:ma]";
            break;
        case 5:
            strexpre = @"[cw:ngxk]";
            break;
        case 6:
            strexpre = @"[cw:nb]";
            break;
        case 7:
            strexpre = @"[cw:sdd]";
            break;
        case 8:
            strexpre = @"[cw:sjxx]";
            break;
        case 9:
            strexpre = @"[cw:tj]";
            break;
        case 10:
            strexpre = @"[cw:xsa]";
            break;
        case 11:
            strexpre = @"[cw:xdd]";
            break;
        case 12:
            strexpre = @"[cw:ztl]";
            break;
        case 13:
            strexpre = @"[cw:zqzs]";
            break;

    }
    return strexpre;
}

@end
