//
//  MSIconTextStatusBarData.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeStatusBarIconTextModel.h"
#import "MSThemeIconTextStatusBar.h"

@implementation MSThemeStatusBarIconTextModel
@synthesize viewClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewClass = [MSThemeIconTextStatusBar class];
    }
    
    return self;
}
@end
