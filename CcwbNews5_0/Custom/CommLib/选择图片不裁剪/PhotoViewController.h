//
//  PhotoViewController.h
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoStore.h"

NS_ASSUME_NONNULL_BEGIN

@class PhotoViewController;

@protocol PhotosControllerDelegate <NSObject>

@optional

/** 点击右侧取消执行的回调 */
- (void)photosControllerShouldBack:(PhotoViewController *)viewController;

/** 点击完成进行的回调 */
- (void)photosController:(PhotoViewController *)viewController photosSelected:(NSArray <PHAsset *> *)assets Status:(NSArray <NSNumber *> *)status;

@end

NS_AVAILABLE_IOS(8_0) @interface PhotoViewController : UIViewController

@property (nullable, nonatomic, weak)id <PhotosControllerDelegate> delegate;
@end


@interface PhotosTimeHandleObject : NSObject

/// @brief 将timeInterval转成字符串,格式为00:26
+ (NSString *)timeStringWithTimeDuration:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
