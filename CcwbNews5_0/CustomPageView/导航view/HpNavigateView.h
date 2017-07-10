//
//  HpNavigateView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/2/20.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HpNavigateView : UIView<UITextFieldDelegate>
{
	NSString *fromflag;
	NSDictionary *dicsrc;
	AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame FromFlag:(NSString *)from;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom;
@end
