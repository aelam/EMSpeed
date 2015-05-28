//
//  EMStatusBarData.m
//  UI
//
//  Created by Samuel on 15/4/9.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeStatusBarTextModel.h"
#import "MSThemeTextStatusBar.h"

@implementation MSThemeStatusBarTextModel

@synthesize viewClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewClass = [MSThemeTextStatusBar class];
    }
    
    return self;
}

@end
