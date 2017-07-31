//
//  ScanQRCodeViewController.m
//  DiDi
//
//  Created by jaybin on 15/7/28.
//  Copyright (c) 2015年 jaybin. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "QRView.h"
#import "Masonry.h"
#import "UIColor+HEX.h"

#define IOS_VERSION    [[[UIDevice currentDevice] systemVersion] floatValue]

#define LIGHTBUTTONTAG      200
#define IMPORTBUTTONTAG     201
#define IMPORTQRcode    202
#define IMPORTARcode    205
#define ImageBgTag     203

@interface ScanQRCodeViewController (){
    ZBarReaderView *_readview;//扫描二维码ZBarReaderView
    QRView *_qrRectView;//自定义的扫描视图
    
    UIButton *_lightingBtn;//照明按钮
    UIButton *_importQRCodeImageBtn;//导入二维码图片按钮
    UIButton *_importQRCodeImage;
	UIButton *_ARCodeScanBtn; //AR扫描
	UIButton *_QRCodeScanBtn;//二维码扫描
    UIImagePickerController *_picker;//系统相册视图

}

@end

@implementation ScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化扫描视图
	scanstatus = EnQRCode;
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
    [self configuredZBarReader];
    
}

-(void)viewWillAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:YES];
    [super viewWillAppear:animated];
    //开始扫描
    [self setZBarReaderViewStart];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //停止扫描
    [self setZBarReaderViewStop];
	[self closeglview];
}

/**
 *初始化扫描二维码对象ZBarReaderView
 *设置扫描二维码视图的窗口布局、参数
 */
-(void)configuredZBarReader{
    //初始化照相机窗口
    _readview = [[ZBarReaderView alloc] init];
    //设置扫描代理
    _readview.readerDelegate = self;
    //关闭闪光灯
    _readview.torchMode = 0;
    //显示帧率
    _readview.showsFPS = NO;
    //将其照相机拍摄视图添加到要显示的视图上
    [self.view addSubview:_readview];
    //二维码/条形码识别设置
    ZBarImageScanner *scanner = _readview.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    //Layout ZBarReaderView
    __weak __typeof(self) weakSelf = self;
    [_readview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(0);
        make.left.equalTo(weakSelf.view).with.offset(0);
        make.right.equalTo(weakSelf.view).with.offset(0);
        make.bottom.equalTo(weakSelf.view).with.offset(0);
    }];
    
    //初始化扫描二维码视图的子控件
    [self configuredZBarReaderMaskView];
    
    //启动，必须启动后，手机摄影头拍摄的即时图像菜可以显示在readview上
    //[_readview start];
    //[_qrRectView startScan];
}


/**
 *自定义扫描二维码视图样式
 *初始化扫描二维码视图的子控件
 */
- (void)configuredZBarReaderMaskView{
	
	
    //扫描的矩形方框视图
    _qrRectView = [[QRView alloc] init];
    _qrRectView.transparentArea = CGSizeMake(SCREEN_WIDTH-100, SCREEN_WIDTH-100);
    _qrRectView.backgroundColor = [UIColor clearColor];
    [_readview addSubview:_qrRectView];
    [_qrRectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_readview).with.offset(0);
        make.left.equalTo(_readview).with.offset(0);
        make.right.equalTo(_readview).with.offset(0);
        make.bottom.equalTo(_readview).with.offset(0);
    }];
	
//    //照明按钮
//    _lightingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_lightingBtn setImage:LOADIMAGE(@"QR_电筒", @"png") forState:UIControlStateNormal];
//    [_lightingBtn setBackgroundColor:[UIColor clearColor]];
//    _lightingBtn.tag = LIGHTBUTTONTAG;
//    [_lightingBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [_qrRectView addSubview:_lightingBtn];
//    [_lightingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(buttoninput.mas_bottom).with.offset(30);
//        make.centerX.equalTo(_qrRectView);
//        make.size.mas_equalTo(CGSizeMake(40, 40));
//    }];
	

	//二维码扫描
	_QRCodeScanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_QRCodeScanBtn.layer.borderColor = [UIColor clearColor].CGColor;
	_QRCodeScanBtn.frame = CGRectMake((SCREEN_WIDTH-100-160)/2, SCREEN_HEIGHT-130, 80, 100);
	[_QRCodeScanBtn setImage:LOADIMAGE(@"QRCode选中icon", @"png") forState:UIControlStateNormal];
	[_QRCodeScanBtn setTitle:@"二维码" forState:UIControlStateNormal];
	[_QRCodeScanBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0, 20, -20)];
	[_QRCodeScanBtn setTitleEdgeInsets:UIEdgeInsetsMake(70, -50, 0, 0)];
	_QRCodeScanBtn.titleLabel.font = FONTN(15.0f);
	[_QRCodeScanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_QRCodeScanBtn setBackgroundColor:[UIColor clearColor]];
	_QRCodeScanBtn.tag = IMPORTQRcode;
	[_QRCodeScanBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[_qrRectView addSubview:_QRCodeScanBtn];
	
	//AR扫描
	_ARCodeScanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_ARCodeScanBtn.layer.borderColor = [UIColor clearColor].CGColor;
	_ARCodeScanBtn.frame = CGRectMake(_QRCodeScanBtn.frame.origin.x+_QRCodeScanBtn.frame.size.width+100, SCREEN_HEIGHT-130, 80, 100);
	[_ARCodeScanBtn setImage:LOADIMAGE(@"AR未选中icon", @"png") forState:UIControlStateNormal];
	[_ARCodeScanBtn setTitle:@"AR" forState:UIControlStateNormal];
	_ARCodeScanBtn.titleLabel.font = FONTN(15.0f);
	[_ARCodeScanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_ARCodeScanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, -20)];
	[_ARCodeScanBtn setTitleEdgeInsets:UIEdgeInsetsMake(70, -55, 0, 0)];
	[_ARCodeScanBtn setBackgroundColor:[UIColor clearColor]];
	_ARCodeScanBtn.tag = IMPORTARcode;
	[_ARCodeScanBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[_qrRectView addSubview:_ARCodeScanBtn];
	
	
	
	_importQRCodeImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_importQRCodeImageBtn.layer.borderColor = [UIColor clearColor].CGColor;
	_importQRCodeImageBtn.frame = CGRectMake(SCREEN_WIDTH-50, 22, 40, 40);
	[_importQRCodeImageBtn setTitle:@"相册" forState:UIControlStateNormal];
	[_importQRCodeImageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	_importQRCodeImageBtn.titleLabel.font = FONTN(15.0f);
	[_importQRCodeImageBtn setBackgroundColor:[UIColor clearColor]];
	_importQRCodeImageBtn.tag = IMPORTBUTTONTAG;
	[_importQRCodeImageBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[_qrRectView addSubview:_importQRCodeImageBtn];
	
	//返回按钮
	UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
	btreturn.layer.borderColor = [UIColor clearColor].CGColor;
	btreturn.frame = CGRectMake(10, 22, 40, 40);
	[btreturn setImage:LOADIMAGE(@"arrowleft", @"png") forState:UIControlStateNormal];
	[btreturn addTarget:self action:@selector(returnback:) forControlEvents:UIControlEventTouchUpInside];
	[btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
	[_readview addSubview:btreturn];
}

- (void)buttonClicked:(UIButton *)sender{
	UIButton *button1 = [self.view viewWithTag:IMPORTQRcode];
	UIButton *button2 = [self.view viewWithTag:IMPORTARcode];
    switch (sender.tag) {
        case LIGHTBUTTONTAG://照明按钮
        {
            if(0 != _readview.torchMode){
                //关闭闪光灯
                _readview.torchMode = 0;
            }else if (0 == _readview.torchMode){
                //打开闪光灯
                _readview.torchMode = 1;
            }
            
        }
            break;
        case IMPORTBUTTONTAG://导入二维码图片
        {
            [self presentImagePickerController];
        }
            break;
		case IMPORTQRcode:    //扫描二维码
		{
			if(scanstatus!=EnQRCode)
			{
				[button1 setImage:LOADIMAGE(@"QRCode选中icon", @"png") forState:UIControlStateNormal];
				[button2 setImage:LOADIMAGE(@"AR未选中icon", @"png") forState:UIControlStateNormal];
				[self closeglview];
				scanstatus = EnQRCode;
				[self setZBarReaderViewStart];
			}

		}
			break;
		case IMPORTARcode:   //扫描AR
		{
			if(scanstatus!=EnARCode)
			{
				[button1 setImage:LOADIMAGE(@"QRCode未选中icon", @"png") forState:UIControlStateNormal];
				[button2 setImage:LOADIMAGE(@"ARCode选中icon", @"png") forState:UIControlStateNormal];
				scanstatus = EnARCode;
				[self setZBarReaderViewStop];
				[self gotoopenar];
			}
		}
			break;
        default:
            break;
    }
}

-(void)gotoopenar
{
	self.glView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:self.glView];
	[self.glView setOrientation:self.interfaceOrientation];
	[self.glView start];
	[self.glView resize:self.view.bounds orientation:self.interfaceOrientation];
	
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 22, 40, 40)];
	UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
	button.layer.borderColor = [UIColor clearColor].CGColor;
	[button setImage:LOADIMAGE(@"arrowleft", @"png") forState:UIControlStateNormal];
	[button addTarget:self action: @selector(returnback:) forControlEvents: UIControlEventTouchUpInside];
	[contentView addSubview:button];
	[self.glView addSubview:contentView];
	
	//二维码扫描
	_QRCodeScanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_QRCodeScanBtn.layer.borderColor = [UIColor clearColor].CGColor;
	_QRCodeScanBtn.frame = CGRectMake((SCREEN_WIDTH-100-160)/2, SCREEN_HEIGHT-130, 80, 100);
	[_QRCodeScanBtn setTitle:@"二维码" forState:UIControlStateNormal];
	[_QRCodeScanBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0, 20, -20)];
	[_QRCodeScanBtn setTitleEdgeInsets:UIEdgeInsetsMake(70, -50, 0, 0)];
	_QRCodeScanBtn.titleLabel.font = FONTN(15.0f);
	[_QRCodeScanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_QRCodeScanBtn setImage:LOADIMAGE(@"QRCode未选中icon", @"png") forState:UIControlStateNormal];
	[_QRCodeScanBtn setBackgroundColor:[UIColor clearColor]];
	_QRCodeScanBtn.tag = IMPORTQRcode;
	[_QRCodeScanBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.glView addSubview:_QRCodeScanBtn];
	
	//AR扫描
	_ARCodeScanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_ARCodeScanBtn.layer.borderColor = [UIColor clearColor].CGColor;
	_ARCodeScanBtn.frame = CGRectMake(_QRCodeScanBtn.frame.origin.x+_QRCodeScanBtn.frame.size.width+100, SCREEN_HEIGHT-130, 80, 100);
	[_ARCodeScanBtn setTitle:@"AR" forState:UIControlStateNormal];
	_ARCodeScanBtn.titleLabel.font = FONTN(15.0f);
	[_ARCodeScanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_ARCodeScanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, -20)];
	[_ARCodeScanBtn setTitleEdgeInsets:UIEdgeInsetsMake(70, -55, 0, 0)];
	[_ARCodeScanBtn setImage:LOADIMAGE(@"AR选中icon", @"png") forState:UIControlStateNormal];
	[_ARCodeScanBtn setBackgroundColor:[UIColor clearColor]];
	_ARCodeScanBtn.tag = IMPORTARcode;
	[_ARCodeScanBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.glView addSubview:_ARCodeScanBtn];
	
	
}

-(void)closeglview
{
	[self.glView stop];
	[self.glView removeFromSuperview];
	self.glView=nil;
	
}

/**
 *打开二维码扫描视图ZBarReaderView
 */
- (void)setZBarReaderViewStart{
    _readview.torchMode = 0;//关闭闪光灯
    [_readview start];//开始扫描二维码
    [_qrRectView startScan];
    
}

/**
 *关闭二维码扫描视图ZBarReaderView
 */
- (void)setZBarReaderViewStop{
    _readview.torchMode = 0;//关闭闪光灯
    [_readview stop];//关闭扫描二维码
    [_qrRectView stopScan];
}

//弹出系统相册、相机
-(void)presentImagePickerController{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _picker = [[UIImagePickerController alloc] init];
    _picker.sourceType               = sourceType;
    _picker.allowsEditing            = YES;
    _picker.delegate                 = self;
	
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_picker.view];
    [_picker.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
        make.size.equalTo(window);
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //收起相册
    [picker.view removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}



#pragma mark navigation 代理
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
	viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
	viewController.navigationItem.rightBarButtonItem.customView.layer.borderColor = [UIColor clearColor].CGColor;
}

#pragma mark IBAction
-(void)pickerremove
{
	[_picker.view removeFromSuperview];
}

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



-(void)returnback:(id)sender
{
	[self closeglview];
	[self setZBarReaderViewStop];
	[self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark -
#pragma mark ZBarReaderViewDelegate
//扫描二维码的时候，识别成功会进入此方法，读取二维码内容
- (void) readerView: (ZBarReaderView*) readerView
     didReadSymbols: (ZBarSymbolSet*) symbols
          fromImage: (UIImage*) image{
    //停止扫描
    [self setZBarReaderViewStop];
    
    ZBarSymbol *symbol = nil;
    for (symbol in symbols) {
        break;
    }
    NSString *urlStr = symbol.data;
    
    if(urlStr==nil || urlStr.length<=0){
        //二维码内容解析失败
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"扫描失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        __weak __typeof(self) weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //重新扫描
            [weakSelf setZBarReaderViewStart];
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:^{
        }];
        
        return;
    }
	if([AddInterface isValidateURL:urlStr])//_roaldSearchText
	{
        [self gotowkwebview:urlStr];
	}
	else
	{
        [self getQRCodeInfoRecord:urlStr];
        [self getQRCodeInfo:urlStr];
	}
	
    NSLog(@"urlStr: %@",urlStr);

	
//	[self getscancodevalid:urlStr Typeid:codetype==EnToOrgin?@"suyuan":@"fanli"];
	
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
//导入二维码的时候会进入此方法，处理选中的相片获取二维码内容
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //停止扫描
    [self setZBarReaderViewStop];
    
    //处理选中的相片,获得二维码里面的内容
    ZBarReaderController *reader = [[ZBarReaderController alloc] init];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGImageRef cgimage = image.CGImage;
    ZBarSymbol *symbol = nil;
    for(symbol in [reader scanImage:cgimage])
        break;
    NSString *urlStr = symbol.data;
    
    [picker.view removeFromSuperview];
    
    if(urlStr==nil || urlStr.length<=0){
        //二维码内容解析失败
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"此二维码不能识别" message:nil preferredStyle:UIAlertControllerStyleAlert];
        __weak __typeof(self) weakSelf = self;
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //重新扫描
            [weakSelf setZBarReaderViewStart];
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:^{
        }];

        return;
    }
//	[self getscancodevalid:urlStr Typeid:codetype==EnToOrgin?@"suyuan":@"fanli"];
    NSLog(@"urlStr: %@",urlStr);
	
	
}

-(void)donecodevalid:(NSString *)sender
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:sender message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		[self setZBarReaderViewStart];
	}];
	
	// Add the actions.
	[alertController addAction:otherAction];
	
	[self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 接口
//记录扫码
-(void)getQRCodeInfoRecord:(NSString *)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cw_content"] = sender;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceScanCodeRecord ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
    }];
}

-(void)getQRCodeInfo:(NSString *)sender
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cw_content"] = sender;
	
    [RequestInterface doGetJsonWithParametersNoAn:params App:app ReqUrl:InterfaceScanCode ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:app.window];
    }];

    
//	[RequestInterface doGetJsonWithParameterscompleteurl:params App:app ReqUrl:sender ShowView:app.window alwaysdo:^{
//		
//	} Success:^(NSDictionary *dic) {
//		DLog(@"dic====%@",dic);
//		if([[dic objectForKey:@"success"] isEqualToString:@"true"])
//		{
//			if([[dic objectForKey:@"url"] length]>0)
//			{
//				[self gotowkwebview:[dic objectForKey:@"url"]];
//			}
//			else
//			{
//				[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
//				[self setZBarReaderViewStart];
//			}
//			
//		}
//		else
//		{
//			[MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
//			[self setZBarReaderViewStart];
//		}
//	} Failur:^(NSString *strmsg) {
//		[MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
//		[self setZBarReaderViewStart];
//	}];
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
