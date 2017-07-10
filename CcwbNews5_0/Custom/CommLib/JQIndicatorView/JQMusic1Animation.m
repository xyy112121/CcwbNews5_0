//
//  JQMusic1Animation.m
//  JQMusic1AnimationDemo
//
//  Created by James on 15/7/18.
//  Copyright (c) 2015年 JQ. All rights reserved.
//

#import "JQMusic1Animation.h"

@interface JQMusic1Animation ()

@property CALayer *barLayer;

@end

@implementation JQMusic1Animation

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
    replicatorLayer.masksToBounds = YES;
}

#pragma mark - Music Indicator animation


- (void)addMusicBarAnimationLayerAtLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)color{
    CGFloat width = size.width/5;
    CGFloat height = size.height;
    self.barLayer = [CALayer layer];
    self.barLayer.bounds = CGRectMake(0, 0, width, height);
    self.barLayer.position = CGPointMake(size.width/2-width*3/2, size.height + 15);
    self.barLayer.cornerRadius = 2.0;
    self.barLayer.backgroundColor = color.CGColor;
    [layer addSublayer:self.barLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.toValue = @(self.barLayer.position.y - self.barLayer.bounds.size.height/2);
    animation.duration = 0.4;
    animation.autoreverses = YES;
    animation.repeatCount = CGFLOAT_MAX;
    
    [self.barLayer addAnimation:animation forKey:@"animation"];
}

- (void)removeAnimation{
    [self.barLayer removeAnimationForKey:@"animation"];
}

@end
