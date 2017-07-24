//
//  NewsListViewController.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "NewsListViewController.h"

@interface NewsListViewController ()

@end

@implementation NewsListViewController

/**
 *  首页
 */

#pragma mark 初始化信息
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self initparament:nil];
    
    [[self.navigationController.navigationBar viewWithTag:EnHpNctlViewTag] removeFromSuperview];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    [button setImage:LOADIMAGE(@"arrowleftred", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}

-(void)initparament:(id)sender
{
    self.title = @"更多";
    nowpage = 1;
    arraydata=[[NSMutableArray alloc] init];
    arrayheight = [[NSMutableArray alloc] init];    //高度
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = COLORNOW(237, 237, 237);
    if(tableview == nil)
    {
        [self addtableview];
    }
    [self gethpapplist:[NSString stringWithFormat:@"%d",nowpage] CW_Type:self.fccw_type City:app.diliweizhi.dilicity Header:@"YES" CW_Time:strcw_time];
}

-(void)addtableview
{
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-47-20)];
    tableview.showsVerticalScrollIndicator = NO;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.hidden = YES;
    footer.automaticallyRefresh = YES;
    
    tableview.mj_header = header;
    tableview.mj_footer = footer;
    
    YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
    [self.view addSubview:imageViewgif];
    imageViewgif.tag = EnYLImageViewTag;
    imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
}


#pragma mark IBaction
-(void)returnback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    app.gnctl = self.navigationController;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}



-(void)tableviewcellheight:(NSArray *)arraysrc
{
    for(int i=0;i<[arraysrc count];i++)
    {
        NSDictionary *dictemp = [arraysrc objectAtIndex:i];
        EnCellType celltype = [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
        float nowheight;
        UIView *viewtemp;
        NSArray *arraygoodlist;
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
            case EnCellTypeSudden:
                viewtemp = [[BurstNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110) Dicsrc:dictemp];
                [arrayheight addObject:[NSString stringWithFormat:@"%f",viewtemp.frame.size.height]];
                break;
            case EnCellTypeNews:
                nowheight = 100;
                viewtemp = [[CustomNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp];
                [arrayheight addObject:[NSString stringWithFormat:@"%f",viewtemp.frame.size.height]];
                break;
            case EnCellTypeMore:
                viewtemp = [[MoreNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
                [arrayheight addObject:[NSString stringWithFormat:@"%f",viewtemp.frame.size.height]];
                break;
            case EnCellTypeUrl:
                nowheight = 240;
                if(iphone6p)
                    nowheight = 240*iphone6pratio;
                else if(iphone6)
                    nowheight = 240*iphone6ratio;
                
                [arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
                break;
            case EnCellTypeActivity:
                nowheight = 240;
                if(iphone6p)
                    nowheight = 240*iphone6pratio;
                else if(iphone6)
                    nowheight = 240*iphone6ratio;
                
                [arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
                break;
            case EnCellTypeApp:
                nowheight = 300;
                [arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
                break;
            case EnCellTypeNewsGroup:
                nowheight = 210;
                [arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
                break;
            case EnCellTypePhotoGroup:
                nowheight = 240;
                [arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
                break;
            case EnCellTypePhoto:
                nowheight = 255;
                [arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
                break;
            case EnCellTypeBiz: //商品
                arraygoodlist = [dictemp objectForKey:@"list"];
                if([arraygoodlist count]>0)
                    nowheight = 370;
                else
                    nowheight = 190;
                [arrayheight addObject:[NSString stringWithFormat:@"%f",nowheight]];
                break;
            default:
                [arrayheight addObject:[NSString stringWithFormat:@"%f",110.0f]];
                break;
        }
    }
}

#pragma mark actiondelegate代理
-(void)gotowkwebview:(NSString *)str
{
    WkWebViewCustomViewController *webviewcustom = [[WkWebViewCustomViewController alloc] init];
    NSString *requeststring = str;
    if([requeststring rangeOfString:@"?"].location !=NSNotFound)
    {
        requeststring = [NSString stringWithFormat:@"%@&cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requeststring,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid!=nil?app.userinfo.userid:@""];
    }
    else
    {
        requeststring = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requeststring,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid!=nil?app.userinfo.userid:@""];
    }
    webviewcustom.strurl = requeststring;
    [self.navigationController pushViewController:webviewcustom animated:YES];
}

#pragma mark 上拉下拉加载
-(void)loadNewData
{
    nowpage = 1;
//    [self gethpapplist:[NSString stringWithFormat:@"%d",nowpage] ChannelId:strchannelid City:app.diliweizhi.dilicity Header:@"YES" CW_Time:@""];
    YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
    [self.view addSubview:imageViewgif];
    imageViewgif.tag = EnYLImageViewTag;
    imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
    DLog(@"test");
}

-(void)loadMoreData
{
    DLog(@"test");
    
//    [self gethpapplist:[NSString stringWithFormat:@"%d",nowpage] ChannelId:strchannelid City:app.diliweizhi.dilicity Header:@"NO" CW_Time:strcw_time];
    YLImageView* imageViewgif = [[YLImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-160, 200, 200)];
    [self.view addSubview:imageViewgif];
    imageViewgif.tag = EnYLImageViewTag;
    imageViewgif.image = [YLGIFImage imageNamed:@"ccwb_common_write.gif"];
}

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
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [[arrayheight objectAtIndex:indexPath.row] floatValue];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [arrayheight count];
    
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
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    EnCellType celltype = [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
    FocusNewsView *focusnews;
    BurstNewsView *burstnews;
    CustomNewsView *customnews;
    MoreNewsView *moreview;
    ActivityNow *activitynow;
    ApplicationRecommendView *apprecommend;
    CcwbNewsSaidView *ccwbnews;
    TuJiView *ccwbtuji;
    URLTypeView *urltype;
    SingleTuJiView *singletuji;
    GoodsCellView *cellview;
    NSArray *arraygoodslist;
    switch (celltype)
    {
        case EnCellTypeFocus:
            focusnews = [[FocusNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) Focus:dictemp];
            focusnews.delegate1 = self;
            [cell.contentView addSubview:focusnews];
            break;
        case EnCellTypeSudden: //突发
            burstnews = [[BurstNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110) Dicsrc:dictemp];
            burstnews.delegate1 = self;
            [cell.contentView addSubview:burstnews];
            break;
        case EnCellTypeNews:   //普通新闻
            nowheight = 100;
            customnews = [[CustomNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp];
            [cell.contentView addSubview:customnews];
            break;
        case EnCellTypeMore:
            moreview = [[MoreNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            [cell.contentView addSubview:moreview];
            break;
        case EnCellTypeUrl:
            urltype = [[URLTypeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) Dicsrc:dictemp];
            urltype.delegate1 = self;
            [cell.contentView addSubview:urltype];
            break;
        case EnCellTypeActivity:
            activitynow = [[ActivityNow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) Dicsrc:dictemp];
            activitynow.delegate1 = self;
            [cell.contentView addSubview:activitynow];
            break;
        case EnCellTypeApp: //应用推荐
            apprecommend = [[ApplicationRecommendView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) Dicsrc:dictemp];
            apprecommend.delegate1 = self;
            [cell.contentView addSubview:apprecommend];
            break;
        case EnCellTypeNewsGroup:
            ccwbnews = [[CcwbNewsSaidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210) Dicsrc:dictemp];
            ccwbnews.delegate1= self;
            [cell.contentView addSubview:ccwbnews];
            break;
        case EnCellTypePhotoGroup:
            ccwbtuji = [[TuJiView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) Dicsrc:dictemp];
            ccwbtuji.delegate1= self;
            [cell.contentView addSubview:ccwbtuji];
            break;
        case EnCellTypePhoto:
            singletuji = [[SingleTuJiView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 255) Dicsrc:dictemp];
            singletuji.delegate1= self;
            [cell.contentView addSubview:singletuji];
            break;
        case EnCellTypeBiz:
            arraygoodslist = [dictemp objectForKey:@"list"];
            if([arraygoodslist count]>0)
                nowheight = 370;
            else
                nowheight = 190;
            
            cellview = [[GoodsCellView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, nowheight) Dicsrc:dictemp];
            cellview.delegate1 = self;
            [cell.contentView addSubview:cellview];
            break;
        default:
            cell.textLabel.text = [NSString stringWithFormat:@"123+%d",(int)indexPath.row];
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [arraydata objectAtIndex:indexPath.row];
    
    if([[dictemp objectForKey:@"show_type"] isEqualToString:@"LiveVideo"])
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            parameters[LVMovieParameterDisableDeinterlacing] = @(YES);
        
        /****这里换成直播、点播的地址****/
        NSString *path =  [dictemp objectForKey:@"url"];//@"http://r03.wscdn.hls.xiaoka.tv/live/xRfgXFw02cCzJZb8/playlist.m3u8";
        LVMovieViewController *videoPlayVC = [LVMovieViewController movieViewControllerWithContentPath:path parameters:parameters];
        [self presentViewController:videoPlayVC animated:YES completion:nil];
    }
    else
    {
        
        WkWebViewLocationHtmlViewController *wkwebview = [[WkWebViewLocationHtmlViewController alloc] init];
        [self.navigationController pushViewController:wkwebview animated:YES];
        //		WkWebViewCustomViewController *webviewcustom = [[WkWebViewCustomViewController alloc] init];
        //		webviewcustom.delegate1 = self;
        //		NSString *requeststring = [dictemp objectForKey:@"url"];
        //		if([requeststring length]>0)
        //		{
        //			if([requeststring rangeOfString:@"?"].location !=NSNotFound)
        //			{
        //				requeststring = [NSString stringWithFormat:@"%@&cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requeststring,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid!=nil?app.userinfo.userid:@""];
        //			}
        //			else
        //			{
        //				requeststring = [NSString stringWithFormat:@"%@?cw_version=%@&cw_device=%@&cw_machine_id=%@&cw_user_id=%@",requeststring,CwVersion,CwDevice,app.Gmachid,app.userinfo.userid!=nil?app.userinfo.userid:@""];
        //			}
        //			webviewcustom.strurl = requeststring;
        //			[self.navigationController pushViewController:webviewcustom animated:YES];
        //		}
    }
}

#pragma mark 接口
//列表
-(void)gethpapplist:(NSString *)page CW_Type:(NSString *)cw_type City:(NSString *)city Header:(NSString *)header CW_Time:(NSString *)cw_time
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cw_page"] = page;
    params[@"cw_city"] = city;
    params[@"cw_time"] = cw_time;
    if([self.fcfromflag isEqualToString:@"1"])//表示点击更多的列表
    {
        posturl = InterfaceMoreNewsList;
        params[@"cw_id"] = cw_type;
    }
    else
    {
        posturl = InterfaceMoreNewsRecommand;
        params[@"cw_type"] = cw_type;
    }
    
    
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:posturl ShowView:self.view alwaysdo:^
     {
         
     }
                                          Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             strcw_time = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cw_time"]];
             if([header isEqualToString:@"YES"])
             {
                 nowpage = nowpage+1;
                 arraydata = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"newsList"]];
                 
                 [arrayheight removeAllObjects];
                 
                 [self tableviewcellheight:arraydata];
                 
                 //用于存储首页应用推荐，便于操作的时候管理
                 for(int i=0;i<[arraydata count];i++)
                 {
                     NSDictionary *dictemp = [arraydata objectAtIndex:i];
                     EnCellType celltype = [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
                     switch (celltype)
                     {
                         case EnCellTypeApp:
                             app.arrapprecommend = [[NSMutableArray alloc] initWithArray:[dictemp objectForKey:@"list"]];
                             break;
                         default:
                             break;
                     }
                 }
                 
             }
             else
             {
                 NSArray *arraynew = [dic objectForKey:@"newsList"];
                 if([arraynew count]>0)   //当有新数据的时候页面加1
                     nowpage = nowpage+1;
                 for(int i=0;i<[arraynew count];i++)
                 {
                     NSDictionary *dictemp = [arraynew objectAtIndex:i];
                     [arraydata addObject:dictemp];
                 }
                 
                 [arrayheight removeAllObjects];
                 
                 [self tableviewcellheight:arraydata];
                 
                 //用于存储首页应用推荐，便于操作的时候管理
                 for(int i=0;i<[arraydata count];i++)
                 {
                     NSDictionary *dictemp = [arraydata objectAtIndex:i];
                     EnCellType celltype = [AddInterface GetCellType:[dictemp objectForKey:@"show_type"]];
                     switch (celltype)
                     {
                         case EnCellTypeApp:
                             app.arrapprecommend = [[NSMutableArray alloc] initWithArray:[dictemp objectForKey:@"list"]];
                             break;
                         default:
                             break;
                     }
                 }
                 
             }
             tableview.delegate = self;
             tableview.dataSource = self;
             if([arraydata count]==[arrayheight count])
                 [tableview reloadData];
             else
                 [MBProgressHUD showError:@"数据不称,请稍候再请求!" toView:app.window];
         }
         else
         {
             [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
         }
         // 结束刷新
         [tableview.mj_header endRefreshing];
         [tableview.mj_footer endRefreshing];
         [[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
     } Failur:^(NSString *strmsg) {
         [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
         [tableview.mj_header endRefreshing];
         [tableview.mj_footer endRefreshing];
         [[self.view viewWithTag:EnYLImageViewTag] removeFromSuperview];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
