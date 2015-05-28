//
//  MSThemeManager.m
//  MSThemeManager
//
//  Created by flora on 14/12/4.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSThemeManager.h"

static MSAPPThemeType __themeType = MSAPPThemeTypeLight;

@interface MSThemeManager()

@property (nonatomic, strong, readwrite) NSDictionary *controlStyles;

@end


@interface RNThemeManager ()

- (void)setStyles:(NSDictionary *)styles;

@end


@implementation MSThemeManager

+ (MSAPPThemeType)themeType
{
    return __themeType;
}


#pragma mark - Constants

#pragma mark - Actions

- (void)changeTheme:(NSString *)themeName {
    if ([themeName isEqualToString:EMAPPThemeLightName]) {
        __themeType = MSAPPThemeTypeLight;
    }
    else if ([themeName isEqualToString:EMAPPThemeBlackName]) {
        __themeType = MSAPPThemeTypeBlack;
    }
    
    [super changeTheme:themeName];
}

// 去掉一层dictionary key
- (NSDictionary *)parseDictionaryKeysWithSytles:(NSDictionary *)styles
{
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    
    for (NSString *key in styles) {
        id obj = [styles objectForKey:key];
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [mdict addEntriesFromDictionary:obj];
        }
        else if ([obj isKindOfClass:[NSString class]]) {
            [mdict setObject:obj forKey:key];
        }
    }
    
#ifdef DEBUG
    [self doubleCheckConflictKeys:styles];
#endif
    
    return [NSDictionary dictionaryWithDictionary:mdict];
}

- (void)doubleCheckConflictKeys:(NSDictionary *)styles
{
    NSMutableDictionary *dictKeys = [NSMutableDictionary dictionary];
    NSMutableArray *conflictKeys = [NSMutableArray array];
    
    // 计算重复的key
    for (NSString *key in styles) {
        id obj = [styles objectForKey:key];
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            for (NSString *akey in obj) {
                if ([dictKeys objectForKey:akey]) {
                    [conflictKeys addObject:akey];
                }
                
                [dictKeys setObject:obj forKey:akey];
            }
        }
        else if ([obj isKindOfClass:[NSString class]]) {
            if ([dictKeys objectForKey:key]) {
                [conflictKeys addObject:key];
            }
            [dictKeys setObject:obj forKey:key];
        }
    }
    
    if ([conflictKeys count]>0) {
        NSLog(@"重复的颜色 KEY = %@", conflictKeys);
        assert(0);
    }
}

@end


@implementation UIColor (Theme)

+ (UIColor *)colorForKey:(NSString *)key
{
    return [[MSThemeManager sharedManager] colorForKey:key];
}

@end


@implementation UIFont (Theme)

+ (UIFont *)fontForKey:(NSString *)key
{
    return [[MSThemeManager sharedManager] fontForKey:key];
}

@end


@implementation UIImage (Theme)

+ (UIImage *)imageForKey:(NSString *)key
{
    return [[MSThemeManager sharedManager] imageForKey:key];
}

@end


