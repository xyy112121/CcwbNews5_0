//
//  DBPlayVideoVC.h
//  CustomVideoCapture
//
//  Created by dengbin on 15/1/19.
//  Copyright (c) 2015年 IUAIJIA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBTakeVideoVC;
@interface DBPlayVideoVC : UIViewController
@property(nonatomic,strong)NSURL   *fileURL;
@property(nonatomic,strong)DBTakeVideoVC *delegate;
@end
