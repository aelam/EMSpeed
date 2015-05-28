//
//  EMThemeSegmentedControl.m
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeSegmentedControl.h"
#import "MSThemeSegmentCellFactory.h"

@implementation MSThemeSegmentedControl


- (void)applyTheme{
    self.backgroundColor = [UIColor colorForKey:@"common_segmentBgColor"];
}

- (Class)segmentCellFactoryClass
{
    return [MSThemeSegmentCellFactory class];
}

- (Class)selectedViewClassWithStyle:(MSSegmentSelectedIndicatorStyle)style
{
    if (style == MSselectedIndicatorStyleMenuTitle) {
        return [MSSegmentSelectedIndicatorArrowBar class];
    }
    else if (style == MSselectedIndicatorStyleMenuContent) {
        return [MSSegmentSelectedIndicatorArrowLine class];
    }
    
    // add more style here...
    
    return nil;
}

# pragma mark - 不同的颜色


- (void)registerThemeChangeNotificaiton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
}

- (instancetype)initWithItems:(NSArray *)items {
    if (self = [super initWithItems:items]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self applyTheme];
}

- (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
