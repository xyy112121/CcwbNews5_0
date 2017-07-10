//
//  JMSGTools.h
//  JMessageDemo
//
//  Created by deng on 16/8/23.
//  Copyright © 2016年 HXHG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMSGTools : NSObject

+ (void)showResponseResultWithInfo:(NSString *)info error:(NSError *)error;

+ (NSData *)getDataWithFileName:(NSString *)fileName;

+ (NSData *)getTestImageDate;

+ (NSData *)getTestVoiceDate;

+ (NSData *)getTestFileDate;

@end
