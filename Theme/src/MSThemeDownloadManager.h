//
//  MSThemeDownloadManager.h
//  EMStock
//
//  Created by zhangzhiyao on 15-1-29.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSModelProtocol.h"
#import "MSProgressDownloadButton.h"

@interface MSThemeDownloadManager : NSObject {
    
}

+ (instancetype)sharedManager;

- (void)loadTheme:(NSString *)themeName downloadButton:(MSProgressDownloadButton*)downloadButton completion:(void (^)(BOOL success,NSString *result))completion;
- (void)download:(NSString*)urlStr themeName:(NSString*)themeName downloadButton:(MSProgressDownloadButton*)downloadButton completion:(void (^)(BOOL success,NSString *result))completion;
- (void)cancelDownload;

/**
 * 下载的主题色图片的读取地址，当前主题色对应的地址
 *
 *  @return 图片文件地址
 */
+ (NSString *)currentThemeImageDirectory;


/**
 * 下载的主题色图片的读取地址，指定主题色对应的地址
 *
 *  @return 图片文件地址
 */
+ (NSString *)themeImageDirectory:(NSString *)themeName;

@end
