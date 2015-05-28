//
//  EMActivityIndicatorTextData.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeActivityIndicatorTextModel.h"
#import "MSThemeActivityIndicatorTextStatusBar.h"

@implementation MSThemeActivityIndicatorTextModel
@synthesize viewClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewClass = [MSThemeActivityIndicatorTextStatusBar class];
    }
    
    return self;
}

@end
