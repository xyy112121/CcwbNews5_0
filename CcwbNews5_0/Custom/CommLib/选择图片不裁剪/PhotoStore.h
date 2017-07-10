//
//  PhotoStore.h
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "PhotoStoreConfiguraion.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^YPPhotoDidSelectedBlock)(NSArray <UIImage *> *);
typedef void(^YPPhotoDidSelectedBlockAsset)(NSArray <PHAsset *> *,NSArray <NSNumber *> *);

NS_AVAILABLE_IOS(8_0) @interface PhotoStore : NSObject<PHPhotoLibraryChangeObserver>

/// @brief 配置类，用来设置相册的类
@property (nonatomic, strong, readonly)PhotoStoreConfiguraion * config;

//构造方法
- (instancetype)initWithConfiguration:(PhotoStoreConfiguraion *)configuration;
+ (instancetype)storeWithConfiguration:(PhotoStoreConfiguraion *)configuration;


#pragma mark - 相册组

/** 获取photos提供的所有的智能分类相册组，与config属性无关 */
- (void)fetchPhotosGroup:(void(^)(NSArray <PHAssetCollection *> *)) groups;


/**
 *  根据photos提供的智能分类相册组
 *  根据config中的groupNamesConfig属性进行筛别
 */
- (void)fetchDefaultPhotosGroup:(void(^)(NSArray <PHAssetCollection *> *)) groups;


/**
 *  根据photos提供的智能分类相册组
 *  根据config中的groupNamesConfig属性进行筛别 并添加上其他在手机中创建的相册
 */
- (void)fetchDefaultAllPhotosGroup:(void(^)(NSArray <PHAssetCollection *> * , PHFetchResult *)) groups;


#pragma mark - 处理相册的方法

/** 获取某个相册的所有照片的简便方法 */
- (PHFetchResult *)fetchPhotos:(PHAssetCollection *)group;

@property (nullable, nonatomic, copy)void(^photoStoreHasChanged)(PHChange * changeInstance);
@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface PhotoStoreHandleClass : NSObject

/// 根据size以及图片状态获取资源转化后的图片对象数组
+ (void)imagesWithAssets:(NSArray <PHAsset *> *)assets status:(NSArray <NSNumber *> *)status Size:(CGSize)size complete:(void (^)(NSArray <UIImage *> *))imagesBlock;


/// 根据资源以及状态获取资源转化后的data
+ (void)dataWithAssets:(NSArray <PHAsset *> *)assets status:(NSArray <NSNumber *> *)status complete:(void (^)(NSArray <NSData *> *))dataBlock;

@end


@interface PhotoStore (Group)

/// 新增一个title的相册
- (void)addCustomGroupWithTitle:(NSString *)title completionHandler:(void(^)(void)) successBlock failture:(void(^)(NSString * error)) failtureBlock;


/// 新增一个title的相册，并添加资源对象
- (void)addCustomGroupWithTitle:(NSString *)title assets:(NSArray <PHAsset *> *)assets completionHandler:(void (^)(void))successBlock failture:(void (^)(NSString *))failtureBlock;


/// 检测是否存在同名相册,如果存在返回第一个同名相册
- (void)checkGroupExist:(NSString *)title result:(void(^)(BOOL isExist,PHAssetCollection * __nullable)) resultBlock;

@end

@interface PhotoStore (Asset)

/// 将图片对象写入对应相册
- (void)addCustomAsset:(UIImage *)image collection:(PHAssetCollection *)collection completionHandler:(void(^)(void)) successBlock failture:(void(^)(NSString * error)) failtureBlock;


/// 将图片路径写入对应相册
- (void)addCustomAssetPath:(NSString *)imagePath collection:(PHAssetCollection *)collection completionHandler:(void(^)(void)) successBlock failture:(void(^)(NSString * error)) failtureBlock;

@end

NS_ASSUME_NONNULL_END
