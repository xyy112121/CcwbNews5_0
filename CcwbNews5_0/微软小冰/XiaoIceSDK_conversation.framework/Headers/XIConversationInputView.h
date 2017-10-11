//
//  XIConversationInputView.h
//  XiaoIceSDK_conversation
//
//  Created by LinJia on 2017/8/21.
//
//

#import <UIKit/UIKit.h>
#import "XIConversationType.h"

@interface XIConversationInputView : UIView

+ (instancetype)inputView;

@property (nonatomic, assign) CGSize inputViewContentFunctionitemSize;
@property (nonatomic, assign) CGFloat inputViewContentHeight;
@property (nonatomic, assign) CGFloat inputViewMaxHeight;

@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIButton *recordingButton;

@property (nonatomic, strong) UIButton *speechButton;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, assign, readonly) XIConversationInputViewInputType inputType;
@property (nonatomic, assign, readonly, getter=isShowContent) BOOL showContent;

@end
