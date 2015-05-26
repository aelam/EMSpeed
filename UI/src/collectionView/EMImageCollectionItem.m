//
//  EMImageCollectionItem.m
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMImageCollectionItem.h"
#import "EMImageCollectionViewCell.h"
#import "MSCore.h"

@implementation EMImageCollectionItem

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
        self.Class = [EMImageCollectionViewCell class];
        self.reuseIdentify = @"EMImageCollectionViewCell";
        self.layoutSize = CGSizeMake(EMScreenWidth(), self.height);
        self.isRegisterByClass = NO;
    }
    
    return self;
}

- (float)calculateHeight
{
    return self.height;
}

@end
