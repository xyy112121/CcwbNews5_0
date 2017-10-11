//
//  XIConversationViewController.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/8/21.
//
//

#import <UIKit/UIKit.h>
#import "XIConversationInputView.h"
#import "XIConversationMessageCellConfigurations.h"
#import "XIConversationTipsCellConfigurations.h"
#import "XIConversationConfiguration.h"
#import "XIConversationType.h"

#import "XIConversationBlankMessageCellConfigurations.h"
#import "XIConversationTextMessageCellConfigurations.h"
#import "XIConversationImageMessageCellConfigurations.h"
#import "XIConversationAudioMessageCellConfigurations.h"
#import "XIConversationCardMessageCellConfigurations.h"

@class XIConversationViewController;
@protocol XIConversationViewControllerUIDelegate <NSObject>

@optional
- (XIConversationInputView *)conversationViewControllerShouldShowInputView:(XIConversationViewController *)viewController;

- (XIConversationMessageCellConfigurations *)conversationViewController:(XIConversationViewController *)viewController displayMessageViewNeedConfigurationsWithCellType:(XIConversationMessageCellType)messageCellType isSender:(BOOL)isSender;
- (XIConversationTipsCellConfigurations *)conversationViewControllerDisplayTimeTipsViewConfigurations:(XIConversationViewController *)viewController;

- (void)conversationViewController:(XIConversationViewController *)viewController shouldDisplayAlertWithType:(XIConversationViewControllerAlertType)alertType cancelHandler:(void(^)())cancelHandler confirmHandler:(void(^)())confirmHandler;

@end


@protocol XIConversationViewControllerFunctionsDelegate <NSObject>

@optional
- (void)conversationViewControllerDidTappedXiaoIceAvatar:(XIConversationViewController *)viewController;
- (void)conversationViewControllerDidTappedCustomAvatar:(XIConversationViewController *)viewController;

- (void)conversationViewController:(XIConversationViewController *)viewController didTappedCardItem:(NSString *)newsURL title:(NSString *)title content:(NSString *)content imageURL:(NSString *)imageURL imageLocalPath:(NSString *)imageLocalPath;
- (void)conversationViewController:(XIConversationViewController *)viewController didTappedImageMessage:(UIImage *)image imageLocalPath:(NSString *)imageLocalPath isSender:(BOOL)isSender;

- (BOOL)conversationViewController:(XIConversationViewController *)viewController canShareMessageWithType:(XIConversationShareMessageType)messageType isSender:(BOOL)isSender;
- (void)conversationViewController:(XIConversationViewController *)viewController shareTextMessageWithText:(NSString *)messageText messageTime:(double)messageTime isSender:(BOOL)isSender;
- (void)conversationViewController:(XIConversationViewController *)viewController shareImageMessageWithImageLocalPath:(NSString *)imageLocalPath messageTime:(double)messageTime isSender:(BOOL)isSender;
- (void)conversationViewController:(XIConversationViewController *)viewController shareAudioMessageWithAudioLocalPath:(NSString *)audioLocalPath messageTime:(double)messageTime isSender:(BOOL)isSender;
- (void)conversationViewController:(XIConversationViewController *)viewController shareCardMessageItemWithItemImageLocalPath:(NSString *)itemImageLocalPath itemTitle:(NSString *)itemTitle itemDescription:(NSString *)itemDescription itemContentURL:(NSString *)itemContentURL messageTime:(double)messageTime isSender:(BOOL)isSender;

@end


@interface XIConversationViewController : UIViewController

@property (nonatomic, weak) id<XIConversationViewControllerUIDelegate> uiDelegate;
@property (nonatomic, weak) id<XIConversationViewControllerFunctionsDelegate> functionDelegate;

@property (nonatomic, strong, readonly) XIConversationInputView *contentInputView;

@property (nonatomic, strong, readonly) XIConversationConfiguration *configuration;

- (void)setConfiguration:(XIConversationConfiguration *)configuration;

@end


