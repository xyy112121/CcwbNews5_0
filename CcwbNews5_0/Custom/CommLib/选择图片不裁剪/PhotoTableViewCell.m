//
//  PhotoTableViewCell.m
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import "PhotoTableViewCell.h"

@interface PhotoTableViewCell ()

@property (nonatomic, weak)PhotoTableViewCell * weakSelf;

@end@implementation PhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self photoGroupCellWillLoad];
    }
    return self;
}

- (void)photoGroupCellWillLoad
{
    [self initUI];
    [self initLayout];
}

- (void)initUI{
    UIImageView *new = [UIImageView new];
    [self.contentView addSubview:new];
    self.GruopImageView = new;
    new.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *label = [UILabel new];
    [self.contentView addSubview:label];
    self.titleLabel = label;
    label.font = [UIFont systemFontOfSize:15];
}

- (void)initLayout{
     __weak __typeof(self)weakSelf = self;
    [self.GruopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5));
        make.bottom.equalTo(@(-5));
        make.left.equalTo(weakSelf.contentView.mas_left).with.offset(10);
        make.width.equalTo(weakSelf.GruopImageView.mas_height);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.GruopImageView.mas_centerY);
        make.left.equalTo(weakSelf.GruopImageView.mas_right).with.offset(10);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-10);
    }];
}




@end
