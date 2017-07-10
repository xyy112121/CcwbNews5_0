//
//  JQMusic2Animation.m
//  JQIndicatorViewDemo
//
//  Created by James on 15/7/22.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import "JQMusic2Animation.h"

@interface JQMusic2Animation ()

@property CALayer *barLayer;

@end

@implementation JQMusic2Animation

- (void)configAnimationAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, size.width, size.height);
    replicatorLayer.position = CGPointMake(0, 0);
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    [layer addSublayer:replicatorLayer];
    
    [self addMusicBarAnimationLayerAtLayer:replicatorLayer withSize:size tintColor:color];
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceDelay = 0.2;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(size.width*3/10, 0.f, 0.f);
    replicatorLayer.masksToBounds = NO;
}

#pragma mark - Music Indicator animation


- (void)addMusicBarAnimationLayerAtLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)color{
    CGFloat width = size.width/5;
    CGFloat height = size.height - 20;
    self.barLayer = [CALayer layer];
    self.barLayer.bounds = CGRectMake(0, 0, width, height);
    self.barLayer.position = CGPointMake(size.width/2-width*3/2, size.height/2);
    self.barLayer.cornerRadius = 2.0;
    self.barLayer.backgroundColor = color.CGColor;
    [layer addSublayer:self.barLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    animation.fromValue = @1;
    animation.toValue = @0.3;
    animation.duration = 0.4;
    animation.autoreverses = YES;
    animation.repeatCount = CGFLOAT_MAX;
    
    [self.barLayer addAnimation:animation forKey:@"animation"];
}

- (void)removeAnimation{
    [self.barLayer removeAnimationForKey:@"animation"];
}


@end
