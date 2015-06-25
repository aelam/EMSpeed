//
//  EMSpreadTableTitleView.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-11.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSSpreadTableTitleHeaderView.h"

@implementation MSSpreadTableTitleHeaderItem

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;


- (id)init
{
    self = [super init];
    if (self) {
        self.height = 30;
        self.Class = [MSSpreadTableTitleHeaderView class];
        self.reuseIdentify = @"MSSpreadTableTitleHeaderView";
        self.isRegisterByClass = NO;
    }
    
    return self;
}

@end


@implementation MSSpreadTableTitleHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.border = MSBorderStyleLeft | MSBorderStyleTop | MSBorderStyleBottom;
}

- (void)update:(id<MSCellModel>)cellModel
{
    
}

@end
