//
//  UserInfo.h
//  Ccwbnewclient
//
//  Created by 谢 毅 on 13-11-6.
//  Copyright (c) 2013年 谢 毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"



@interface UserInfo : NSObject

@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *userpermission;
@property(nonatomic,strong)NSString *userheader;
@property(nonatomic,strong)NSString *usertel;
@property(nonatomic,strong)NSString *userstate;
@property(nonatomic,strong)NSString *useradmin;
@end
