//
//  EMThemeBorderView.m
//  UI
//
//  Created by Samuel on 15/4/13.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeBorderView.h"
#import "MSThemeManager.h"

@implementation MSThemeBorderView

- (void)applyTheme{
    if ([MSThemeManager themeType] == MSAPPThemeTypeLight) {
        self.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.f];
        self.borderColor = [UIColor redColor];
    }
    else if ([MSThemeManager themeType] == MSAPPThemeTypeBlack) {
        self.backgroundColor = [UIColor darkGrayColor];
        self.borderColor = [UIColor whiteColor];
    }
}

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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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
