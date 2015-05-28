//
//  EMInfoCell.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MMInfoCell.h"
#import "MMInfoItem.h"
#import "NSDate+string.h"

@implementation MMInfoCell

- (void)update:(id<MSCellModel>)cellModel
{
    if ([cellModel isKindOfClass:[MMInfoCellModel class]]) {
        MMInfoCellModel *cm = cellModel;
        self.titleLabel.text = cm.title;
        self.dateLabel.text = cm.dateString;
        self.delegate = cm.delegate;
    }
}

- (IBAction)pressButton:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    if (tag==0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(MMInfoCellDoPressBuy:)]) {
            [self.delegate MMInfoCellDoPressBuy:self];
        }
    }
    else if (tag==1) {
        if (self.delegate && [self. delegate respondsToSelector:@selector(MMInfoCellDoPressSell:)]) {
            [self.delegate MMInfoCellDoPressSell:self];
        }
    }
}

@end


@implementation MMInfoCellModel

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;

- (void)parseItem:(MMInfoItem *)item
{
    self.Class = [MMInfoCell class];
    
    // cell model 数据的处理在这里
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:item.date];
    
    [dateFormatter setDateFormat:@"MM/dd HH:mm"];
    self.dateString = [dateFormatter stringFromDate:date];
    
    self.title = [NSString stringWithFormat:@"标题:%@", item.n_title];
    
    self.height = 70;
}


- (float)calculateHeight
{
    // 计算高度
    return self.height;
}


@end
