//
//  EMActivatorTextStatusBar.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeActivityIndicatorTextStatusBar.h"
#import "MSThemeActivityIndicatorTextModel.h"
#import "MSThemeManager.h"

@implementation MSThemeActivityIndicatorTextStatusBar

- (void)applyTheme{
    if ([MSThemeManager themeType] == MSAPPThemeTypeLight) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        
        [self.indicatorView removeFromSuperview];
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:self.indicatorView];
        self.indicatorView.transform = CGAffineTransformMakeScale(.5f, .5f);
    }
    else if ([MSThemeManager themeType] == MSAPPThemeTypeBlack) {
        self.backgroundColor = [UIColor blackColor];
        self.titleLabel.backgroundColor = [UIColor blackColor];
        [self.titleLabel setTextColor:[UIColor grayColor]];
        
        [self.indicatorView removeFromSuperview];
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:self.indicatorView];
        self.indicatorView.transform = CGAffineTransformMakeScale(.5f, .5f);
    }
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
