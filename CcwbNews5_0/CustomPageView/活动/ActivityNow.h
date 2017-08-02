//
//  ActivityNow.h
//  CcwbNews
//
//  Created by xyy520 on 16/6/27.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityNow : UIView
{
	NSDictionary *dicsrc;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic TypeActivity:(NSString *)typemore;
@end
