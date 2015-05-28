//
//  EMThemeTextSegmentCell.m
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeTextSegmentCell.h"


@implementation MSThemeTextSegmentCell

- (instancetype)initWithSegmentObject:(NSObject<MSSegmentCellObject> *)object
{
    if (self = [super initWithSegmentObject:object]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
}

- (instancetype)initWithText:(NSString *)object
{
    if (self = [super initWithText:object]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
}

- (void)applyTheme{
    self.seperateLayer.backgroundColor = [UIColor colorForKey:@"common_borderColor"].CGColor;
    self.font = [UIFont systemFontOfSize:15];
    self.selectedTextColor = [UIColor colorForKey:@"common_menuHighlightedColor"];
    self.normalTextColor = [UIColor colorForKey:@"common_textColor"];
}

- (void)registerThemeChangeNotificaiton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
}

- (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end