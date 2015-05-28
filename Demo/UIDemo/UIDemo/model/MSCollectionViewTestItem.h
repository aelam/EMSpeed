//
//  UICollectionViewTestItem.h
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCollectionCellModel.h"

@interface MSCollectionViewTestItem : NSObject <MSCollectionCellModel>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgName;
@end