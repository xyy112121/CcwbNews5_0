//
//  ApplicationHpView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/7/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ApplicationHpView.h"

@implementation ApplicationHpView

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.backgroundColor = [UIColor whiteColor];
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		
        [self initview:nil];
	}
	return self;
}

-(void)initview:(NSDictionary *)dic
{
    arrayheight = [[NSMutableArray alloc] init];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-47-64)];
    tableview.showsVerticalScrollIndicator = NO;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:tableview];
    
    [self commitgetapplist:@"1" PageSize:@"10"];

    [self addSubview:[self addnctl]];
    YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
    
    imageViewgif.tag = EnYLImageViewTag;
    imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
    [app.window addSubview:imageViewgif];
}

-(UIView *)addnctl
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    view.backgroundColor = [UIColor whiteColor];
    
    HpNavigateView *hpna = [[HpNavigateView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44) FromFlag:@"100"];
    hpna.delegate1 = self;
    [view addSubview:hpna];
    
    return view;
}


-(void)tableviewcellheight:(NSArray *)arraysrc
{
    for(int i=0;i<[arraysrc count];i++)
    {
        NSDictionary *dictemp = [arraysrc objectAtIndex:i];
        EnCellType celltype = [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
        float nowheight;
        switch (celltype)
        {
            case EnCellTypeFocus:
                nowheight = 160;
                if(iphone6)
                    nowheight = nowheight*iphone6ratio;
                else if(iphone6p)
                    nowheight = nowheight*iphone6pratio;
                [arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
                break;
            case EnCellTypeAdUrl:
                nowheight = 240;
                if(iphone6p)
                    nowheight = 200*iphone6pratio;
                else if(iphone6)
                    nowheight = 200*iphone6ratio;
                
                [arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
                break;
            case EnCellTypeApplicationapp:
                nowheight = 100;
                [arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
                break;
                default:
                break;
        }
    }
}

#pragma mark tableviewdelegate
#pragma mark tableview 代理
-(void)viewDidLayoutSubviews
{
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arraydata count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.section];
    if([[dictemp objectForKey:@"show_type"] isEqualToString:@"focus"])
    {
        float nowheight = 160;
        if(iphone6)
            nowheight = nowheight*iphone6ratio;
        else if(iphone6p)
            nowheight = nowheight*iphone6pratio;
        return nowheight;
    }
    else if([[dictemp objectForKey:@"show_type"] isEqualToString:@"addapp"])
    {
        return 80;
    }
    else
    {
        float nowheight = 200;
        if(iphone6p)
            nowheight = 200*iphone6pratio;
        else if(iphone6)
            nowheight = 200*iphone6ratio;
        return nowheight;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dicdata = [arraydata objectAtIndex:section];
    if([[dicdata objectForKey:@"show_type"] isEqualToString:@"adurl"])
        return 1;
    else if([[dicdata objectForKey:@"show_type"] isEqualToString:@"focus"])
        return 1;
    return [(NSArray *)[dicdata  objectForKey:@"list"] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dicdata = [arraydata objectAtIndex:section];
    if([[dicdata objectForKey:@"show_type"] isEqualToString:@"addapp"])
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,45)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *labelgray = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 5)];
        labelgray.backgroundColor = COLORNOW(220, 220, 220);
        [view addSubview:labelgray];
        
        UILabel *labeltypename = [[UILabel alloc] initWithFrame:CGRectMake(15, 15,150, 20)];
        labeltypename.text = [dicdata objectForKey:@"name"];
        labeltypename.font = FONTN(16.0f);
        labeltypename.textColor = COLORNOW(128, 128, 128);
        [view addSubview:labeltypename];
        
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
        [view addSubview:buttonmore];
        
        UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 0.7)];
        imageline.backgroundColor  = COLORNOW(220, 220, 220);
        [view addSubview:imageline];
        
        return view;
    }
//    else if([[dicdata objectForKey:@"show_type"] isEqualToString:@"adurl"])
//    {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,45)];
//        view.backgroundColor = [UIColor clearColor];
//        
//        UILabel *labelgray = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 5)];
//        labelgray.backgroundColor = COLORNOW(220, 220, 220);
//        [view addSubview:labelgray];
//        
//        UILabel *labeltypename = [[UILabel alloc] initWithFrame:CGRectMake(15, 15,150, 20)];
//        labeltypename.text = [dicdata objectForKey:@"name"];
//        labeltypename.font = FONTN(16.0f);
//        labeltypename.textColor = COLORNOW(128, 128, 128);
//        [view addSubview:labeltypename];
//        
//        UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 0.7)];
//        imageline.backgroundColor  = COLORNOW(220, 220, 220);
//        [view addSubview:imageline];
//        
//        return view;
//    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *dicdata = [arraydata objectAtIndex:section];
    if([[dicdata objectForKey:@"show_type"] isEqualToString:@"addapp"])
    {
        return 45;
    }
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    float nowheight;
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.section];
    EnCellType celltype=  [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
    FocusApplicationView *focusnews;
    ApplicationViewCell *applicationcell;
    ApplicationAdView *appadview;
    NSArray *arraylist;
    switch (celltype)
    {
        case EnCellTypeFocus:
            focusnews = [[FocusApplicationView alloc] initWithFrame1:CGRectMake(0, 0, SCREEN_WIDTH, 160) Focus:dictemp];
            focusnews.delegate1 = self;
            [cell.contentView addSubview:focusnews];
            break;
        case EnCellTypeApplicationapp:
            arraylist = [dictemp objectForKey:@"list"];
            applicationcell = [[ApplicationViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) Dicsrc:[arraylist objectAtIndex:indexPath.row]];
            applicationcell.delegate1 = self.delegate1;
            [cell.contentView addSubview:applicationcell];
            break;
        case EnCellTypeAdUrl:
            
            appadview = [[ApplicationAdView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) Dicsrc:dictemp];
            [cell.contentView addSubview:appadview];
            break;
        default:
            cell.textLabel.text = [NSString stringWithFormat:@"123+%d",(int)indexPath.row];
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark ACtiondelegate
-(void)DGClickApplicationHpViewManger:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGClickOpenAppManger:)])
    {
        [self.delegate1 DGClickOpenAppManger:sender];
    }
}

#pragma mark IBaction
-(void)gotomoreandmorenews:(id)sender
{
    
}


#pragma mark 接口
-(void)commitgetapplist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"page"] = page;
//    params[@"pagesize"] = pagesize;
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceApplicationList ShowView:app.window alwaysdo:^
     {
         
     }
                                          Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             arraydata  = [dic objectForKey:@"data"];
             [self tableviewcellheight:arraydata];
             tableview.delegate= self;
             tableview.dataSource = self;
             
             [tableview reloadData];
         }
         else
         {
             
             [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
         }
         [[app.window viewWithTag:EnYLImageViewTag] removeFromSuperview];
     }Failur:^(NSString *strmsg) {
         [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
         [[app.window viewWithTag:EnYLImageViewTag] removeFromSuperview];
     }];
}


@end
