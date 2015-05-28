//
//  EMThemeLinkedButton.m
//  UI
//
//  Created by Samuel on 15/4/13.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeLinkedButton.h"
#import "MSThemeManager.h"

@implementation MSThemeLinkedButton

- (void)applyTheme{
    if ([MSThemeManager themeType] == MSAPPThemeTypeLight) {
        self.backgroundColor = [UIColor purpleColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if ([MSThemeManager themeType] == MSAPPThemeTypeBlack) {
        self.backgroundColor = [UIColor orangeColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)registerThemeChangeNotificaiton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
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
