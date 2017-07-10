//
//  PhotoGroupViewController.h
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoStore.h"
NS_ASSUME_NONNULL_BEGIN


NS_AVAILABLE_IOS(8_0) @interface PhotoGroupViewController : UIViewController

@property (nullable, nonatomic, copy) YPPhotoDidSelectedBlockAsset photosDidSelectBlock;

@end

NS_ASSUME_NONNULL_END
