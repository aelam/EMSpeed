//
//  UICollectionViewTestItem.m
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSCollectionViewTestItem2.h"
#import "MSCollectionViewTestCell2.h"

@implementation MSCollectionViewTestItem2

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize layoutSize;
@synthesize isRegisterByClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 140;
        self.Class = [MSCollectionViewTestCell2 class];
        self.reuseIdentify = @"MSCollectionViewTestCell2";
        self.title = @"title";
        self.layoutSize = CGSizeMake(MSScreenWidth(), self.height);
        self.isRegisterByClass = YES;
    }
    
    return self;
}

- (float)calculateHeight
{
    return self.height;
}

@end