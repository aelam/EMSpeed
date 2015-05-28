//
//  MSThemeManager.h
//  MSThemeManager
//
//  Created by flora on 14/12/4.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "RNThemeManager.h"


static NSString *const EMAPPThemeLightName = @"default";
static NSString *const EMAPPThemeBlackName = @"black";


typedef NS_ENUM(NSInteger, MSAPPThemeType)
{
    MSAPPThemeTypeLight = 0,//白色主题
    MSAPPThemeTypeBlack = 1,//黑色主题
};

@interface MSThemeManager : RNThemeManager

/**
 *  当前的场景颜色风格
 *
 *  @return 当前的场景颜色风格
 */
+ (MSAPPThemeType)themeType;


@end


@interface UIColor (Theme)

+ (UIColor *)colorForKey:(NSString *)key;

@end


@interface UIFont (Theme)

+ (UIFont *)fontForKey:(NSString *)key;

@end


@interface UIImage (Theme)

+ (UIImage *)imageForKey:(NSString *)key;

@end





