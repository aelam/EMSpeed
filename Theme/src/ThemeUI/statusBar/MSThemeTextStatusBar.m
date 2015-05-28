//
//  EMStatusBarLabel.m
//  UI
//
//  Created by Samuel on 15/4/9.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeTextStatusBar.h"
#import "MSThemeStatusBarTextModel.h"
#import "MSThemeManager.h"


@interface MSThemeTextStatusBar() {
}

@end

@implementation MSThemeTextStatusBar

- (void)applyTheme{
    if ([MSThemeManager themeType] == MSAPPThemeTypeLight) {
        [self.titleLabel setTextColor:[UIColor blackColor]];
    }
    else if ([MSThemeManager themeType] == MSAPPThemeTypeBlack) {
        [self.titleLabel setTextColor:[UIColor lightGrayColor]];
    }
    self.backgroundColor = [UIColor colorForKey:@"statusBarBgColor"];
}

- (void)registerThemeChangeNotificaiton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    
    return self;
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
