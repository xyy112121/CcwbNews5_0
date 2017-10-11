//
//  XIConversationConfiguration.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/8/21.
//
//

#import <UIKit/UIKit.h>
#import "XIConversationType.h"

@interface XIConversationConfiguration : NSObject

//@property (nonatomic, assign) XIConversationMessageType *supportMessageType;

@property (nonatomic, strong) UIImage *navigationBackgroundImage;
@property (nonatomic, strong) UIColor *navigationBackgroundColor;

@property (nonatomic, strong) NSDictionary<NSString *,id> *navigationTitleTextAttributes;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, assign, getter=isTakePhotoSaveInPhotoLibrary) BOOL takePhotoSaveInPhotoLibrary;

@end
