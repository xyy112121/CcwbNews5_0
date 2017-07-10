//
//  PhotoDefine.h
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#ifndef PhotoDefine_h
#define PhotoDefine_h
#import "Masonry.h"
#define Standard (1024.0)
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

static inline NSString * sizeWithLength(NSUInteger length)
{
    //转换成Btye
    NSUInteger btye = length;
    //如果达到MB
    if (btye > Standard * Standard)
    {
        return [NSString stringWithFormat:@"%.1fMB",btye / Standard / Standard];
    }
    else if (btye > Standard)
    {
        return [NSString stringWithFormat:@"%.0fKB",btye / Standard];
    }
    else
    {
        return [NSString stringWithFormat:@"%@B",@(btye)];
    }
}

#endif /* PhotoDefine_h */
