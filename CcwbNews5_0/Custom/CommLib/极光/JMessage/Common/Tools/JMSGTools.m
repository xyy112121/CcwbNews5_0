//
//  JMSGTools.m
//  JMessageDemo
//
//  Created by deng on 16/8/23.
//  Copyright © 2016年 HXHG. All rights reserved.
//

#import "JMSGTools.h"

@implementation JMSGTools

+ (void)showResponseResultWithInfo:(NSString *)info error:(NSError *)error {
    if (!error) {
        info = [info stringByAppendingString:@" success"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:info delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        info = [NSString stringWithFormat:@"%@, error: %@", info, error];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:info delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

+ (NSData *)getDataWithFileName:(NSString *)fileName {
    NSString *filePath = [[[NSBundle mainBundle] resourcePath]
                          stringByAppendingPathComponent:fileName];
    NSURL *localUrl = [NSURL fileURLWithPath:filePath];
    return [NSData dataWithContentsOfURL:localUrl];
}

+ (NSData *)getTestImageDate {
    UIImage *image = [UIImage imageNamed:@"dog.jpg"];
    return UIImageJPEGRepresentation(image, 0.5);
}

+ (NSData *)getTestVoiceDate {
    NSData *data = [JMSGTools getDataWithFileName:@"voice.mp3"];
    return data;
}

+ (NSData *)getTestFileDate {
    NSData *data = [JMSGTools getDataWithFileName:@"zipFile.zip"];
    return data;
}

@end
