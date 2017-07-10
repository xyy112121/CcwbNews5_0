//
//  PhotoStoreConfiguraion.h
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// @brief 相机胶卷
extern NSString * const ConfigurationCameraRoll;

// @brief 隐藏
extern NSString * const ConfigurationHidden;
/// @brief 慢动作
extern NSString * const ConfigurationSlo_mo;
/// @brief 屏幕快照
extern NSString * const ConfigurationScreenshots;
/// @brief 视频
extern NSString * const ConfigurationVideos;
/// @brief 全景照片
extern NSString * const ConfigurationPanoramas;
/// @brief 定时拍照
extern NSString * const ConfigurationTime_lapse;
/// @brief 最近添加
extern NSString * const ConfigurationRecentlyAdded;
/// @brief 最近删除
extern NSString * const ConfigurationRecentlyDeleted;
/// @brief 快拍连照
extern NSString * const ConfigurationBursts;
/// @brief 喜欢
extern NSString * const ConfigurationFavorite;
/// @brief 自拍
extern NSString * const ConfigurationSelfies;


@interface PhotoStoreConfiguraion : NSObject
@property (nonatomic, strong, readonly)NSArray * groupNamesConfig;


//初始化方法
- (instancetype)initWithGroupNames:(NSArray <NSString *> *) groupNames;
+ (instancetype)storeConfigWithGroupNames:(NSArray <NSString *> *)groupNames;


/** 设置获取的相册名 */
- (void)setGroupNames:(NSArray <NSString *> *)newGroupNames;

@end

NS_ASSUME_NONNULL_END
