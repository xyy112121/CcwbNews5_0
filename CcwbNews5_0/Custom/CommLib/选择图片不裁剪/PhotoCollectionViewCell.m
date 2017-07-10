//
//  PhotoCollectionViewCell.m
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

/// @brief cell的选中状态
NS_OPTIONS(NSUInteger, PhotosCellType)
{
    CellTypeDeseleted = 0,/**<未选中 */
    CellTypeSelected = 1, /**<选中 */
};

@interface PhotoCollectionViewCell ()

@property (nonatomic, assign)enum PhotosCellType cellType;

//@property (weak, nonatomic)YPPhotosCell * weakSelf;

@end

@implementation PhotoCollectionViewCell

-(void)prepareForReuse
{
    //重置所有数据
    self.imageView.image = nil;
    self.chooseImageView.hidden = false;
    self.messageView.hidden = true;
    self.messageImageView.image = nil;
    self.messageLabel.text = @"";
    //    [self.chooseImageView setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    self.chooseImageView.image = [UIImage imageNamed:@"未选中"];
    self.cellType = CellTypeDeseleted;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUP];
}

- (void)setUP{
    [self initUI];
    [self initLayout];
}

- (void)initUI{
    UIImageView *image = [UIImageView new];
    [self.contentView addSubview:image];
    self.imageView = image;
//    image.contentMode = UIViewContentModeScaleAspectFit;
    
    UIControl *control = [UIControl new];
    [self.contentView addSubview:control];
    self.chooseControl = control;
    control.backgroundColor = [UIColor clearColor];
    [control addTarget:self action:@selector(chooseButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *choose = [UIImageView new];
    [self.contentView addSubview:choose];
    self.chooseImageView = choose;
//    choose.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    choose.image = [UIImage imageNamed:@"未选中"];
//    choose.layer.cornerRadius = 25 / 2.0;
//    choose.clipsToBounds = YES;
    
    UIView *message = [UIView new];
    [self.contentView addSubview:message];
    self.messageView = message;
    message.backgroundColor = [UIColor blackColor];
    message.hidden = YES;
    
    UIImageView *messageImage = [UIImageView new];
    [self.contentView addSubview:messageImage];
    self.messageImageView = messageImage;
    
    UILabel *subLabel = [UILabel new];
    [self.contentView addSubview:subLabel];
    self.messageLabel = subLabel;
    subLabel.font = [UIFont systemFontOfSize:11];
    subLabel.textAlignment = NSTextAlignmentRight;
    subLabel.textColor = [UIColor whiteColor];
//    subLabel.text = @"00:25";
}

- (void)initLayout{
    __weak __typeof(self)weakSelf = self;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
    }];

    [self.chooseControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.right.and.bottom.mas_equalTo(-3);
    }];
    
    [self.chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.and.bottom.mas_equalTo(-2);
    }];
    
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(@(20));
    }];
    
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(5));
        make.bottom.equalTo(weakSelf.messageView);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.messageImageView.mas_right);
        make.right.equalTo(weakSelf.messageView).offset(-3);
        make.bottom.equalTo(weakSelf.messageView);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark Action
- (void)chooseButtonDidTap:(id)sender
{
    switch (_cellType)
    {
        case CellTypeDeseleted:
            [self buttonShouldSelect];
            break;
        case CellTypeSelected:
            [self buttonShouldDeselect];
            break;
    }
}

- (void)buttonShouldSelect
{
    __weak __typeof(self)weakSelf = self;
    [self cellDidSelect];
    [self startAnimation];
    if (self.imageSelectedBlock) self.imageSelectedBlock(weakSelf);
}

- (void)buttonShouldDeselect
{
    __weak __typeof(self)weakSelf = self;
    [self cellDidDeselect];
    if (self.imageDeselectedBlock) self.imageDeselectedBlock(weakSelf);
}

- (void)startAnimation
{
    //anmiation
    [UIView animateWithDuration:0.2 animations:^{
        //放大
        _chooseImageView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    } completion:^(BOOL finished) {//变回
        [UIView animateWithDuration:0.2 animations:^{
            _chooseImageView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        }];
    }];
}

#pragma mark 选中、取消
-(void)cellDidSelect
{
    _cellType = CellTypeSelected;
    _chooseImageView.image = [UIImage imageNamed:@"选中"];
}

-(void)cellDidDeselect
{
    _cellType = CellTypeDeseleted;
    _chooseImageView.image = [UIImage imageNamed:@"未选中"];
}




@end
