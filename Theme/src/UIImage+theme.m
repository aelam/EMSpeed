//
//  UIImage+theme.m
//  EMStock
//
//  Created by xoHome on 14-11-9.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "UIImage+theme.h"
#import "MSThemeManager.h"
#import "MSThemeDownloadManager.h"
#import "MSCoreMetrics.h"

@implementation UIImage(theme)


+ (UIImage *)imageForKey:(NSString *)key
{
    return [[MSThemeManager sharedManager] imageForKey:key];
    
}


+ (UIImage *)themeImageNamed:(NSString *)name
{
    UIImage *image = [UIImage localThemeImageNamed:name];
    if (image == nil)
    {
        image =  [UIImage imageNamed:name];
    }
    return image;
}

/**
 *  从本地存储文件中读取主题色相关图片
 *  获取当前主题色文件存储地址
 *  获取当前主题色图片名称
 *  从本地读取主题色图片
 *
 *  @param name 图片名称
 *  @param ext  图片文件类型
 *
 *  @return 图片
 */
+ (UIImage *)localThemeImageNamed:(NSString *)name extension:(NSString*)ext
{
    NSString *themeDirectory = [MSThemeDownloadManager currentThemeImageDirectory];
    UIImage *returnImage = nil;
    NSString *themeName = [MSThemeManager sharedManager].currentThemeName;
    NSString *imageName = [name stringByAppendingFormat:@"_%@",themeName];
    
    if (themeDirectory && themeDirectory.length)
    {//当前主题色有图片存储时
        NSString *filePath = [themeDirectory stringByAppendingPathComponent:imageName];
        
        int scale = MSScreenScale();
        
        while (!returnImage && scale >= 1)
        {
            NSString* tmpPath = filePath;
            if (scale > 1) {
                tmpPath = [tmpPath stringByAppendingFormat:@"@%dx",scale];
            }
            if ([ext length] > 0) {
                tmpPath = [tmpPath stringByAppendingPathExtension:ext];
            }
            returnImage = [UIImage imageWithContentsOfFile:tmpPath];
            scale --;
        }
    }
    else
    {
        returnImage = [UIImage imageNamed:imageName];
    }
    return returnImage;
}

+ (UIImage *)localThemeImageNamed:(NSString *)name
{
    return [UIImage localThemeImageNamed:name extension:nil];
}

/**
 *分主题色
 *主题色后按照当前分辨率读取图片
 */
+ (UIImage *)imageWithLocalResourceName:(NSString *)name ofType:(NSString *)ext
{
    UIImage *retImage = [UIImage localThemeImageNamed:name extension:ext];
    if (!retImage)
    {
        int scale = MSScreenScale();
        NSString * themeName = name;
        NSString * filePath = nil;
        while (filePath == nil && scale >= 0)
        {
            NSString *imgName = themeName;
            if (scale)
            {
                imgName = [themeName stringByAppendingFormat:@"@%dx",scale];
            }
            
            filePath = [[NSBundle mainBundle] pathForResource:imgName ofType:ext];
            scale --;
        }
        return [UIImage imageWithContentsOfFile:filePath];
    }
    else {
        return retImage;
    }
}

@end
