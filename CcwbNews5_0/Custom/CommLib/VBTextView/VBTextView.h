//
//  VBTextView.h
//  loadingView
//
//  Created by XiaoYun on 16/3/9.
//  Copyright © 2016年 XiaoYun. All rights reserved.
//可视化的带有placeholder的textview

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface VBTextView : UITextView
/**
 *  placeholder
 */
@property(nonatomic,copy)IBInspectable NSString *placeHolder;
/**
 *  placeholder color 默认graycolor
 */
@property(nonatomic,copy)IBInspectable UIColor *placeColor;
/**
 *  文字颜色 默认黑色
 
 */
@property(nonatomic,copy)IBInspectable UIColor *infoColor;
/**
 *  边框颜色 默认无
 */
@property(nonatomic,copy)IBInspectable   UIColor *borderColor;
/**
 *  边框大小 默认0
 */
@property(nonatomic,assign)IBInspectable  CGFloat borderWitdh;
/**
 *  圆角 默认无
 */
@property(nonatomic,assign)IBInspectable  CGFloat cornerRadius;
/**
 *  初始化
 *
 *  @param frame       <#frame description#>
 *  @param placeHolder <#placeHolder description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString*)placeHolder;

@end
