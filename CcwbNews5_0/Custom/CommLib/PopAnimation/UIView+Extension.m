//  UIView+Extension.m
//  LHRAlerView
//
//  Created by 李海瑞 on 15/10/23.
//  Copyright © 2015年 李海瑞. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)reboundEffectAnimationDuration:(CGFloat)duration Dele:(id)delegate1 Flag:(int)flag
{   //缩放的动画 效果
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration=duration;
    animation.values = [NSArray arrayWithObjects:
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.60, 0.60, 1.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)],
                    nil];//x y z 放大缩小的倍数
	animation.delegate = delegate1;
    [self.layer addAnimation:animation forKey:nil];

}

- (void)setX:(CGFloat)x
{
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)x
{
	return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)y
{
	return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
	CGPoint center = self.center;
	center.x = centerX;
	self.center = center;
}

- (CGFloat)centerX
{
	return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
	CGPoint center = self.center;
	center.y = centerY;
	self.center = center;
}

- (CGFloat)centerY
{
	return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}

- (CGFloat)width
{
	return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}

- (CGFloat)height
{
	return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (CGSize)size
{
	return self.frame.size;
}


@end
