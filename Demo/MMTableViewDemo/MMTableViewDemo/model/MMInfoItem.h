//
//  EMInfoItem.h
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MSCellModel.h"
#import "NSObject+reflect.h"
#import "MSParseableObject+CellModel.h"

@class MMInfoCellModel;

@interface MMInfoItem : MSParseableObject

@property (nonatomic, strong) NSString *n_id;
@property (nonatomic, strong) NSString *n_id_id;
@property (nonatomic, strong) NSString *n_title;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *c;
@property (nonatomic, strong) NSString *n;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

