//
//  XIConversationBlankMessageCellConfigurations.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/9/12.
//
//

#import <XiaoIceSDK_conversation/XiaoIceSDK_conversation.h>

@interface XIConversationBlankMessageCellConfigurations : XIConversationMessageCellConfigurations

- (instancetype)initWithSender:(BOOL)isSender;

@property (nonatomic, assign) CGFloat bubbleWidth; // default is 100

@end
