//
//  LTInputAccessoryView.m
//  tourismOrange
//
//  Created by Meeno3 on 16/2/18.
//  Copyright © 2016年 Meeno. All rights reserved.
//
#define Screen_Width [[UIScreen mainScreen] bounds].size.width
#define Screen_Height [[UIScreen mainScreen] bounds].size.height
#import "LTInputAccessoryView.h"

@implementation LTInputAccessoryView
-(void)awakeFromNib{
    [super awakeFromNib];
    [self loadNibFile];
    [self loadUI];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadNibFile];
        [self loadUI];
    }
    return self;
}
-(instancetype)init{
    if (self = [super init]) {
        [self loadNibFile];
        [self loadUI];
    }
    return self;
}

-(void)loadNibFile{
    [[NSBundle mainBundle]loadNibNamed:@"LTInputAccessoryView" owner:self options:nil];
}

-(void)loadUI{
    [self addSubview:self.contentView];
    
    //监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}


-(void)show{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, Screen_Height, Screen_Width, 46);
    [window addSubview:self];
    
}
-(void)close{
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)showBlock:(LTInputAccessoryBlock)block{
    [self show];
    [self.textField becomeFirstResponder];
    self.block = block;
}

- (void)showKeyboardType:(UIKeyboardType)type
                   Block:(LTInputAccessoryBlock)block{
    [self show];
    self.textField.keyboardType = type;
    [self.textField becomeFirstResponder];
    self.block = block;
}


- (void)showKeyboardType:(UIKeyboardType)type
                 content:(NSString *)content
                   Block:(LTInputAccessoryBlock)block{
    [self show];
    self.textField.keyboardType = type;
    self.textField.placeholder = content;
    [self.textField becomeFirstResponder];
    self.block = block;
}

#pragma mark - 监听键盘事件
- (void)keyboardWillShow:(NSNotification *)notif {
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.size.height;
    float animationTime = [[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:animationTime animations:^{
        self.frame = CGRectMake(0, Screen_Height - y - 46, Screen_Width, 46);
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, Screen_Height, Screen_Width, 46);
    }];
//    [self close];
    
}
- (void)keyboardDidHide:(NSNotification *)notif {
    
    if (self.block&&self.textField.text.length) {
        self.block(self.textField.text);
    }
    [self close];
    
}

- (IBAction)onTapBtn:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];

//    if (self.block) {
//        self.block(self.textField.text);
//    }
//    [self close];

}

@end
