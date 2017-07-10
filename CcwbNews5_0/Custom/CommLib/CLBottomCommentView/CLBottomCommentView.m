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
		
		self.editView = [[UIView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width+8, 8, self.frame.size.width-168, 30)];
		self.editView.backgroundColor = [UIColor whiteColor];
		[self.contentView addSubview:self.editView];
		
		self.editTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 3, self.editView.frame.size.width-10, self.editView.frame.size.height-6)];
		self.editTextField.backgroundColor = [UIColor clearColor];
		self.editTextField.placeholder = @"说点什么";
		self.editTextField.font = FONTN(15.0f);
		[self.editView addSubview:self.editTextField];
		
		UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
		button1.layer.borderColor = [UIColor clearColor].CGColor;
		button1.frame = CGRectMake(self.editView.frame.origin.x+self.editView.frame.size.width+10, 6, 34, 34);
		[button1 setImage:LOADIMAGE(@"36icon评论",@"png") forState:UIControlStateNormal];
		[button1 addTarget:self action:@selector(clickcomment:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:button1];
		
		self.markButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.markButton.layer.borderColor = [UIColor clearColor].CGColor;
		self.markButton.frame = CGRectMake(button1.frame.origin.x+button1.frame.size.width+10, 6, 34, 34);
		[self.markButton setImage:LOADIMAGE(@"36icon收藏",@"png") forState:UIControlStateNormal];
		self.markButton.tag = 1609;
		[self.markButton addTarget:self action:@selector(markAction:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:self.markButton];
		
		self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.shareButton.layer.borderColor = [UIColor clearColor].CGColor;
		self.shareButton.frame = CGRectMake(self.markButton.frame.origin.x+self.markButton.frame.size.width+10, 6, 34, 34);
		[self.shareButton setImage:LOADIMAGE(@"36icon分享",@"png") forState:UIControlStateNormal];
		[self.shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:self.shareButton];
		
        [self configure];
		
    }
    return self;
}

- (instancetype)initWithFrame1:(CGRect)frame
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
		
		self.editView = [[UIView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width+8, 8, self.frame.size.width-48, 30)];
		self.editView.backgroundColor = [UIColor whiteColor];
		[self.contentView addSubview:self.editView];
		
		self.editTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 3, self.editView.frame.size.width-10, self.editView.frame.size.height-6)];
		self.editTextField.placeholder = @"说点什么";
		self.editTextField.font = FONTN(15.0f);
		self.editTextField.backgroundColor = [UIColor clearColor];
		[self.editView addSubview:self.editTextField];
		
		
		[self configure];
	}
	return self;
}

- (instancetype)initWithFrame2:(CGRect)frame
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
		
		self.editView = [[UIView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width+8, 8, self.frame.size.width-90, 30)];
		self.editView.backgroundColor = [UIColor whiteColor];
		[self.contentView addSubview:self.editView];
		
		self.editTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 3, self.editView.frame.size.width-10, self.editView.frame.size.height-6)];
		self.editTextField.placeholder = @"说点什么";
		self.editTextField.font = FONTN(15.0f);
		self.editTextField.backgroundColor = [UIColor clearColor];
		[self.editView addSubview:self.editTextField];
		
		
		self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.shareButton.layer.borderColor = [UIColor clearColor].CGColor;
		self.shareButton.frame = CGRectMake(self.editView.frame.origin.x+self.editView.frame.size.width+10, 6, 34, 34);
		[self.shareButton setImage:LOADIMAGE(@"36icon分享",@"png") forState:UIControlStateNormal];
		[self.shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:self.shareButton];
		
		[self configure];
	}
	return self;
}

-(void)gethancollection
{

}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	
	if([AddInterface judgeislogin])
	{
		[self addSubview:self.clTextView];
		
		if (textField.text.length > 4) {
			NSMutableString *string = [[NSMutableString alloc] initWithString:textField.text];
			self.clTextView.commentTextView.text = [string substringFromIndex:4];
		}
		
		[self.clTextView.commentTextView becomeFirstResponder];
		[[UIApplication sharedApplication].keyWindow addSubview:self.clTextView];
		return NO;
	}
	else
	{
		
	}
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
    self.shareButton.layer.cornerRadius = CGRectGetHeight(self.shareButton.frame) / 2;
    self.markButton.layer.cornerRadius = CGRectGetHeight(self.markButton.frame) / 2;
    
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
