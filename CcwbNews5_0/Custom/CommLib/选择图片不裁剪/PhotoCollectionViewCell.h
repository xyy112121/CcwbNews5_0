//
//  PhotoCollectionViewCell.h
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDefine.h"
@class PhotoCollectionViewCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^PhotosCellOperationBlock)(PhotoCollectionViewCell * __nullable cell);

@interface PhotoCollectionViewCell : UICollectionViewCell

/// display backgroundImage
@property (strong, nonatomic)  UIImageView *imageView;

/// default hidden is true
@property (strong, nonatomic)  UIView *messageView;

/// imageView in messageView to show the kind of asset
@property (strong, nonatomic)  UIImageView *messageImageView;

/// label in messageVie to show the information
@property (strong, nonatomic)  UILabel *messageLabel;

/// button in order to display the selected image
@property (strong, nonatomic)  UIButton *chooseImageViewBtn __deprecated_msg("Use chooseImageView");

/// 负责显示选中的按钮
@property (strong, nonatomic) UIImageView * chooseImageView;

/// 负责响应点击事件的Control对象
@property (strong, nonatomic) UIControl * chooseControl;

//evoked when the chooseImageView clicked
@property (nullable, copy, nonatomic)PhotosCellOperationBlock imageSelectedBlock;
@property (nullable, copy, nonatomic)PhotosCellOperationBlock imageDeselectedBlock;


- (void) cellDidSelect;
- (void) cellDidDeselect;


@end


NS_ASSUME_NONNULL_END
