//
//  LoginViewController.h
//  CcwbNews5_0
//
//  Created by xyy on 2017/7/26.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    AppDelegate *app;
    UITextField *textfieldphone;
    UITextField *textfieldpwd;
}
@end
