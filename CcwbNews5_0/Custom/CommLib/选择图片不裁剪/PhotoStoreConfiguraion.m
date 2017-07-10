//
//  PhotoStoreConfiguraion.m
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import "PhotoStoreConfiguraion.h"


NSString * const ConfigurationCameraRoll = @"ConfigurationCameraRoll";
NSString * const ConfigurationHidden = @"ConfigurationHidden";
NSString * const ConfigurationSlo_mo = @"ConfigurationSlo_mo";
NSString * const ConfigurationScreenshots = @"ConfigurationScreenshots";
NSString * const ConfigurationVideos = @"ConfigurationVideos";
NSString * const ConfigurationPanoramas = @"ConfigurationPanoramas";
NSString * const ConfigurationTime_lapse = @"ConfigurationTime_lapse";
NSString * const ConfigurationRecentlyAdded = @"ConfigurationRecentlyAdded";
NSString * const ConfigurationRecentlyDeleted = @"ConfigurationRecentlyDeleted";
NSString * const ConfigurationBursts = @"ConfigurationBursts";
NSString * const ConfigurationFavorite = @"ConfigurationFavorite";
NSString * const ConfigurationSelfies = @"ConfigurationSelfies";

static NSArray <NSString *>*  groupNames;

@implementation PhotoStoreConfiguraion

+(void)initialize
{
    if (self == [PhotoStoreConfiguraion class])
    {
        
        groupNames = @[NSLocalizedString(@"Camera Roll", @""),
                       NSLocalizedString(@"Hidden", @""),
                       NSLocalizedString(@"Slo-mo", @""),
                       NSLocalizedString(@"Screenshots", @""),
                       NSLocalizedString(@"Panoramas", @""),
                       NSLocalizedString(@"Recently Added", @""),
                       NSLocalizedString(@"Selfies", @"")];
    }
}

-(NSArray *)groupNamesConfig
{
    return groupNames;
}

-(void)setGroupNames:(NSArray<NSString *> *)newGroupNames
{
    groupNames = newGroupNames;
    [self localizeHandle];
}

//初始化方法
-(instancetype)initWithGroupNames:(NSArray<NSString *> *)groupNames
{
    if (self = [super init])
    {
        [self setGroupNames:groupNames];
    }
    return self;
}


+(instancetype)storeConfigWithGroupNames:(NSArray<NSString *> *)groupNames
{
    return [[self alloc]initWithGroupNames:groupNames];
}

/** 本地化语言处理 */
- (void)localizeHandle
{
    NSMutableArray <NSString *> * localizedHandle = [NSMutableArray arrayWithArray:groupNames];
    for (NSUInteger i = 0; i < localizedHandle.count; i++)
    {
        [localizedHandle replaceObjectAtIndex:i withObject:NSLocalizedString(localizedHandle[i], @"")];
    }
    groupNames = [NSArray arrayWithArray:localizedHandle];
}

@end
