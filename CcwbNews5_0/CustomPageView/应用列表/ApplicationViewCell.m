//
//  ApplicationViewCell.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ApplicationViewCell.h"

@implementation ApplicationViewCell

-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        dicsrc = dic;
        [self initview:dicsrc];
    }
    return self;
}

-(void)initview:(NSDictionary *)dicdata
{
    UIImageView *imageviewline = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.height, XYViewHeight(self), SCREEN_WIDTH, 0.7)];
    imageviewline.backgroundColor = COLORNOW(220, 220, 220);
    [self addSubview:imageviewline];
    
    UIImageView *imagepic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.height-20, self.frame.size.height-20)];
    [imagepic setImageWithURL:[NSURL URLWithString:[dicdata objectForKey:@"logo_pic_path"]] placeholderImage:LOADIMAGE(@"noimage", @"png")];
    imagepic.contentMode = UIViewContentModeScaleAspectFill;
    imagepic.clipsToBounds = YES;
    [self addSubview:imagepic];
    

    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewRight(imagepic)+10, XYViewTop(imagepic),180, 30)];
    labelname.text = [dicdata objectForKey:@"name"];
    labelname.font = FONTN(19.0f);
    labelname.textColor = [UIColor blackColor];
    [self addSubview:labelname];
    
    UILabel *labeldesc = [[UILabel alloc] initWithFrame:CGRectMake(XYViewLeft(labelname), XYViewBottom(labelname),SCREEN_WIDTH-150, 30)];
    labeldesc.text = [dicdata objectForKey:@"subtitle"];
    labeldesc.font = FONTN(14.0f);
    labeldesc.numberOfLines = 2;
    labeldesc.textColor = COLORNOW(153, 153, 153);
    [self addSubview:labeldesc];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-(XYViewHeight(self)-20), 10, XYViewHeight(self)-20, XYViewHeight(self)-20);
    button.backgroundColor = [UIColor clearColor];
    int flag = [self gethaveapplication];
    if(flag==0)
    {
        [button setImage:LOADIMAGE(@"添加red", @"png") forState:UIControlStateNormal];
    }
    else
    {
        [button setImage:LOADIMAGE(@"添加gray", @"png") forState:UIControlStateNormal];
    }
//    button.tag = EnAppRecommendBtTag+indexnow;
    [button addTarget:self action:@selector(clickaddapplication:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
}

-(int)gethaveapplication
{
    int flag = 0;
    for(int i=0;i<[app.arrayaddapplication count];i++)
    {
        NSDictionary *dictemp = [app.arrayaddapplication objectAtIndex:i];
        if([[dictemp objectForKey:@"id"] isEqualToString:[dicsrc objectForKey:@"id"]])
        {
            flag = 1;
            break;
        }
    }
    return flag;
}

-(void)clickaddapplication:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    int flag = [self gethaveapplication];
    
    if(flag == 1)
    {
        [self deleteappmachine:[dicsrc objectForKey:@"id"] Button:button];
    }
    else
    {
        [self addappmachine:[dicsrc objectForKey:@"id"] Button:button];
    }
    
    
}

#pragma mark interface

-(void)addappmachine:(NSString *)appid Button:(UIButton *)button
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cw_app_id"] = appid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceAddApp ShowView:app.window alwaysdo:^
     {
         
     }
     Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             [button setImage:LOADIMAGE(@"添加gray", @"png") forState:UIControlStateNormal];
             if([self.delegate1 respondsToSelector:@selector(DGclickAddAppMachine:)])
             {
                 NSArray *arrayapp = [dic objectForKey:@"appList"];
                 if([arrayapp count]>0)
                 {
                     [app.arrayaddapplication addObject:[arrayapp objectAtIndex:0]];
                     [self.delegate1 DGclickAddAppMachine:[arrayapp objectAtIndex:0]];
                     
                 }
             }
             
         }
         else
         {
             [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
         }
     } Failur:^(NSString *strmsg) {
         [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
     }];
    
}

-(void)deleteappmachine:(NSString *)appid Button:(UIButton *)button
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cw_app_id"] = appid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceDeleteApp ShowView:app.window alwaysdo:^
     {
         
     }
                                          Success:^(NSDictionary *dic)
     {
         DLog(@"dic====%@",dic);
         if([[dic objectForKey:@"success"] isEqualToString:@"true"])
         {
             [button setImage:LOADIMAGE(@"添加red", @"png") forState:UIControlStateNormal];
             if([self.delegate1 respondsToSelector:@selector(DGclickAddAppMachine:)])
             {
                 NSArray *arrayapp = [dic objectForKey:@"appList"];
                 if([arrayapp count]>0)
                 {
                     NSDictionary *dic2 = [arrayapp objectAtIndex:0];
                     for(int i=0;i<[app.arrayaddapplication count];i++)
                     {
                         NSDictionary *dic1 = [app.arrayaddapplication objectAtIndex:i];
                         if([[dic1 objectForKey:@"id"] isEqualToString:[dic2 objectForKey:@"id"]])
                         {
                             [app.arrayaddapplication removeObject:dic1];
                             [self.delegate1 DGclickAddAppMachine:[arrayapp objectAtIndex:0]];
                             break;
                         }
                         
                     }
                     
                     
                 }
             }
             
             //			 if([self.delegate1 respondsToSelector:@selector(DGclickAddAppMachine:)])
             //			 {
             //				 [app.arrayaddapplication removeObject:sender];
             //				 [arraynowapplication removeObject:sender];
             //				 [self.delegate1 DGclickAddAppMachine:sender];
             //				 [tableview reloadData];
             //			 }
             
             
         }
         else
         {
             [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
         }
     } Failur:^(NSString *strmsg) {
         [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
     }];
    
}


@end
