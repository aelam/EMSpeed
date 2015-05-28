//
//  MMInfoCell3.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMInfoCell3.h"
#import "MSCellModel.h"
#import "MMInfoItem3.h"

@implementation MMInfoCell3

- (void)update:(id<MSCellModel>)cellModel
{
    if ([cellModel isKindOfClass:[MMInfoItem3 class]]) {
        MMInfoItem3 *item = (MMInfoItem3 *)cellModel;
        self.titleLabel.text = item.n_title;
        self.dateLabel.text = item.date;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
