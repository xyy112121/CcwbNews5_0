//
//  ForGetPwdViewController.h
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForGetPwdViewController : UIViewController<UITextFieldDelegate>
{
    AppDelegate *app;
    UITextField *textfieldphone;
    UITextField *textfieldcode;
    UITextField *textfieldpwd;
    
    int getyanzhengcodeflag;
    NSTimer * timerone;
}


@end
