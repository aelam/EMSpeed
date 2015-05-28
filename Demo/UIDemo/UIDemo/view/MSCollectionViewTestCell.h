//
//  MSCollectionViewTestCell.h
//  Coll
//
//  Created by Samuel on 15/4/15.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCollectionCellUpdating.h"

@interface MSCollectionViewTestCell : UICollectionViewCell <MSCollectionCellUpdating>

@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

