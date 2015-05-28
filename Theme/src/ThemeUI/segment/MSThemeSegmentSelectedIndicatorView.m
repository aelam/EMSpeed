//
//  EMThemeSegmentSelectedIndicatorView.m
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeSegmentSelectedIndicatorView.h"
#import "MSThemeProtocol.h"

@implementation MSThemeSegmentSelectedIndicatorView


- (void)applyTheme{
    self.backgroundColor = [UIColor colorForKey:@"common_segmentBgColor"];
    self.indicatorBackgroundColor = [UIColor colorForKey:@"common_textColor"];
    self.indicatorColor = [UIColor colorForKey:@"common_menuHighlightedColor"];
    self.borderColor = [UIColor colorForKey:@"common_borderColor"];
}

# pragma mark - 不同的颜色

- (void)registerThemeChangeNotificaiton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
}

- (instancetype)init {
    if (self = [super init]) {
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
