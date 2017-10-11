//
//  XIConversationManager.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/8/21.
//
//

#import <Foundation/Foundation.h>
#import "XIConversationViewController.h"

@interface XIConversationManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, assign, getter=isLogOpened) BOOL logOpened; // default is NO.

@property (nonatomic, strong) NSString *userId; // default is nil.

@property (nonatomic, strong, readonly) NSString *resourcePath;
@property (nonatomic, strong, readonly) NSBundle *resourceBundle;

- (UIImage *)getImage:(NSString *)imageName;

- (void)removeUserData;

- (void)removeAllData;

- (void)removeUserMedia;

- (void)removeAllMedia;

@end
