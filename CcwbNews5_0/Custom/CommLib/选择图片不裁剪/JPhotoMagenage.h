//
//  JPhotoMagenage.h
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/23.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JPhotoMagenage : NSObject

@property (nonatomic ,assign) NSInteger maxImageNumber;

+ (JPhotoMagenage *)shareInstance;

//相册(多张)
+ (void)JphotoGetFromLibrayInController:(UIViewController *)viewController
                                finish:(void(^)(NSArray <UIImage *> * images))finish
                                cancel:(void(^)())cancel;

//相册（单张）
+ (void)JphotoGetFromSystemInController:(UIViewController *)viewController
                                 finish:(void(^)(UIImage *image))finish
                                 cancel:(void(^)())cancel;

//拍照
+ (void)JphotoTakePhotoInController:(UIViewController *)viewController
                             finish:(void(^)(UIImage *image))finish
                             cancel:(void(^)())cancel;

// 拍照、相册（多张）
+ (void)getImageInController:(UIViewController *)viewController
                      finish:(void(^)(NSArray <UIImage *> * images))finish
                      cancel:(void(^)())cancel;

//拍照单张
+ (void)getOneImageInController:(UIViewController *)viewController
                      finish:(void(^)( UIImage *images))finish
                      cancel:(void(^)())cancel;
@end
