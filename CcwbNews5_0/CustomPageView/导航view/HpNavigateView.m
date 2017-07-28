//
//  HpNavigateView.m
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "HpNavigateView.h"

@implementation HpNavigateView

-(id)initWithFrame:(CGRect)frame FromFlag:(NSString *)from
{
	self = [super initWithFrame:frame];
	if (self)
	{
		fromflag = from;
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		if([fromflag isEqualToString:@"1"])
			[self initview]; //首页导航 栏上布局
        else if([fromflag isEqualToString:@"100"]) //应用列表导航
            [self initapplicationview];
		else
			[self initviewsearch];
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom
{
	self = [super initWithFrame:frame];
	if (self)
	{
		dicsrc = dicfrom;
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		if([[dicfrom objectForKey:@"type"] isEqualToString:@"1"])
			[self initnctltype1:dicfrom];
		else if([[dicfrom objectForKey:@"type"] isEqualToString:@"2"])    //左边是图片  中间是名称
			[self initnctltype2:dicfrom];
		else if([[dicfrom objectForKey:@"type"] isEqualToString:@"3"])   //表示右边是打开
			[self initnctltype3:dicfrom];
	}
	return self;
}


-(void)initview
{
	self.backgroundColor = [UIColor whiteColor];
	
	UIButton *buttonheader = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonheader.frame= CGRectMake(10, 2, 40, 40);
	buttonheader.userInteractionEnabled = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
	[buttonheader addGestureRecognizer:singleTap];
	buttonheader.tag = EnHpUserHeaderPic;
	buttonheader.layer.cornerRadius = 20.0f;
	buttonheader.clipsToBounds = YES;
	buttonheader.imageView.contentMode = UIViewContentModeScaleAspectFill;
	if([app.userinfo.userheader length]>0)
	{
		[buttonheader setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:app.userinfo.userheader] placeholderImage:LOADIMAGE(@"hp_个人头像", @"png")];
	}
	else
	{
		[buttonheader setImage:LOADIMAGE(@"hp_个人头像", @"png") forState:UIControlStateNormal];
	}
	[self addSubview:buttonheader];
	
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(buttonheader.frame.origin.x+buttonheader.frame.size.width+10, (self.frame.size.height-28)/2, SCREEN_WIDTH-120, 28)];
	imageview.layer.cornerRadius = 14.0f;
	imageview.clipsToBounds = YES;

	imageview.layer.borderColor = COLORNOW(232, 56, 47).CGColor;
	imageview.layer.borderWidth = 1.0f;
	[self addSubview:imageview];
	
	UIImageView *imageviewsearch = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10,imageview.frame.origin.y+6, 16, 16)];
	imageviewsearch.image = LOADIMAGE(@"hp_searchicon", @"png");
	[self addSubview:imageviewsearch];
	
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(imageviewsearch.frame.origin.x+imageviewsearch.frame.size.width+3, imageview.frame.origin.y+2, imageview.frame.size.width-imageviewsearch.frame.size.width-10, 24)];
	textfield.backgroundColor = [UIColor clearColor];
	textfield.delegate = self;
	textfield.font = FONTN(14.0f);
	textfield.placeholder = @"点击搜索";
	[self addSubview:textfield];
	
	UIButton *buttonQrcode = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonQrcode.layer.borderColor = [UIColor clearColor].CGColor;
	buttonQrcode.frame= CGRectMake(SCREEN_WIDTH-50, 2, 40, 40);
	[buttonQrcode setImage:LOADIMAGE(@"hp_souicon", @"png") forState:UIControlStateNormal];
	[buttonQrcode addTarget:self action:@selector(gotoqrcode:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonQrcode];

}

-(void)initapplicationview
{
    self.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.frame.size.height-28)/2, SCREEN_WIDTH-70, 28)];
    imageview.layer.cornerRadius = 14.0f;
    imageview.clipsToBounds = YES;
    
    imageview.layer.borderColor = COLORNOW(232, 56, 47).CGColor;
    imageview.layer.borderWidth = 1.0f;
    [self addSubview:imageview];
    
    UIImageView *imageviewsearch = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10,imageview.frame.origin.y+6, 16, 16)];
    imageviewsearch.image = LOADIMAGE(@"hp_searchicon", @"png");
    [self addSubview:imageviewsearch];
    
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(imageviewsearch.frame.origin.x+imageviewsearch.frame.size.width+3, imageview.frame.origin.y+2, imageview.frame.size.width-imageviewsearch.frame.size.width-10, 24)];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.delegate = self;
    textfield.font = FONTN(14.0f);
    textfield.placeholder = @"搜索你感兴趣的内容";
    [self addSubview:textfield];
    
    UIButton *buttonmanger = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonmanger.layer.borderColor = [UIColor clearColor].CGColor;
    buttonmanger.frame= CGRectMake(SCREEN_WIDTH-60, 2, 50, 40);
    [buttonmanger setTitle:@"管理" forState:UIControlStateNormal];
    buttonmanger.titleLabel.font = FONTN(16.0f);
    [buttonmanger setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonmanger addTarget:self action:@selector(gotoapplicationmanger:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonmanger];
}

-(void)initviewsearch
{
	self.backgroundColor = [UIColor whiteColor];
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.frame.size.height-28)/2, SCREEN_WIDTH-60, 28)];
	imageview.layer.cornerRadius = 14.0f;
	imageview.clipsToBounds = YES;
	imageview.layer.borderColor = COLORNOW(232, 56, 47).CGColor;
	imageview.layer.borderWidth = 1.0f;
	[self addSubview:imageview];
	
	UIImageView *imageviewsearch = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+10,imageview.frame.origin.y+6, 16, 16)];
	imageviewsearch.image = LOADIMAGE(@"hp_searchicon", @"png");
	[self addSubview:imageviewsearch];
	
	
	UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(imageviewsearch.frame.origin.x+imageviewsearch.frame.size.width+5, imageview.frame.origin.y+2, imageview.frame.size.width-imageviewsearch.frame.size.width-10, 24)];
	textfield.backgroundColor = [UIColor clearColor];
	textfield.textColor = [UIColor blackColor];
	textfield.delegate = self;
	textfield.font = FONTN(14.0f);
	textfield.tag = EnSearchTextFieldTag;
	textfield.placeholder = @"点击搜索";
	textfield.tintColor = [UIColor blackColor];
	[self addSubview:textfield];
	
	UIButton *buttonQrcode = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonQrcode.layer.borderColor = [UIColor clearColor].CGColor;
	buttonQrcode.frame= CGRectMake(SCREEN_WIDTH-50, 2, 40, 40);
	[buttonQrcode setTitle:@"取消" forState:UIControlStateNormal];
	buttonQrcode.titleLabel.font = FONTN(15.0f);
	[buttonQrcode setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[buttonQrcode addTarget:self action:@selector(clickcannelsearch:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:buttonQrcode];
	
	[textfield addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
	//注意：事件类型是：`UIControlEventEditingChanged`
	
}

-(void)passConTextChange:(id)sender{
	UITextField* target=(UITextField*)sender;
	if([[target text] length]==0)
	{
		if([self.delegate1 respondsToSelector:@selector(DGDeleteSearchTextfield:)])
		{
			[self.delegate1 DGDeleteSearchTextfield:@""];
		}
	}
	NSLog(@"%@",target.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	if([fromflag isEqualToString:@"2"])
	{
		if([textField.text length]>1)
		{
			if([self.delegate1 respondsToSelector:@selector(DGClickSearchTextField:)])
			{
				[self.delegate1 DGClickSearchTextField:textField.text];
			}
		}
		else
		{
			[MBProgressHUD showError:@"请输入至少两个字符" toView:app.window];
		}
	}
	
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if([fromflag isEqualToString:@"2"])
	{
		return YES;
	}
	else
	{
		if([self.delegate1 respondsToSelector:@selector(DGClickGoToSearch:)])
		{
			[self.delegate1 DGClickGoToSearch:nil];
		}
	}
	return NO;
}

-(void)clickcannelsearch:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGClickSearchCannel:)])
	{
		[self.delegate1 DGClickSearchCannel:nil];
	}
}

-(void)gotoqrcode:(id)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGClickgotoqrcode:)])
	{
		[self.delegate1 DGClickgotoqrcode:nil];
	}
}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGclickpersoncenter:)])
	{
		[self.delegate1 DGclickpersoncenter:nil];
	}
}


-(void)gotoapplicationmanger:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGClickApplicationHpViewManger:)])
    {
        [self.delegate1 DGClickApplicationHpViewManger:sender];
    }
}

//{"type":"0"}//显示空
//{"type":"1","title":"全球最大双机"}//显示标题
//{"type":"2","icon_path":"www.path","title":"全球最大双机"}   //显示标题和图标
//{"type":"3","icon_path":"www.path","title":"全球最大双机","subtitle":"身飞机在美国加州下线","rb_show":true,"rb_title":"打开","rb_jsevent":"onclick()"}

//导航栏type1
-(void)initnctltype1:(NSDictionary *)dic
{
	UIView *viewnctl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 44)];
	viewnctl.backgroundColor = [UIColor whiteColor];
	
	UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, SCREEN_WIDTH-200, 20)];
	title.backgroundColor = [UIColor clearColor];
	title.text = [dic objectForKey:@"title"];
	title.font = FONTN(16.0f);
	title.textAlignment = NSTextAlignmentCenter;
	title.textColor = [UIColor blackColor];
	[viewnctl addSubview:title];
	[self addSubview:viewnctl];
}

//导航栏type2
-(void)initnctltype2:(NSDictionary *)dic
{
	UIView *viewnctl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 44)];
	viewnctl.backgroundColor = [UIColor whiteColor];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 30, 30)];
	[imageicon setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"icon_path"]]];
	[viewnctl addSubview:imageicon];
	
	
	UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, SCREEN_WIDTH-180, 20)];
	title.backgroundColor = [UIColor clearColor];
	title.text = [dic objectForKey:@"title"];
	title.font = FONTN(16.0f);
	title.textAlignment = NSTextAlignmentCenter;
	title.textColor = [UIColor blackColor];
	[viewnctl addSubview:title];
	[self addSubview:viewnctl];
}

//导航 栏3
-(void)initnctltype3:(NSDictionary *)dic
{
	
	UIView *viewnctl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 44)];
	viewnctl.backgroundColor = [UIColor whiteColor];
	
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 30, 30)];
	[imageicon setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"icon_path"]]];
	[viewnctl addSubview:imageicon];
	
	UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(XYViewRight(imageicon)+3, XYViewTop(imageicon)-3, SCREEN_WIDTH-180, 20)];
	title.backgroundColor = [UIColor clearColor];
	title.text = [dic objectForKey:@"title"];
	title.font = FONTN(14.0f);
	title.textColor = [UIColor blackColor];
	[viewnctl addSubview:title];
	
	UILabel *subtitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewLeft(title), XYViewBottom(title)-3, SCREEN_WIDTH-180, 20)];
	subtitle.backgroundColor = [UIColor clearColor];
	subtitle.text = [dic objectForKey:@"subtitle"];
	subtitle.font = FONTN(13.0f);
	subtitle.textColor = COLORNOW(117, 117, 117);
	[viewnctl addSubview:subtitle];
	
	
    
    NSString *strname = @"添加";
    for(int i=0;i<[app.arrayaddapplication count];i++)
    {
        NSDictionary *dictemp = [app.arrayaddapplication objectAtIndex:i];
        if([[dictemp objectForKey:@"id"] isEqualToString:[dic objectForKey:@"id"]])
        {
            strname = @"打开";
        }
    }
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(SCREEN_WIDTH-80-50, 9, 70, 26);
	button.layer.cornerRadius = 13.0f;
	button.layer.borderColor = COLORNOW(232, 56, 47).CGColor;
	button.layer.borderWidth = 1.0f;
	button.clipsToBounds = YES;
	[button setTitleColor:COLORNOW(232, 56, 47) forState:UIControlStateNormal];
	button.titleLabel.font = FONTN(15.0f);
	[button setTitle:strname forState:UIControlStateNormal];
	[button addTarget:self action:@selector(clickbutevent:) forControlEvents:UIControlEventTouchUpInside];
	[viewnctl addSubview:button];
	
	
	[self addSubview:viewnctl];
	
}

-(void)clickbutevent:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSString *strname = [button currentTitle];
    if([strname isEqualToString:@"打开"])
    {
        if([self.delegate1 respondsToSelector:@selector(DGClickWebViewOpenApp:)])
        {
            [self.delegate1 DGClickWebViewOpenApp:[dicsrc objectForKey:@"id"]];
        }
    }
    else
    {
        [self addappmachine:[dicsrc objectForKey:@"id"] Button:button];
    }
//	if([self.delegate1 respondsToSelector:@selector(DGCLickNctlEvent:)])
//	{
//		[self.delegate1 DGCLickNctlEvent:[dicsrc objectForKey:@"rb_jsevent"]];
//	}
}

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
             [button setTitle:@"打开" forState:UIControlStateNormal];
             
             NSArray *arrayapp = [dic objectForKey:@"appList"];
             if([arrayapp count]>0)
             {
                 
                 if([self.delegate1 respondsToSelector:@selector(DGClickWebViewAddApp:)])
                 {
                     [self.delegate1 DGClickWebViewAddApp:[arrayapp objectAtIndex:0]];
                 }
                 
             }
             
             [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
             
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
