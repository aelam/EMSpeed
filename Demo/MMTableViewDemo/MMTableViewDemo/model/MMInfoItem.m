//
//  EMInfoItem.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MMInfoItem.h"
#import "MMInfoCell.h"

@implementation MMInfoItem


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self ms_reflectDataFromOtherDictionary:dict];
    }
    
    return self;
}

- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options{
    return [self initWithDictionary:info];
}

@end
