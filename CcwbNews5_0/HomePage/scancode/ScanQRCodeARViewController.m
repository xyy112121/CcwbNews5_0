//
//  ScanQRCodeARViewController.m
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "ScanQRCodeARViewController.h"

@interface ScanQRCodeARViewController ()<SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate>
{
    UIButton *_importQRCodeImageBtn;//导入二维码图片按钮
    UIButton *_QRCodeScanBtn;
    UIButton *_ARCodeScanBtn;
}
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property(nonatomic, strong) OpenGLView *glView;
@property(nonatomic,strong)SGQRCodeScanManager *manager;

@end

@implementation ScanQRCodeARViewController

-(void)returnback:(id)sender
{
    [self closeglview];
    [_manager SG_stopRunning];
    [self removeScanningView];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    NSLog(@"SGQRCodeScanningVC - dealloc");
    [self removeScanningView];
}

-(void)closeglview
{
    [_glView stop];
    [self.glView removeFromSuperview];
    self.glView=nil;
}


-(void)buttonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    UIButton *button1 = [self.view viewWithTag:IMPORTQRcode];
    UIButton *button2 = [self.view viewWithTag:IMPORTARcode];
    switch (button.tag)
    {
        case IMPORTQRcode:    //扫描二维码
        {
            if(scanstatus!=EnQRCode)
            {
                [button1 setImage:LOADIMAGE(@"QRCode选中icon", @"png") forState:UIControlStateNormal];
                [button2 setImage:LOADIMAGE(@"AR未选中icon", @"png") forState:UIControlStateNormal];
                [self closeglview];
                scanstatus = EnQRCode;
//                [self.view addSubview:self.scanningView];
//                [self setupQRCodeScanning];
//                [self.scanningView addTimer];
//                [self.manager SG_startRunning];
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
//                [self.manager SG_stopRunning];
//                [self removeScanningView];
                [self gotoopenar];
            }
        }
            break;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scanningView];
    [self setupQRCodeScanning];
    [self.scanningView addTimer];
    [self setupNavigationBar];
    scanstatus = EnQRCode;
}

- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [SGQRCodeScanningView scanningViewWithFrame:self.view.bounds layer:self.view.layer];
        
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
        [_scanningView addSubview:_QRCodeScanBtn];
        
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
        [_scanningView addSubview:_ARCodeScanBtn];
        
    }
    return _scanningView;
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


- (void)removeScanningView {
    [_scanningView removeTimer];
    [_scanningView removeFromSuperview];
    _scanningView = nil;
}

- (void)setupNavigationBar {
    //    self.navigationItem.title = @"扫一扫";
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
    
    [self.navigationController setNavigationBarHidden:YES];
    _importQRCodeImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _importQRCodeImageBtn.layer.borderColor = [UIColor clearColor].CGColor;
    _importQRCodeImageBtn.frame = CGRectMake(SCREEN_WIDTH-50, 22, 40, 40);
    [_importQRCodeImageBtn setTitle:@"相册" forState:UIControlStateNormal];
    [_importQRCodeImageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _importQRCodeImageBtn.titleLabel.font = FONTN(15.0f);
    [_importQRCodeImageBtn setBackgroundColor:[UIColor clearColor]];
    _importQRCodeImageBtn.tag = IMPORTBUTTONTAG;
    [_importQRCodeImageBtn addTarget:self action:@selector(rightBarButtonItenAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_importQRCodeImageBtn];
    
    //返回按钮
    UIButton *btreturn = [UIButton buttonWithType:UIButtonTypeCustom];
    btreturn.layer.borderColor = [UIColor clearColor].CGColor;
    btreturn.frame = CGRectMake(10, 22, 40, 40);
    [btreturn setImage:LOADIMAGE(@"arrowleft", @"png") forState:UIControlStateNormal];
    [btreturn addTarget:self action:@selector(returnback:) forControlEvents:UIControlEventTouchUpInside];
    [btreturn setTitleColor:COLORNOW(102, 102, 102) forState:UIControlStateNormal];
    [self.view addSubview:btreturn];
    
}

- (void)rightBarButtonItenAction {
    SGQRCodeAlbumManager *manager = [SGQRCodeAlbumManager sharedManager];
    [manager SG_readQRCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 栅栏函数
    dispatch_barrier_async(queue, ^{
        BOOL isPHAuthorization = manager.isPHAuthorization;
        if (isPHAuthorization == YES) {
            [self removeScanningView];
        }
    });
}

- (void)setupQRCodeScanning {
    self.manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [self.manager SG_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    self.manager.delegate = self;
}

#pragma mark - - - SGQRCodeAlbumManagerDelegate
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
    [self.view addSubview:self.scanningView];
}
- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    DLog(@"nsssss===%@",result);
    if ([result hasPrefix:@"http"]) {
        
        
    } else
    {
        
            }
}

#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager SG_palySoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager SG_stopRunning];
//        [scanManager SG_videoPreviewLayerRemoveFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        DLog(@"sdfasdfasfdasf===%@",[obj stringValue]);
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定删除此应用" preferredStyle: UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            [scanManager SG_startRunning];
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        
//        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
//        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//        jumpVC.jump_URL = [obj stringValue];
//        [self.navigationController pushViewController:jumpVC animated:YES];
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
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
