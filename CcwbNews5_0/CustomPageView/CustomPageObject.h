//
//  CustomPageObject.h
//  CcwbNews
//
//  Created by xyy520 on 16/6/13.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <UIKit/UIKit.h>
@interface CustomPageObject : NSObject

+(void)adddefaultpath;
+(NSString *)computeheight:(NSDictionary *)dic; // 计算单个元素高度
+(NSMutableArray *)computeheight:(NSDictionary *)dic ArrayHeght:(NSMutableArray *)arrayheight;  //讲算列表的高度

+(void)CUgetUserInfo:(AppDelegate *)app StrJson:(NSString *)strjson;//获取userinfo

+(NSString *)getrequesturlstring:(NSString *)strsrc App:(AppDelegate *)app;//获取请求url

+(NSString*)DataTOjsonString:(id)object;//dic转json

+ (NSString*)convertToJSONData:(id)infoDict;
@end
