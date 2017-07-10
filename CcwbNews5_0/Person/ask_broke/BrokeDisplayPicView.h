//
//  BrokeDisplayPicView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/4/19.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrokeDisplayPicView : UIView
{
	AppDelegate *app;
	// 下载句柄
	NSURLSessionDownloadTask *_downloadTask;
	UIScrollView *scrollview;
}
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UIProgressView *progressView;
-(id)initWithFrame:(CGRect)frame PicPath:(NSString *)picpath  FromImage:(UIImage *)fromimage;
@end
