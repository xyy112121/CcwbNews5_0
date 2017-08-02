//
//  GoodsCellView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/3/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCellView : UIView<XLsn0wLoopDelegate,UIScrollViewDelegate>
{
	NSDictionary *dicsrc;
}
@property (nonatomic, strong) XLsn0wLoop *loop;
@property(nonatomic,strong)id<ActionDelegate> delegate1;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic More:(NSString *)more;
@end
