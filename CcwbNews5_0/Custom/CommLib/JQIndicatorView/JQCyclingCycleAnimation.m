//
//  JQCyclingCycleAnimation.m
//  JQIndicatorViewDemo
//
//  Created by James on 15/7/21.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import "JQCyclingCycleAnimation.h"

@interface JQCyclingCycleAnimation ()

@property CAShapeLayer *cycleLayer;

@end

@implementation JQCyclingCycleAnimation

- (void)configAnimationAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{
    self.cycleLayer = [CAShapeLayer layer];
    
    self.cycleLayer.frame = CGRectMake(0, 0, size.width, size.height);
    self.cycleLayer.position = CGPointMake(0, 0);
    self.cycleLayer.strokeColor = color.CGColor;
    self.cycleLayer.fillColor = [UIColor clearColor].CGColor;
    self.cycleLayer.lineWidth = 2.f;
    
    CGFloat radius = MIN(size.width/2, size.height/2);
    CGPoint center = CGPointMake(radius, radius);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-(M_PI_2)
                                                      endAngle:(5*M_PI_4)
                                                     clockwise:YES];
    self.cycleLayer.path = path.CGPath;
    
    [layer addSublayer:self.cycleLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 1.f;
    animation.repeatCount = CGFLOAT_MAX;
    animation.fromValue = @0;
    animation.toValue = @(2*M_PI);
    [self.cycleLayer addAnimation:animation forKey:@"animation"];
}

- (void)removeAnimation{
    [self.cycleLayer removeAnimationForKey:@"animation"];
}

@end
