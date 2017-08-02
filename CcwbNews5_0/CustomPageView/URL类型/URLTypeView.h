//
//  URLTypeView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/6.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface URLTypeView : UIView
{
	NSDictionary *dicsrc;
}
@property(nonatomic,strong)id<ActionDelegate> delegate1;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic TypeUrl:(NSString *)typeurl;
@end
