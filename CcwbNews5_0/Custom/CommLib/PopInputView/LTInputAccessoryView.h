//
//  LTInputAccessoryView.h
//  tourismOrange
//
//  Created by Meeno3 on 16/2/18.
//  Copyright © 2016年 Meeno. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LTInputAccessoryBlock)(NSString *contentStr);

@interface LTInputAccessoryView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic,strong) LTInputAccessoryBlock block;

/**
 *  弹出默认键盘
 *
 *  @param block 回调block
 */
- (void)showBlock:(LTInputAccessoryBlock)block;

/**
 *  弹出特定类型键盘
 *
 *  @param type  键盘类型
 *  @param block 回调block
 */
- (void)showKeyboardType:(UIKeyboardType)type
                   Block:(LTInputAccessoryBlock)block;

/**
 *  弹出带有默认文字的键盘
 *
 *  @param type    键盘类型
 *  @param content 默认文字
 *  @param block   回调block
 */
- (void)showKeyboardType:(UIKeyboardType)type
                 content:(NSString *)content
                   Block:(LTInputAccessoryBlock)block;
/**
 *  关闭键盘
 */
-(void)close;
@end
