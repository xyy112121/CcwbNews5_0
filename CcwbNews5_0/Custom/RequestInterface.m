//
//  RequestInterface.m
//  CcwbNews
//
//  Created by xyy520 on 16/5/19.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import "RequestInterface.h"
#import "Jwt.h"
@implementation RequestInterface

//获取普通管理器
+(AFHTTPSessionManager *)getHTTPManager{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.requestSerializer.timeoutInterval = 10.0f;
//	AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
//	response.removesKeysWithNullValues = YES;
//	manager.responseSerializer = response;
//	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
	manager.responseSerializer = [AFHTTPResponseSerializer serializer];

	return manager;
}

+(AppDelegate *)getAppdelegate
{
	AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	return app;
}

//普通 接口没有请求动画效果的
+(void)doGetJsonWithParametersNoAn:(NSDictionary * )parameters App:(AppDelegate *)app ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",app.cwtoken] forHTTPHeaderField:@"authorization"];
	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
	params[@"cw_version"] = CwVersion;
	params[@"cw_device"] = CwDevice;
	params[@"cw_machine_id"]= app.Gmachid;
	params[@"cw_user_id"] = [app.userinfo.userid length]==0?@"":app.userinfo.userid;
    params[@"cw_city"] = app.diliweizhi.dilicity;
	
//	NSDictionary * payload = @{
//							   @"devKey": @"nducrey",
//							   @"appKey": @"myApp",
//							   @"exp": @1425391188545,
//							   @"socketId": @"socketId"
//							   };
	
	
	NSError *error;
	NSString *token = [Jwt encodeWithPayload:params andKey:TYJWTKey andAlgorithm:HS256 andError:&error];
	NSDictionary *decoded = [Jwt decodeWithToken:token andKey:TYJWTKey andVerify:true andError:&error];
	DLog(@"token===%@,%@",token,decoded);
	
    NSString *urlstr;
    urlstr = URLHeader;
	[manager POST:[urlstr stringByAppendingString:requrl] parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
	 {
		 
	 }
	 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	 {
		 if(always){
			 always();
		 }
		 NSString *str = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
//		 DLog(@"str====%@",str);
		 
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 success(jsonvalue);

	 }
	 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
	 {
		 failure(@"请求失败,请检查网络");
	 }];
}

//普通 接口没有请求动画效果的  //用户接口
+(void)doGetJsonWithParametersForUser:(NSDictionary * )parameters App:(AppDelegate *)app ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure
{
    AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",app.cwtoken] forHTTPHeaderField:@"authorization"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    params[@"cw_version"] = CwVersion;
    params[@"cw_device"] = CwDevice;
    params[@"cw_machine_id"]= app.Gmachid;
    params[@"cw_user_id"] = app.userinfo.userid;
    params[@"cw_city"] = app.diliweizhi.dilicity;
    
    //	NSDictionary * payload = @{
    //							   @"devKey": @"nducrey",
    //							   @"appKey": @"myApp",
    //							   @"exp": @1425391188545,
    //							   @"socketId": @"socketId"
    //							   };
    
    
    NSError *error;
    NSString *token = [Jwt encodeWithPayload:params andKey:TYJWTKey andAlgorithm:HS256 andError:&error];
    NSDictionary *decoded = [Jwt decodeWithToken:token andKey:TYJWTKey andVerify:true andError:&error];
    DLog(@"token===%@,%@",token,decoded);
    
    NSString *urlstr;
    urlstr = URLInterFaceHeader;
    [manager POST:[urlstr stringByAppendingString:requrl] parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if(always){
             always();
         }
         NSString *str = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
         //	 DLog(@"str====%@",str);
         
         NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         success(jsonvalue);
         
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         failure(@"请求失败,请检查网络");
     }];
}

//普通 接口没有请求动画效果的  //商城接口
+(void)doGetJsonWithParametersForStore:(NSDictionary * )parameters App:(AppDelegate *)app ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure
{
    AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",app.cwtoken] forHTTPHeaderField:@"authorization"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
    params[@"cw_version"] = CwVersion;
    params[@"cw_device"] = CwDevice;
    params[@"cw_machine_id"]= app.Gmachid;
    params[@"cw_user_id"] = app.userinfo.userid;
    params[@"cw_city"] = app.diliweizhi.dilicity;
    
    //	NSDictionary * payload = @{
    //							   @"devKey": @"nducrey",
    //							   @"appKey": @"myApp",
    //							   @"exp": @1425391188545,
    //							   @"socketId": @"socketId"
    //							   };
    
    
    NSError *error;
    NSString *token = [Jwt encodeWithPayload:params andKey:TYJWTKey andAlgorithm:HS256 andError:&error];
    NSDictionary *decoded = [Jwt decodeWithToken:token andKey:TYJWTKey andVerify:true andError:&error];
    DLog(@"token===%@,%@",token,decoded);
    
    NSString *urlstr;
    urlstr = URLShopHeader;
    [manager POST:[urlstr stringByAppendingString:requrl] parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if(always){
             always();
         }
         NSString *str = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
         //	 DLog(@"str====%@",str);
         
         NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         success(jsonvalue);
         
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         failure(@"请求失败,请检查网络");
     }];
}

//普通接口请求 完整url
+(void)doGetJsonWithParameterscompleteurl:(NSDictionary * )parameters App:(AppDelegate *)app ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
	params[@"cw_version"] = CwVersion;
	params[@"cw_device"] = CwDevice;
	params[@"cw_machine_id"]= app.Gmachid;
	params[@"cw_user_id"] = [app.userinfo.userid length]==0?app.Gmachid:app.userinfo.userid;
	
	
	[manager POST:requrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
	{
	 
	}
	success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	{
		 if(always){
			 always();
		 }
		 
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 success(jsonvalue);
	}
	failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
	{
	 
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
	}];
}

//上传图片接口
+(void)doGetJsonWithArraypic:(NSArray * )arrayimage Parameter:(NSDictionary * )parameters App:(AppDelegate *)app ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
	params[@"cw_version"] = CwVersion;
	params[@"cw_device"] = CwDevice;
	params[@"cw_machine_id"]= app.Gmachid;
	params[@"cw_user_id"] = app.userinfo.userid;
	
	[manager POST:[URLResouceUpLoadHeader stringByAppendingString:requrl] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
		
		for (int i=0;i<[arrayimage count];i++)
		{
			NSString *fileName = [NSString stringWithFormat:@"%d.jpg",i];
			NSData *imageData;
			UIImage *image = [arrayimage objectAtIndex:i];//LOADIMAGE(@"testpic", @"jpg");
			imageData = UIImageJPEGRepresentation(image, 0.5f);

			[formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
		}
	} progress:^(NSProgress * _Nonnull uploadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		success(jsonvalue);
		NSLog(@"responseObject = %@, task = %@",responseObject,task);
		
		
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		[MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
	}];
}




//上传视频接口
+(void)doGetJsonWithvideo:(NSString * )videopath Parameter:(NSDictionary * )parameters App:(AppDelegate *)app ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
	params[@"cw_version"] = CwVersion;
	params[@"cw_device"] = CwDevice;
	params[@"cw_machine_id"]= app.Gmachid;
	params[@"cw_user_id"] = app.userinfo.userid;

//	AppDelegate *app =  [RequestInterface getAppdelegate];
//	JQIndicatorView *indicator = [[JQIndicatorView alloc] initWithType:JQIndicatorTypeBounceSpot1 tintColor:COLORNOW(200, 200, 200)];
//	indicator.center = app.window.center;
//	indicator.tag = 30070;
//	[app.window addSubview:indicator];
//	[indicator startAnimating];
	
	[manager POST:[URLResouceUpLoadHeader stringByAppendingString:requrl] parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
		//对于图片进行压缩
		NSURL *url = [NSURL fileURLWithPath:videopath];
		NSData *videoData = [NSData dataWithContentsOfURL:url];
		[formData appendPartWithFileData:videoData name:@"file" fileName:@"video1.mp4" mimeType:@"video/quicktime"];
	}
		 progress:^(NSProgress * _Nonnull uploadProgress)
	 {
		 if(always)
		 {
			 always();
		 }
		 
	 }
		  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	 {
		 if(always){
			 always();
		 }
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 success(jsonvalue);
		 NSLog(@"responseObject = %@, task = %@",responseObject,task);
		 
//		 [indicator stopAnimating];
		 
	 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		 if(always)
		 {
			 always();
		 }
		 NSLog(@"error = %@",error);
//		 [indicator stopAnimating];
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
	 }];
	
	
}

//上传音频接口
+(void)doGetJsonWithAudio:(NSString * )audiopath Parameter:(NSDictionary * )parameters App:(AppDelegate *)app ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure
{
	AFHTTPSessionManager *manager = [RequestInterface getHTTPManager];
	NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:parameters];
	params[@"cw_version"] = CwVersion;
	params[@"cw_device"] = CwDevice;
	params[@"cw_machine_id"]= app.Gmachid;
	params[@"cw_user_id"] = app.userinfo.userid;

	[manager POST:[URLResouceHeader stringByAppendingString:requrl] parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
		NSURL *url = [NSURL fileURLWithPath:audiopath];
		NSData *videoData = [NSData dataWithContentsOfURL:url];
		[formData appendPartWithFileData:videoData name:@"file" fileName:@"audio.mp3" mimeType:@"video/quicktime"];
	}
		 progress:^(NSProgress * _Nonnull uploadProgress)
	 {
		 if(always)
		 {
			 always();
		 }
		 
	 }
		  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
	 {
		 if(always){
			 always();
		 }
		 NSDictionary *jsonvalue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		 success(jsonvalue);
		 NSLog(@"responseObject = %@, task = %@",responseObject,task);
		 
//		 [indicator stopAnimating];
		 
	 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		 if(always)
		 {
			 always();
		 }
		 NSLog(@"error = %@",error);
//		 [indicator stopAnimating];
		 [MBProgressHUD showError:@"请求失败,请检查网络" toView:showview];
	 }];
	
	
}


@end
