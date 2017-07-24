//
//  ApplicationAdView.h
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/24.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationAdView : UIView
{
    NSDictionary *dicsrc;
}
@property(nonatomic,strong)id<ActionDelegate> delegate1;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic;
@end
