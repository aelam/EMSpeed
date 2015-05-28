//
//  EMThemeImageSegmentedCell.m
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeImageSegmentedCell.h"
#import "MSThemeProtocol.h"


@implementation MSThemeImageSegmentedCellObject

+ (instancetype)objectWithTitle:(NSString *)title image:(UIImage *)image
{
    MSThemeImageSegmentedCellObject *object = [[MSThemeImageSegmentedCellObject alloc] init];
    object.title = title;
    object.image = image;
    return object;
}

- (Class)cellClass
{
    return [MSImageSegmentedCell class];
}

@end


@implementation MSThemeImageSegmentedCell

- (instancetype)initWithSegmentObject:(MSImageSegmentedCellObject *)object
{
    self = [super init];
    if (self) {
        [self registerThemeChangeNotificaiton];
        
        self.backgroundColor = [UIColor clearColor];
        _object = object;
        
        [self applyTheme];
        
    }
    return self;
}


- (void)applyTheme{
    self.selectedColor = [UIColor colorForKey:@"common_menuHighlightedColor"];
    self.normalColor = [UIColor colorForKey:@"common_menuNormalColor"];
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
