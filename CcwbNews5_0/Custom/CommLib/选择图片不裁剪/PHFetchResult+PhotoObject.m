//
//  PHFetchResult+PhotoObject.m
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import "PHFetchResult+PhotoObject.h"
#import <objc/runtime.h>
#import "PhotoDefine.h"

NS_ASSUME_NONNULL_BEGIN

static const NSString *represetationImage;


@implementation PHAssetCollection (Representation)


- (UIImage *)representationImage
{
    return objc_getAssociatedObject(self, &represetationImage);
}


- (void)setRepresentationImage:(UIImage *)image
{
    objc_setAssociatedObject(self, &represetationImage, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)representationImageWithSize:(CGSize)size complete:(nonnull void (^)(NSString * _Nonnull, NSUInteger, UIImage * _Nullable))completeBlock
{
    __weak __typeof(self)weakSelf = self;
    //获取照片资源
    PHFetchResult * assetResult = [PHAsset fetchAssetsInAssetCollection:self options:nil];
    NSUInteger count = assetResult.count;
    if (assetResult.count == 0)
    {
        completeBlock(weakSelf.localizedTitle,0,[UIImage new]);return;
    }
    if (weakSelf.representationImage != nil)
    {
        completeBlock(weakSelf.localizedTitle,count,weakSelf.representationImage);return;
    }
    //获取屏幕的点
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize newSize = CGSizeMake(size.width * scale, size.height * scale);
    //开始截取照片
    [[PHCachingImageManager defaultManager] requestImageForAsset:assetResult.lastObject targetSize:newSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakSelf.representationImage = result;
        //block to trans image
        completeBlock(weakSelf.localizedTitle,count,weakSelf.representationImage);
    }];
}

-(void)dealloc
{
    objc_setAssociatedObject(self, &represetationImage, nil, OBJC_ASSOCIATION_ASSIGN);
    objc_removeAssociatedObjects(self);
}

@end


static NSString * catcheArray;
static NSString * highQualityArray;
static NSString * hignSizeArray;
@implementation PHAsset (Representation)



- (NSMutableArray *)catcheArray
{
    return objc_getAssociatedObject(self, &catcheArray);
}

- (void)setCatcheArray:(NSMutableArray *)newArray
{
    objc_setAssociatedObject(self, &catcheArray, newArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)highQualityArray
{
    return objc_getAssociatedObject(self, &highQualityArray);
}

- (void)setHighQualityArray:(NSMutableArray *)newArray
{
    objc_setAssociatedObject(self, &highQualityArray, newArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)hignSizeArray
{
    return objc_getAssociatedObject(self, &hignSizeArray);
}

- (void)setHignSizeArray:(NSMutableArray *)newArray
{
    objc_setAssociatedObject(self, &hignSizeArray, newArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)representationImageWithSize:(CGSize)size complete:(nonnull void (^)(UIImage * _Nullable, PHAsset * _Nonnull))completeBlock
{
    __weak typeof(self)copy_self = self;
    if (copy_self.catcheArray == nil)
    {
        copy_self.catcheArray = [NSMutableArray arrayWithCapacity:0];
    }
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize newSize = CGSizeMake(size.width * scale, size.height * scale);
    [[PHCachingImageManager defaultManager]requestImageForAsset:copy_self targetSize:newSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        completeBlock(result,copy_self);
    }];
    if (![copy_self.catcheArray containsObject:[NSValue valueWithCGSize:size]])
    {
        //start catch
        [((PHCachingImageManager *)[PHCachingImageManager defaultManager])startCachingImagesForAssets:@[copy_self] targetSize:newSize contentMode:PHImageContentModeAspectFill options:nil];
        [copy_self.catcheArray addObject:[NSValue valueWithCGSize:newSize]];
    }
}

-(void)sizeOfHignQualityWithSize:(CGSize)size complete:(void (^)(NSString * _Nonnull))completeBlock
{
    CGSize newSize = size;
    if (!self.highQualityArray)
    {
        self.highQualityArray = [NSMutableArray arrayWithCapacity:0];
        self.hignSizeArray = [NSMutableArray arrayWithCapacity:0];
    }
    if ([self.highQualityArray containsObject:[NSValue valueWithCGSize:newSize]])
    {
        //获得当前的index
        NSUInteger index = [self.highQualityArray indexOfObject:[NSValue valueWithCGSize:newSize]];
        //直接返回大小
        NSString * sizeRerturn = self.hignSizeArray[index];
        completeBlock(sizeRerturn);return;
    }
    __weak typeof(self) weakSelf = self;
    //初始化option选项
    PHImageRequestOptions * option = [PHImageRequestOptions imageRequestOptionsWithDeliveryMode:PHImageRequestOptionsDeliveryModeHighQualityFormat];
    [[PHCachingImageManager defaultManager]requestImageDataForAsset:self options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        NSString * imageSize = sizeWithLength(imageData.length);
        //数组进行缓存
        [weakSelf.hignSizeArray addObject:imageSize];
        //将大小传出，默认为btye
        completeBlock(imageSize);
    }];
    
    if (![self.highQualityArray containsObject:[NSValue valueWithCGSize:newSize]])
    {
        //进行大小缓存
        [weakSelf.highQualityArray addObject:[NSValue valueWithCGSize:newSize]];
    }
}



-(void)dealloc
{
    for (NSValue * value in self.catcheArray)
    {
        //cancle the caching
        [((PHCachingImageManager *)[PHCachingImageManager defaultManager])stopCachingImagesForAssets:@[self] targetSize:value.CGSizeValue contentMode:PHImageContentModeAspectFill options:nil];
    }
    objc_setAssociatedObject(self, &hignSizeArray, nil, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &highQualityArray, nil, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &catcheArray, nil, OBJC_ASSOCIATION_ASSIGN);
    objc_removeAssociatedObjects(self);
}

@end


@implementation PHFetchResult (PhotoObject)

-(void)preparationWithType:(PHAssetMediaType)mediaType Complete:(void (^)(NSArray<PHAsset *> * _Nonnull))completeBlock
{
    __weak typeof(self) weakSelf = self;
    
    __block NSMutableArray <__kindof PHAsset *> * assets = [NSMutableArray arrayWithCapacity:0];
    
    if (weakSelf.count == 0) {
        
        completeBlock([NSArray arrayWithArray:assets]);assets = nil;return;
    }
    
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (((PHAsset *)obj).mediaType == mediaType)
        {
            [assets addObject:obj];
        }
        
        if (idx == weakSelf.count - 1)
        {
            completeBlock([NSArray arrayWithArray:assets]);
            assets = nil;
        }
    }];
}

@end


@implementation PHFetchResult (NSArray)

-(void)transToArrayComplete:(void (^)(NSArray<PHAssetCollection *> * _Nonnull, PHFetchResult * _Nonnull))arrayObject
{
    __weak typeof(self) weakSelf = self;
    NSMutableArray *  array = [NSMutableArray arrayWithCapacity:0];
    if (self.count == 0)
    {
        arrayObject([array mutableCopy],weakSelf);
        return;
    }
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:obj];
        if (idx == self.count - 1)
        {
            arrayObject([array mutableCopy],weakSelf);
        }
    }];
}

@end


@implementation PHImageRequestOptions (Convience)

+ (instancetype)imageRequestOptionsWithDeliveryMode:(PHImageRequestOptionsDeliveryMode)deliverMode
{
    PHImageRequestOptions * option = [[self alloc] init];
    option.deliveryMode = deliverMode;
    return option;
}

@end

NS_ASSUME_NONNULL_END
