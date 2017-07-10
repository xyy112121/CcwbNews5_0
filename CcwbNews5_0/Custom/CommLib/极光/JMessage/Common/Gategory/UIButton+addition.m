//
//  UIButton+addition.m
//  JMessageDemo
//
//  Created by deng on 16/9/5.
//  Copyright © 2016年 HXHG. All rights reserved.
//

#import "UIButton+addition.h"

@implementation UIButton (addition)

/**
 *  每个NSObject的子类都会调用load这个方法 在这里将init方法进行替换
 */

+ (void)load{
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        //原始方法
        SEL originalSelector = @selector(init);
        SEL originalSelector2 = @selector(initWithFrame:);
        SEL originalSelector3 = @selector(awakeFromNib);
        
        //替换的方法
        SEL replaceSelector = @selector(ReplaceInit);
        SEL replaceSelector2 = @selector(ReplaceInitWithFrame:);
        SEL replaceSelector3 = @selector(ReplaceAwakeFromNib);
        
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method originalMethod2 = class_getInstanceMethod(class, originalSelector2);
        Method originalMethod3 = class_getInstanceMethod(class, originalSelector3);
        
        Method replaceMethod = class_getInstanceMethod(class, replaceSelector);
        Method replaceMethod2 = class_getInstanceMethod(class, replaceSelector2);
        Method replaceMethod3 = class_getInstanceMethod(class, replaceSelector3);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(replaceMethod),
                        method_getTypeEncoding(replaceMethod));
        BOOL didAddMethod2 =
        class_addMethod(class,
                        originalSelector2,
                        method_getImplementation(replaceMethod2),
                        method_getTypeEncoding(replaceMethod2));
        BOOL didAddMethod3 =
        class_addMethod(class,
                        originalSelector3,
                        method_getImplementation(replaceMethod3),
                        method_getTypeEncoding(replaceMethod3));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                replaceSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
            
        } else {
            method_exchangeImplementations(originalMethod, replaceMethod);
        }
        if (didAddMethod2) {
            class_replaceMethod(class,
                                replaceSelector2,
                                method_getImplementation(originalMethod2),
                                method_getTypeEncoding(originalMethod2));
        }else {
            method_exchangeImplementations(originalMethod2, replaceMethod2);
        }
        if (didAddMethod3) {
            class_replaceMethod(class,
                                replaceSelector3,
                                method_getImplementation(originalMethod3),
                                method_getTypeEncoding(originalMethod3));
        }else {
            method_exchangeImplementations(originalMethod3, replaceMethod3);
        }
    });
    
}
/**
 *  在这些方法中做需要统一处理的操作
 */
- (instancetype)ReplaceInit {
    if ([self ReplaceInit]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)ReplaceInitWithFrame:(CGRect)rect {
    if ([self ReplaceInitWithFrame:rect]) {
        [self commonInit];
    }
    return self;
}

- (void)ReplaceAwakeFromNib {
    [self ReplaceAwakeFromNib];
    if (self) {
        [self commonInit];
    }
}

- (void)commonInit {
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 0.2;
    [self.layer setMasksToBounds:YES];
    self.layer.cornerRadius = 2;
    self.titleLabel.font = JMSG_FONTSIZE(12);
}

@end
