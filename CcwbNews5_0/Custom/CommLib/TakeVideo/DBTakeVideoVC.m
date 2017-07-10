//
//  DBTakeVideoVC.m
//  CustomVideoCapture
//
//  Created by dengbin on 15/1/15.
//  Copyright (c) 2015年 IUAIJIA. All rights reserved.
//

#import "DBTakeVideoVC.h"
#import "DBPlayVideoVC.h"

#import "SVProgressHUD.h"
#import <MediaPlayer/MediaPlayer.h>


#define MAX_VIDEO_DUR    10
#define COUNT_DUR_TIMER_INTERVAL  0.025
#define VIDEO_FOLDER    @"videos"
@interface DBTakeVideoVC ()
{
    
    NSURL *_finashURL;
    MPMoviePlayerController *_player;

    float   _float_totalDur;
    float   _float_currentDur;
}
@property(nonatomic,strong)AVCaptureSession      *captureSession;
@property(nonatomic,strong)AVCaptureDeviceInput  *videoDeviceInput;
@property(nonatomic,strong)AVCaptureMovieFileOutput *movieFileOutput;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *preViewLayer;
@property(nonatomic,strong)UIView          *preview;
@property(nonatomic,strong)UIProgressView  *progressView;
@property(nonatomic,strong)NSTimer     *timer;
@property(nonatomic,strong)NSMutableArray     *files;

@property(nonatomic,unsafe_unretained)BOOL      isCameraSupported;
@property(nonatomic,unsafe_unretained)BOOL      isTorchSupported;
@property(nonatomic,unsafe_unretained)BOOL      isFrontCameraSupported;

@end

@implementation DBTakeVideoVC
@synthesize delegate1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建视频存储目录
    [[self class] createVideoFolderIfNotExist];


    //用来存储视频路径 以便合成时使用
    self.files=[NSMutableArray array];
    
    //创建视频捕捉窗口
    [self initCapture];
    
    
    //创建录像按钮
    [self initRecordButton];
    
    // Do any additional setup after loading the view.
}


-(void)initCapture
{
    self.captureSession = [[AVCaptureSession alloc]init];
    [_captureSession setSessionPreset:AVCaptureSessionPresetLow];

    
    AVCaptureDevice *frontCamera = nil;
    AVCaptureDevice *backCamera = nil;
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if (camera.position == AVCaptureDevicePositionFront) {
            frontCamera = camera;
        } else {
            backCamera = camera;
        }
    }
    
    if (!backCamera) {
        self.isCameraSupported = NO;
        return;
    } else {
        self.isCameraSupported = YES;
        
        if ([backCamera hasTorch]) {
            self.isTorchSupported = YES;
        } else {
            self.isTorchSupported = NO;
        }
    }
    
    if (!frontCamera) {
        self.isFrontCameraSupported = NO;
    } else {
        self.isFrontCameraSupported = YES;
    }
    
    
    [backCamera lockForConfiguration:nil];
    if ([backCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
        [backCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
    }
    
    [backCamera unlockForConfiguration];
    
    self.videoDeviceInput =  [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:nil];
	if(self.videoDeviceInput == nil)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你没有打开摄像头,请在设置中开启摄像头！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
		[alert show];
		return ;
	}
	
    AVCaptureDeviceInput *audioDeviceInput =[AVCaptureDeviceInput deviceInputWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio] error:nil];
	if(self.videoDeviceInput == nil)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你没有打开麦克风,请在设置中开启摄像头！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
		[alert show];
		return ;
	}
    [_captureSession addInput:_videoDeviceInput];
    [_captureSession addInput:audioDeviceInput];
    
    
    //output
    self.movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
	self.movieFileOutput.movieFragmentInterval = kCMTimeInvalid;
    [_captureSession addOutput:self.movieFileOutput];
    
    //preset
    _captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    
    //preview layer------------------
    self.preViewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    _preViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [_captureSession startRunning];
    
    
    
    self.preview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _preview.clipsToBounds = YES;
    [self.view addSubview:self.preview];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 320, SCREEN_WIDTH, 10)];
    self.progressView.progress=0;
    [self.preview addSubview:self.progressView];
    
    
    self.preViewLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320);
    [self.preview.layer addSublayer:self.preViewLayer];
    
	self.view.backgroundColor = [UIColor blackColor];
}



-(void)initRecordButton
{
    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    recordBtn.frame=CGRectMake(SCREEN_WIDTH/2-50, SCREEN_WIDTH+30, 100, 100);
	recordBtn.backgroundColor= COLORNOW(215, 0, 15);
	recordBtn.layer.cornerRadius = 50;
	recordBtn.clipsToBounds = YES;
    [recordBtn addTarget:self action:@selector(longTouch) forControlEvents:UIControlEventTouchDown];
    [recordBtn addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordBtn];
    

	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(recordBtn.frame.origin.x+recordBtn.frame.size.width+20, recordBtn.frame.origin.y+40, SCREEN_WIDTH-(recordBtn.frame.origin.x+recordBtn.frame.size.width+40), 20)];
	label.text = @"松手完成";
	label.font = FONTN(16.0f);
	label.textAlignment = NSTextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	[self.view addSubview:label];
	
	UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, recordBtn.frame.origin.y+40, recordBtn.frame.origin.x-40, 20)];
	label1.text = @"按住拍摄";
	label1.font = FONTN(16.0f);
	label1.textAlignment = NSTextAlignmentCenter;
	label1.textColor = [UIColor whiteColor];
	[self.view addSubview:label1];
	
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureBtn setTitle:@"松手完成" forState:UIControlStateNormal];
    sureBtn.frame=CGRectMake(recordBtn.frame.origin.x+recordBtn.frame.size.width+30, 360, 320, 40);
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
	
}
-(void)play
{
    DBPlayVideoVC *playVideoVC=[[DBPlayVideoVC alloc]init];
    playVideoVC.fileURL=_finashURL;
    [self.navigationController pushViewController:playVideoVC animated:YES];
    
    //    _player  = [[MPMoviePlayerController alloc] initWithContentURL:_finashURL];
    //
    //    _player.scalingMode = MPMovieScalingModeAspectFit;
    //
    //    [self.view addSubview:_player.view];
    //
    //    [_player setFullscreen:YES animated:YES];
    //    [_player prepareToPlay];
    //    
    //    [_player play];
    
    
    
}

#pragma mark - BtnClick

-(void)touchUp
{
	[_movieFileOutput stopRecording];
	[self stopCountDurTimer];
	[self sureBtnClick];
}

-(void)sureBtnClick
{
	double delayInSeconds = 0.5;
	dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
		if(flag == 0)
			[self mergeAndExportVideosAtFileURLs:self.files];
	});
}

-(void)longTouch
{
    
    NSURL *fileURL = [NSURL fileURLWithPath:[[self class] getVideoSaveFilePathString]];
    [self.files addObject:fileURL];
	
    [_movieFileOutput startRecordingToOutputFileURL:fileURL recordingDelegate:self];
}


#pragma mark - 获取视频大小及时长

//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat) getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init] ;
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path])
    {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }
    return filesize;
}
//此方法可以获取视频文件的时长
- (CGFloat) getVideoLength:(NSURL *)URL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    return second;
}

- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL
{
	
	AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
	
	AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
	
	gen.appliesPreferredTrackTransform = YES;
	
	CMTime time = CMTimeMakeWithSeconds(2.0, 600);
	
	NSError *error = nil;
	
	CMTime actualTime;
	
	CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
	
	UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
	
	return thumbImg;
	
}

#pragma mark - 创建视频目录及文件


+ (NSString *)getVideoSaveFilePathString
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  //  NSString *path = [paths objectAtIndex:0];
    
    NSString *path =[NSString stringWithFormat:@"%@/tmp/",NSHomeDirectory()];

    path = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyyMMddHHmmss";
    
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSString *fileName = [[path stringByAppendingPathComponent:nowTimeStr] stringByAppendingString:@".mp4"];
    
    return fileName;
    
}

+ (BOOL)createVideoFolderIfNotExist
{
   // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   NSString *path =[NSString stringWithFormat:@"%@/tmp/",NSHomeDirectory()];

    //[paths objectAtIndex:0];
    
    NSString *folderPath = [path stringByAppendingPathComponent:VIDEO_FOLDER];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建图片文件夹失败");
            return NO;
        }
        return YES;
    }
    return YES;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 合成文件
- (void)mergeAndExportVideosAtFileURLs:(NSArray *)fileURLArray
{
	flag = 1;
    NSError *error = nil;
    
    CGSize renderSize = CGSizeMake(0, 0);
    
    NSMutableArray *layerInstructionArray = [[NSMutableArray alloc] init];
    
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    CMTime totalDuration = kCMTimeZero;
    
    //先去assetTrack 也为了取renderSize
    NSMutableArray *assetTrackArray = [[NSMutableArray alloc] init];
    NSMutableArray *assetArray = [[NSMutableArray alloc] init];
    
    DLog(@"self.files====%lu",(unsigned long)[fileURLArray count]);
	
    for (NSURL *fileURL in fileURLArray)
    {
		
        AVAsset *asset = [AVAsset assetWithURL:fileURL];
		AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
		if([[asset tracksWithMediaType:@"vide"] count]==0)
		{
			[self.navigationController popViewControllerAnimated:YES];
			return;
		}
		[SVProgressHUD showWithStatus:@"请稍等..."];
        if (!asset) {
            continue;
        }
        NSLog(@"%@---%@----%@",asset.tracks,[asset tracksWithMediaType:@"vide"],[songAsset tracksWithMediaType:AVMediaTypeAudio]);
        
        [assetArray addObject:asset];
        
        
        AVAssetTrack *assetTrack = [[asset tracksWithMediaType:@"vide"] objectAtIndex:0];
        
        [assetTrackArray addObject:assetTrack];
        
        renderSize.width = MAX(renderSize.width, assetTrack.naturalSize.height);
        renderSize.height = MAX(renderSize.height, assetTrack.naturalSize.width);
    }
    
    
    CGFloat renderW = MIN(renderSize.width, renderSize.height);
    
    for (int i = 0; i < [assetArray count] && i < [assetTrackArray count]; i++) {
        
        AVAsset *asset = [assetArray objectAtIndex:i];
        AVAssetTrack *assetTrack = [assetTrackArray objectAtIndex:i];
		
		
        AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                            ofTrack:[[asset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                             atTime:totalDuration
                              error:nil];
        
        AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        
        [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                            ofTrack:assetTrack
                             atTime:totalDuration
                              error:&error];
        
        //fix orientationissue
        AVMutableVideoCompositionLayerInstruction *layerInstruciton = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
        
        totalDuration = CMTimeAdd(totalDuration, asset.duration);
        
        CGFloat rate;
        rate = renderW / MIN(assetTrack.naturalSize.width, assetTrack.naturalSize.height);
        
        CGAffineTransform layerTransform = CGAffineTransformMake(assetTrack.preferredTransform.a, assetTrack.preferredTransform.b, assetTrack.preferredTransform.c, assetTrack.preferredTransform.d, assetTrack.preferredTransform.tx * rate, assetTrack.preferredTransform.ty * rate);
        layerTransform = CGAffineTransformConcat(layerTransform, CGAffineTransformMake(1, 0, 0, 1, 0, -(assetTrack.naturalSize.width - assetTrack.naturalSize.height) / 2.0));//向上移动取中部影响
        layerTransform = CGAffineTransformScale(layerTransform, rate, rate);//放缩，解决前后摄像结果大小不对称
        
        [layerInstruciton setTransform:layerTransform atTime:kCMTimeZero];
        [layerInstruciton setOpacity:0.0 atTime:totalDuration];
        
        //data
        [layerInstructionArray addObject:layerInstruciton];
    }
    
    //get save path
    NSString *filePath = [[self class] getVideoMergeFilePathString];
    
    NSURL *mergeFileURL = [NSURL fileURLWithPath:filePath];
    
    //export
    AVMutableVideoCompositionInstruction *mainInstruciton = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruciton.timeRange = CMTimeRangeMake(kCMTimeZero, totalDuration);
    mainInstruciton.layerInstructions = layerInstructionArray;
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    mainCompositionInst.instructions = @[mainInstruciton];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    mainCompositionInst.renderSize = CGSizeMake(renderW, renderW);
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetMediumQuality];
    exporter.videoComposition = mainCompositionInst;
    exporter.outputURL = mergeFileURL;
    exporter.outputFileType = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _finashURL=mergeFileURL;
            [SVProgressHUD dismiss];
			
			NSFileManager *filemanger = [NSFileManager defaultManager];
			for (NSURL *fileURL in fileURLArray)
			{
				NSString *str=[fileURL absoluteString];
				DLog("fileURL====%@",str);
				
				[filemanger removeItemAtPath:str error:nil];
				
				
			}
			
			NSString *strmerge=[mergeFileURL absoluteString];
			[filemanger removeItemAtPath:strmerge error:nil];
			
			DLog("filePath====%@,%@",filePath,_finashURL);
			
		//	UIImage *thumbimage = [self thumbnailImageForVideo:_finashURL];
			
			if([delegate1 respondsToSelector:@selector(DGSetvideopath:Thumbimg:)])
			{
				[delegate1 DGSetvideopath:filePath Thumbimg:nil];
			}
			[AddInterface clearCache:Tmp_path];
            [self.navigationController popViewControllerAnimated:YES];
			
        });
    }];
}

+ (NSString *)getVideoMergeFilePathString
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //  NSLog(@"",);
    NSString *path =[NSString stringWithFormat:@"%@/",Cache_path];
    // [paths objectAtIndex:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSString *fileName = [[path stringByAppendingPathComponent:nowTimeStr] stringByAppendingString:@"merge.mp4"];
    
    return fileName;
}
#pragma mark - 计时器操作

- (void)startCountDurTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:COUNT_DUR_TIMER_INTERVAL target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

- (void)onTimer:(NSTimer *)timer
{
    _float_totalDur+=COUNT_DUR_TIMER_INTERVAL;
    
//    NSLog(@"%lf ----  %lf",_float_totalDur,self.progressView.progress);
    
    self.progressView.progress = _float_totalDur/33;
    
    if(self.progressView.progress>1)
    {
//        [self touchUp];
        [self performSelector:@selector(sureBtnClick) withObject:nil afterDelay:1];
        
    }
    
    
}
- (void)stopCountDurTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - AVCaptureFileOutputRecordignDelegate
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    [self startCountDurTimer];
    NSLog(@"didStartRecordingToOutputFileAtURL");

//    self.currentFileURL = fileURL;
//    
//    self.currentVideoDur = 0.0f;
//    [self startCountDurTimer];
//    
//    if ([_delegate respondsToSelector:@selector(videoRecorder:didStartRecordingToOutPutFileAtURL:)]) {
//        [_delegate videoRecorder:self didStartRecordingToOutPutFileAtURL:fileURL];
//    }
}
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {
    
    NSLog(@"%@",videoPath);
    
    NSLog(@"%@",error);
    
}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{

    NSLog(@"didFinishRecordingToOutputFileAtURL---%lf",_float_totalDur);
//    self.totalVideoDur += _currentVideoDur;
//    NSLog(@"本段视频长度: %f", _currentVideoDur);
//    NSLog(@"现在的视频总长度: %f", _totalVideoDur);
//    
//    if (!error) {
//        SBVideoData *data = [[SBVideoData alloc] init];
//        data.duration = _currentVideoDur;
//        data.fileURL = outputFileURL;
//        
//        [_videoFileDataArray addObject:data];
//    }
//    
//    if ([_delegate respondsToSelector:@selector(videoRecorder:didFinishRecordingToOutPutFileAtURL:duration:totalDur:error:)]) {
//        [_delegate videoRecorder:self didFinishRecordingToOutPutFileAtURL:outputFileURL duration:_currentVideoDur totalDur:_totalVideoDur error:error];
//    }
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
