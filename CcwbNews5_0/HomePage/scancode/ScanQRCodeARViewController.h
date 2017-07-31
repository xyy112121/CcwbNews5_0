//
//  ScanQRCodeARViewController.h
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/10.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>


#define IOS_VERSION    [[[UIDevice currentDevice] systemVersion] floatValue]

#define LIGHTBUTTONTAG      200
#define IMPORTBUTTONTAG     201
#define IMPORTQRcode    202
#define IMPORTARcode    205
#define ImageBgTag     203

@interface ScanQRCodeARViewController : UIViewController
{
    AppDelegate *app;
    EnScanstatus scanstatus;
}
@end
