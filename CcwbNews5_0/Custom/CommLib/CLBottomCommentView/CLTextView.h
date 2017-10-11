//
//  CLTextView.h
//  CLBottomCommentView
//
//  Created by YuanRong on 16/1/19.
//  Copyright © 2016年 FelixMLians. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLBottomCommentViewDelegate.h"
#import "ExpressionViewBar.h"
@interface CLTextView : UIView<ActionDelegate>


@property (nonatomic,strong)  ExpressionViewBar *expressionview;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (weak, nonatomic) id<CLBottomCommentViewDelegate> delegate;

@end
