//
//  PHFetchResult+PhotoObject.h
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN


@interface PHAssetCollection (Representation)

/** 获取组的标题、照片资源的预估个数以及封面照片,默认为最新的一张 */
- (void)representationImageWithSize:(CGSize)size complete:(void (^)(NSString *,NSUInteger,UIImage * __nullable)) completeBlock;

@end

@interface PHAsset (Representation)

/** 获取PHAsset的照片资源 */
- (void)representationImageWithSize:(CGSize)size complete:(void (^)(UIImage * __nullable,PHAsset *))completeBlock;

/** 获取PHAsset的照片资源高清图的大小 */
- (void)sizeOfHignQualityWithSize:(CGSize)size complete:(void(^)(NSString * imageSize))completeBlock;

@end


@interface PHFetchResult (PhotoObject)

/** 获取PHFetchResult中符合媒体类型的PHAsset对象 */
- (void)preparationWithType:(PHAssetMediaType)mediaType Complete:(void(^)(NSArray <PHAsset *> * __nullable))completeBlock;

@end


@interface PHFetchResult (NSArray)

/** 将PHFetchResult对象转成NSArray对象 */
- (void)transToArrayComplete:(void(^)(NSArray <PHAssetCollection *> *, PHFetchResult *)) arrayObject;

@end

@interface PHImageRequestOptions (Convience)

/** PHImageRequestOptions 便利构造器 */
+ (instancetype)imageRequestOptionsWithDeliveryMode:(PHImageRequestOptionsDeliveryMode)deliverMode;

@end

NS_ASSUME_NONNULL_END
