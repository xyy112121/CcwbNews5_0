//
//  CLBottomCommentView.h
//  CLBottomCommentView
//
//  Created by YuanRong on 16/1/19.
//  Copyright © 2016年 FelixMLians. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLBottomCommentViewDelegate.h"
#import "CLTextView.h"
#import "CLBottomCommentViewConfig.h"

@interface CLBottomCommentView : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic)  UIView *editView;
@property (strong, nonatomic)  UITextField *editTextField;
@property (strong, nonatomic)  UIButton *markButton;
@property (strong, nonatomic)  UIButton *shareButton;
@property(strong,nonatomic) NSString *strnewsid;
@property (weak, nonatomic) id<CLBottomCommentViewDelegate> delegate;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property (nonatomic, strong) CLTextView *clTextView;

- (void)showTextView;

- (void)clearComment;
- (instancetype)initWithFrame1:(CGRect)frame;
- (instancetype)initWithFrame2:(CGRect)frame;
-(void)gethancollection;
@end
