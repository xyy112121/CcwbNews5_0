//
//  TuiJianNewsView.h
//  CcwbNews5_0
//
//  Created by xyy on 2017/8/23.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuiJianNewsView : UIView
{
    NSDictionary *dicsrc;
}
@property(nonatomic,strong)id<ActionDelegate> delegate1;
-(id)initWithFrame:(CGRect)frame Dicsrc:(NSDictionary *)dic;
@end
