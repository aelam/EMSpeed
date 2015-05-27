//
//  EMScrollableTableTitleView.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-11.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSScrollableTableTitleHeaderView.h"

@implementation MSScrollableTableTitleHeaderItem

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;


- (id)init
{
    self = [super init];
    if (self) {
        self.height = 30;
        self.Class = [MSScrollableTableTitleHeaderView class];
        self.reuseIdentify = @"MSScrollableTableTitleHeaderView";
        self.isRegisterByClass = NO;
    }
    
    return self;
}

@end


@implementation MSScrollableTableTitleHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.border = MSBorderStyleLeft | MSBorderStyleTop | MSBorderStyleBottom;
}

- (void)update:(id<MSCellModel>)cellModel
{
    
}

@end
