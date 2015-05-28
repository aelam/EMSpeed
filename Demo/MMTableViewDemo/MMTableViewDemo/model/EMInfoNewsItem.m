//
//  EMInfoNewsItem.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "EMInfoNewsItem.h"
#import "NSObject+reflect.h"
#import "EMInfoNewsCell.h"

@implementation EMInfoNewsItem

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self ms_reflectDataFromOtherDictionary:dictionary];
        self.height = 70;
        self.Class = [EMInfoNewsCell class];
        self.reuseIdentify = @"EMInfoNewsCell";
    }
    return self;
}

- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options
{
    return [self initWithDictionary:info];
}
@end
