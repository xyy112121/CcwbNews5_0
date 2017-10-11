//
//  XIConversationCardMessageCellConfigurations.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/9/12.
//
//

#import <XiaoIceSDK_conversation/XiaoIceSDK_conversation.h>

@interface XIConversationCardMessageCellConfigurations : XIConversationMessageCellConfigurations

- (instancetype)initWithSender:(BOOL)isSender;

@property (nonatomic, strong) UIColor *textColor; // default is black
@property (nonatomic, strong) UIColor *dateColor; // default is lightGrayColor
@property (nonatomic, strong) UIFont *font; // default is system 14
@property (nonatomic, strong) UIFont *dateFont; // default is system 12
@property (nonatomic, strong) NSDictionary<NSString *, id> *attributedText; // default is nil

@property (nonatomic, assign) CGFloat cardItemHeight; // default is 80

@property (nonatomic, assign) CGFloat cardItemImageLeftSpace; // default is 5
@property (nonatomic, assign) CGFloat cardItemImageTopSpace; // default is 5
@property (nonatomic, assign) CGFloat cardItemImageBottomSpace; // default is 5
@property (nonatomic, assign) CGFloat cardItemImageWidth; // default is 100

@property (nonatomic, assign) CGFloat cardItemTitleToImageSpace; // default is 5
@property (nonatomic, assign) CGFloat cardItemTitleTopSpace; // default is 5
@property (nonatomic, assign) CGFloat cardItemTitleRightSpace; // default is 5
@property (nonatomic, assign) CGFloat cardItemTitleHeight; // default is 40

@property (nonatomic, assign) CGFloat cardItemDateToImageSpace; // default is 5
@property (nonatomic, assign) CGFloat cardItemDateBottomSpace; // default is 5
@property (nonatomic, assign) CGFloat cardItemDateRightSpace; // default is 5
@property (nonatomic, assign) CGFloat cardItemDateHeight; // default is 20

@end
