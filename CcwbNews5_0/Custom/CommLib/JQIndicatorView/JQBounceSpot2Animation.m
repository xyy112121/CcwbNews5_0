//
//  JQBounceSpot2Animation.m
//  JQIndicatorViewDemo
//
//  Created by 家琪 on 15/7/27.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import "JQBounceSpot2Animation.h"

#define kJQBounceSpot2AnimationDuration 0.8

@interface JQBounceSpot2Animation ()

@property CALayer *spotLayer;

@end

@implementation JQBounceSpot2Animation

- (void)configAnimationAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, size.width, size.height);
    replicatorLayer.position = CGPointMake(0,0);
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    [layer addSublayer:replicatorLayer];
    [self addCyclingSpotAnimationLayerAtLayer:replicatorLayer withTintColor:color size:size];
    
    NSInteger numOfDot = 4;
    replicatorLayer.instanceCount = numOfDot;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(size.width/5, 0, 0);
    replicatorLayer.instanceDelay = kJQBounceSpot2AnimationDuration/numOfDot;
}

- (void)addCyclingSpotAnimationLayerAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{
    CGFloat radius = size.width/5;
    self.spotLayer = [CALayer layer];
    self.spotLayer.bounds = CGRectMake(0, 0, radius, radius);
    self.spotLayer.position = CGPointMake(radius/2, size.height/2);
    self.spotLayer.cornerRadius = radius/2;
    self.spotLayer.backgroundColor = color.CGColor;
    self.spotLayer.transform = CATransform3DMakeScale(0.2, 0.2, 0.2);
    
    [layer addSublayer:self.spotLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @0.2;
    animation.toValue = @1;
    animation.duration = kJQBounceSpot2AnimationDuration;
    animation.autoreverses = YES;
    animation.repeatCount = CGFLOAT_MAX;
    
    [self.spotLayer addAnimation:animation forKey:@"animation"];
}

- (void)removeAnimation{
    [self.spotLayer removeAnimationForKey:@"animation"];
}

@end
