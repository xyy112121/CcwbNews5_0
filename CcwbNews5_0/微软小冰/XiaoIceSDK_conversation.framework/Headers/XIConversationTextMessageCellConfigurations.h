//
//  XIConversationTextMessageCellConfigurations.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/9/12.
//
//

#import <XiaoIceSDK_conversation/XiaoIceSDK_conversation.h>

@interface XIConversationTextMessageCellConfigurations : XIConversationMessageCellConfigurations

- (instancetype)initWithSender:(BOOL)isSender;

@property (nonatomic, strong) UIColor *textColor; // default is black
@property (nonatomic, strong) UIFont *font; // default is system 14
@property (nonatomic, strong) NSDictionary<NSString *, id> *attributedText; // default is nil

@end
