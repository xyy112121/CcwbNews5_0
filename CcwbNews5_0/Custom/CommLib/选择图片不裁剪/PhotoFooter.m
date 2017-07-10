//
//  PhotoFooter.m
//  Zuoshibuguan
//
//  Created by wulinjie on 2016/12/22.
//  Copyright © 2016年 wulj. All rights reserved.
//

#import "PhotoFooter.h"

@implementation PhotoFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp{
    [self initUI];
    [self initLayout];
}

- (void)initUI{
    UILabel *label = [UILabel new];
    [self addSubview:label];
    self.assetCountLabel = label;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColorFromRGB(0x6F7179);
}

-(void)setCustomText:(NSString *)customText
{
    _customText = customText;
    _assetCountLabel.text = customText;
}

-(void)setNumberOfAsset:(NSUInteger)numberOfAsset
{
    _numberOfAsset = numberOfAsset;
    _assetCountLabel.text = [NSString stringWithFormat:@"共有%@张照片",@(numberOfAsset)];
}

- (void)initLayout{
    __weak __typeof(self)weakSelf = self;
    [self.assetCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(weakSelf);
    }];
}


@end
