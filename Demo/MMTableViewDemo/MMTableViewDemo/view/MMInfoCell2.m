//
//  MMInfoCell2.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-26.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MMInfoCell2.h"
#import "MMInfoItem.h"
#import "NSString+Utility.h"

@implementation MMInfoCell2

- (void)update:(id<MSCellModel>)cellModel
{
    if ([cellModel isKindOfClass:[MMInfoCellModel2 class]]) {
        MMInfoCellModel2 *cm = cellModel;
        self.titleLabel.text = cm.title;
        self.dateLabel.text = cm.dateString;
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


@implementation MMInfoCellModel2

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;

- (void)parseItem:(MMInfoItem *)item
{
    self.Class = [MMInfoCell2 class];
    self.height = 115;
    
    // cell model 数据的处理在这里
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:item.date];
    
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
    self.dateString = [dateFormatter stringFromDate:date];
    
    self.title = [NSString stringWithFormat:@"标题:%@", item.n_title];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self calculateHeight];
}

- (float)calculateHeight
{
    CGSize size = [self.title ms_sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(304, NSUIntegerMax)];
    
    self.height = 34 + floor(size.height);
    return self.height;
}



@end