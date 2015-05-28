//
//  MSCollectionViewTestCell.m
//  Coll
//
//  Created by Samuel on 15/4/15.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSCollectionViewTestCell.h"
#import "MSCollectionViewTestItem.h"

@implementation MSCollectionViewTestCell

- (void)update:(id<MSCollectionCellModel>)cellModel
{
    if ([cellModel isKindOfClass:[MSCollectionViewTestItem class]]) {
        MSCollectionViewTestItem *item = cellModel;
        
        self.titleLabel.text = item.title;
        self.imgv.image = [UIImage imageNamed:item.imgName];
    }
}

- (void)update:(id<MSCollectionCellModel>)cellModel indexPath:(NSIndexPath *)indexPath
{
    if ([cellModel isKindOfClass:[MSCollectionViewTestItem class]]) {
        MSCollectionViewTestItem *item = cellModel;
        
        self.titleLabel.text = item.title;
        self.imgv.image = [UIImage imageNamed:item.imgName];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

@end

