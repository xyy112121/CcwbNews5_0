//
//  UIView+Extension.h
//  LHRAlerView
//
//  Created by 李海瑞 on 15/10/23.
//  Copyright © 2015年 李海瑞. All rights reserved.
//
// 颜色
#define MTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define MTScreenW [UIScreen mainScreen].bounds.size.width

#define MTScreenH [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
- (void)reboundEffectAnimationDuration:(CGFloat)duration Dele:(id)delegate1 Flag:(int)flag;
@end
