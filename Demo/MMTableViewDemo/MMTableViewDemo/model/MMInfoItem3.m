//
//  MMInfoItem2.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMInfoItem3.h"
#import "MMInfoCell3.h"

@implementation MMInfoItem3

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self ms_reflectDataFromOtherDictionary:dict];
        
        self.height = 132;
        self.Class = [MMInfoCell3 class];
        self.reuseIdentify = @"MMInfoCell3";
    }
    
    return self;
}


- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options
{
    return [self initWithDictionary:info];
}

@end
