//
//  XIConversationImageMessageCellConfigurations.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/9/12.
//
//

#import <XiaoIceSDK_conversation/XiaoIceSDK_conversation.h>

@interface XIConversationImageMessageCellConfigurations : XIConversationMessageCellConfigurations

- (instancetype)initWithSender:(BOOL)isSender;

@property (nonatomic, assign) CGFloat maxImageHeight; // default is 200
@property (nonatomic, assign) CGFloat imageCornerRadius; // default is 8

@end
