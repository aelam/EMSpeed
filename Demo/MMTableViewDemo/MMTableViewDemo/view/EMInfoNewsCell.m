//
//  EMInfoNewsCell.m
//  EMStock
//
//  Created by Mac mini 2012 on 14-10-29.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMInfoNewsCell.h"
#import "MSCellUpdating.h"
#import "EMInfoNewsItem.h"
#import "NSDate+string.h"

@implementation EMInfoNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)update:(id<MSCellModel>)cellModel indexPath:(NSIndexPath *)indexPath
{
    if ([cellModel isKindOfClass:[EMInfoNewsItem class]]) {
        
        EMInfoNewsItem *item = (EMInfoNewsItem *)cellModel;
        self.titleLabel.text = item.title;
        self.contentLabel.text = item.summary;
        self.timeLabel.text = item.date;
        self.jianLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(15, 9, self.frame.size.width-15*2, 17);
}

@end



