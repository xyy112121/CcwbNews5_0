//
//  XIConversationMessageCellConfigurations.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/8/30.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XIConversationType.h"


@interface XIConversationMessageCellConfigurations : NSObject

- (instancetype)initWithType:(XIConversationMessageCellType)type isSender:(BOOL)isSender;

@property (nonatomic, assign, readonly) BOOL isSender; // YES is XiaoIce, NO is Custom.
@property (nonatomic, assign, readonly) XIConversationMessageCellType type;

@property (nonatomic, strong) UIImage *customAvatarImage; // 

@property (nonatomic, assign) CGRect avatarImageViewFrame; // default is (x: 10, y: 10, width: 40, height: 40)
@property (nonatomic, assign) UIEdgeInsets bubbleCapInsets; // default is (top: 15, left: 25, bottom: 15, right: 15)
@property (nonatomic, assign) CGFloat bubbleToAvatarSpace; // default is 10
@property (nonatomic, assign) CGFloat bubbleTopSpace; // default is 10
@property (nonatomic, assign) CGFloat bubbleBottomSpace; // default is 5
@property (nonatomic, assign) UIEdgeInsets contentViewInset; // default is (top: 5, left: 20, bottom: 5, right: 10)

@property (nonatomic, assign) XIConversationMessageCellStatusViewAlignment statusViewAlignment; // default is XIConversationMessageCellStatusViewAlignmentBottom
@property (nonatomic, assign) CGSize statusViewSize; // default is (width: 25, height: 25)
@property (nonatomic, assign) CGFloat statusViewToBubbleSpace; // default is 10


@end
