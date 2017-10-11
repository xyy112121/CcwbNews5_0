//
//  XIConversationType.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/9/11.
//
//

#ifndef XIConversationType_h
#define XIConversationType_h

typedef NS_ENUM(NSInteger, XIConversationViewControllerAlertType) {
    XIConversationViewControllerAlertTypeResend,
    XIConversationViewControllerAlertTypeNoRecordPermission,
    XIConversationViewControllerAlertTypeRecordDurationNotEnough,
    XIConversationViewControllerAlertTypeSendSpaceMessage,
    XIConversationViewControllerAlertTypePlayAudioFileNotExists,
};

typedef NS_ENUM(NSInteger, XIConversationMessageCellStatusViewAlignment) {
    XIConversationMessageCellStatusViewAlignmentBottom,
    XIConversationMessageCellStatusViewAlignmentTop,
    XIConversationMessageCellStatusViewAlignmentCenter,
};

typedef NS_ENUM(NSInteger, XIConversationMessageCellType) {
    XIConversationMessageCellTypeBlank,
    XIConversationMessageCellTypeText,
    XIConversationMessageCellTypeImage,
    XIConversationMessageCellTypeAudio,
    XIConversationMessageCellTypeCard,
};

typedef NS_ENUM(NSInteger, XIConversationShareMessageType) {
    XIConversationShareMessageTypeText = 0,
    XIConversationShareMessageTypeImage = 1,
    XIConversationShareMessageTypeAudio = 2,
    XIConversationShareMessageTypeCard = 3,
};

typedef NS_ENUM(NSInteger, XIConversationInputViewInputType) {
    XIConversationInputViewInputTypeKeyboard,
    XIConversationInputViewInputTypeSpeech,
    XIConversationInputViewInputTypeEmoticon,
    XIConversationInputViewInputTypeFunctions,
};

#endif /* XIConversationType_h */
