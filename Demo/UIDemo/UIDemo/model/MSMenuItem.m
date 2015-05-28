//
//  EMButtonItem.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSMenuItem.h"
#import "MSMenuTableViewCell.h"

@implementation MSMenuItem
@synthesize height;
@synthesize Class;
@synthesize reuseIdentify;
@synthesize isRegisterByClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 44;
        self.Class = [MSMenuTableViewCell class];
        self.reuseIdentify = @"EMButtonTableViewCell";
        self.isRegisterByClass = NO;
    }
    
    return self;
}

@end
