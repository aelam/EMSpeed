//
//  EMScrollableTableTitleView.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-11.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSScrollableTableContentHeaderView.h"

@implementation MSScrollableTableContentHeaderItem

@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;

- (id)init
{
    self = [super init];
    if (self) {
        self.height = 30;
        self.Class = [MSScrollableTableContentHeaderView class];
        self.reuseIdentify = @"MSScrollableTableContentHeaderView";
        self.isRegisterByClass = NO;
    }
    
    return self;
}

@end


@implementation MSScrollableTableContentHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.border = MSBorderStyleRight | MSBorderStyleTop | MSBorderStyleBottom;
}

- (void)update:(id<MSCellModel>)cellModel
{
    
}

@end
