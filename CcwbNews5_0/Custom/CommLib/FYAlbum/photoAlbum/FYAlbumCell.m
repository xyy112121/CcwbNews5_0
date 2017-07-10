//
//  FYAlbumCell.m
//  FYPlayer
//
//  Created by Charlie on 16/4/20.
//  Copyright © 2016年 www.fgyong.cn. All rights reserved.
//

#import "FYAlbumCell.h"

@implementation FYAlbumCell

- (void)awakeFromNib {
	
//	self.headView.contentMode = UIViewContentModeScaleAspectFill;
//	self.headView.clipsToBounds = YES;
	[super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
	self.imageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
