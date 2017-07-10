//
//  PhotoFooter.h
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhotoFooter : UICollectionReusableView

/// @brief simple method to set the number of asset in the assCountlabel
@property (nonatomic, assign)NSUInteger numberOfAsset;

/// @brief the custom title in the assetCountLabel
@property (nullable ,nonatomic, copy)NSString * customText;

/// @brief show the title with the number if asset,default text is 共有375张照片
@property (weak, nonatomic) UILabel * assetCountLabel;

@end

NS_ASSUME_NONNULL_END
