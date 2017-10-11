//
//  CLBottomCommentView.m
//  CLBottomCommentView
//
//  Created by YuanRong on 16/1/19.
//  Copyright © 2016年 FelixMLians. All rights reserved.
//

#import "CLBottomCommentView.h"
#import "Header.h"
@implementation CLBottomCommentView
@synthesize strnewsid;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"CLBottomCommentView" owner:self options:nil];
        [self.contentView setFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self addSubview:self.contentView];
		
		//添加元素在上面
		UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(8, 13, 20, 20)];
		imageview.image = LOADIMAGE(@"36icon写", @"png");
		[self.contentView addSubview:imageview];
		
		self.editView = [[UIView alloc] initWithFrame:CGRectMake(36, 8, 100, 30)];
		self.editView.backgroundColor = [UIColor whiteColor];
		[self.contentView addSubview:self.editView];
		
		self.editTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 3, self.editView.frame.size.width-10, self.editView.frame.size.height-6)];
		self.editTextField.backgroundColor = [UIColor clearColor];
		self.editTextField.placeholder = @"说点什么";
		self.editTextField.font = FONTN(15.0f);
		[self.editView addSubview:self.editTextField];
		
        [self configure];
        
        
		
    }
    return self;
}

-(void)gethancollection
{

}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    [self addSubview:self.clTextView];
    
    
    
    if (textField.text.length > 4) {
        NSMutableString *string = [[NSMutableString alloc] initWithString:textField.text];
        self.clTextView.commentTextView.text = [string substringFromIndex:4];
    }
    
    [self.clTextView.commentTextView becomeFirstResponder];
    [[UIApplication sharedApplication].keyWindow addSubview:self.clTextView];
    return NO;
}

#pragma mark - Event Response

- (void)markAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(bottomViewDidMark:)]) {
        [self.delegate bottomViewDidMark:sender];
    }
}

- (void)shareAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(bottomViewDidShare)]) {
        [self.delegate bottomViewDidShare];
    }
}

-(void)clickcomment:(UIButton *)sender
{
	if ([self.delegate respondsToSelector:@selector(bottomViewComment:)]) {
		[self.delegate bottomViewComment:sender];
	}
}

#pragma mark - Public Method

- (void)showTextView {
    [self.editTextField becomeFirstResponder];
}

- (void)clearComment {
    self.editTextField.text = @"";
    self.clTextView.commentTextView.text = @"";
    [self.clTextView.sendButton setTitleColor:kColorTextTime forState:UIControlStateNormal];
}

#pragma mark - Private Method

- (void)configure {
	self.editView.layer.borderColor = COLORNOW(210, 210, 210).CGColor;
	self.editView.layer.borderWidth = 1.0f;

    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.5)];
    lineView.backgroundColor = kColorLineBarSeperator;
    [self.contentView addSubview:lineView];
    
    self.editTextField.delegate = self;
}

#pragma mark - Accessor

- (CLTextView *)clTextView  {
    if (!_clTextView) {
        _clTextView = [[CLTextView alloc] initWithFrame:CGRectMake(0, 0, cl_ScreenWidth, cl_ScreenHeight)];
        _clTextView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _clTextView;
}




@end
