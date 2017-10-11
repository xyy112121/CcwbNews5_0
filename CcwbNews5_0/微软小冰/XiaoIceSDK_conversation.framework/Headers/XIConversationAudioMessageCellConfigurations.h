//
//  XIConversationAudioMessageCellConfigurations.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/9/12.
//
//

#import <XiaoIceSDK_conversation/XiaoIceSDK_conversation.h>

@interface XIConversationAudioMessageCellConfigurations : XIConversationMessageCellConfigurations

- (instancetype)initWithSender:(BOOL)isSender;

@property (nonatomic, strong) UIColor *textColor; // default is black
@property (nonatomic, strong) UIFont *font; // default is system 14

@property (nonatomic, assign) CGFloat bubbleMinWidth; // default is 70

@property (nonatomic, assign) CGFloat animateImageLeft; // default is 20
@property (nonatomic, assign) CGSize animateImageSize; // default is (Width: 15, height: 20)

@property (nonatomic, assign) CGFloat durationToanimateImageSpace; // default is 5

@property (nonatomic, assign) CGFloat unreadViewLeft; // default is 5
@property (nonatomic, assign) CGFloat unreadViewTop; // default is 15
@property (nonatomic, assign) CGSize unreadViewSize; // default is (Width: 6, height: 6)

@end
