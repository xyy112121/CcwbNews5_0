//
//  BrokeAudioView.h
//  CcwbNews5_0
//
//  Created by xyy520 on 17/4/17.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrokeAudioView : UIView
{
	AppDelegate *app;
	NSString *fromaudiopath;
	EnPlaytatus playstatus;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame FromUser:(NSString *)fromuser AudioPath:(NSString *)audiopath TimeLength:(NSString *)timelength;
@end
