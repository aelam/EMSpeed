//
//  MSCollectionViewTestCell2.m
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSCollectionViewTestCell2.h"
#import "MSCollectionCellModel.h"
#import "MSCollectionViewTestItem2.h"

@implementation MSCollectionViewTestCell2


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:_titleLabel];
        _titleLabel.text = @"111111";
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.textColor = [UIColor blueColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (void)update:(id<MSCollectionCellModel>)cellModel indexPath:(NSIndexPath *)indexPath
{
    if ([cellModel isKindOfClass:[MSCollectionViewTestItem2 class]]) {
        MSCollectionViewTestItem2 *item = cellModel;
        _titleLabel.text = item.title;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}

@end
