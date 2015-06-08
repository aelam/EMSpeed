//
//  MSThemeDownloadManager.m
//  EMStock
//
//  Created by zhangzhiyao on 15-1-29.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MSThemeDownloadManager.h"
//#import "AFDownloadRequestOperation.h"
#import "ZipArchive.h"
//#import "EMCommonBundle.h"
//#import "EMAPP.h"
#import "MSThemeManager.h"

@interface MSThemeDownloadManager () {
    NSOperationQueue *_operationQueue;
}

@end

@implementation MSThemeDownloadManager

#define kThemeDirectoryComponent @"theme"
#define kThemeUnzipDirectoryComponent @"unzipFile"
#define kThemeZipFileName @"theme.zip"
#define kThemeVersionPlistName @"theme.plist"

#define kCacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) lastObject]
#define kThemeDirectory [kCacheDirectory stringByAppendingPathComponent:kThemeDirectoryComponent]

#define kKeyThemeVersion

+ (instancetype)sharedManager
{
    static MSThemeDownloadManager *__manager = nil;
    @synchronized(__manager) {
        if (!__manager) {
            __manager = [[MSThemeDownloadManager alloc] init];
        }
    }
    return __manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

+ (NSString *)currentThemeImageDirectory
{
    return [self themeImageDirectory:[MSThemeManager sharedManager].currentThemeName];
}

+ (NSString *)themeImageDirectory:(NSString *)themeName
{
    NSString *fileDirectoryPath = [kThemeDirectory stringByAppendingPathComponent:themeName];
    NSString *unzipedFilePath = [fileDirectoryPath stringByAppendingPathComponent:kThemeUnzipDirectoryComponent];
    return unzipedFilePath;
}

//- (void)loadTheme:(NSString *)themeName downloadButton:(EMThemeDownloadButton*)downloadButton completion:(void (^)(BOOL success,NSString *result))completion
//{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *fileDirectoryPath = [kThemeDirectory stringByAppendingPathComponent:themeName];
//    NSString *zipFilePath = [fileDirectoryPath stringByAppendingPathComponent:kThemeZipFileName];
//    NSString *unzipedFilePath = [[self class] themeImageDirectory:themeName];
//    
//    BOOL zipFileExist = [fileManager fileExistsAtPath:zipFilePath];
//    BOOL unzipedFileExist = [fileManager fileExistsAtPath:unzipedFilePath];
//    // 查看本地记录文件,取得当前已经下载的版本号
//    NSString *versionPlistPath = [fileDirectoryPath stringByAppendingPathComponent:kThemeVersionPlistName];
//    BOOL needUpdate = YES;
//    if ([fileManager fileExistsAtPath:versionPlistPath]) {
//        // 存在此记录文件,则对比版本号
//        NSDictionary *versionDic = [[NSDictionary alloc] initWithContentsOfFile:versionPlistPath];
//        NSString *themeVersion = [versionDic objectForKey:@"version"];
//        if ([themeVersion isEqualToString:EMAppVersion()]) {
//            // 若存在版本记录与app版本一致
//            needUpdate = NO;
//        }
//    }
//    
//    if (!needUpdate) {
//        // 版本记录一致,则检查文件是否存在
//        // 搜索本地内容,是否已经下载并解压缩
//        if (unzipedFileExist) {
//            // 存在已经解压缩的文件
//            completion(YES,unzipedFilePath);
//        }
//        else {
//            if (zipFileExist) {
//                [self unZip:fileDirectoryPath completion:completion];
//            }
//            else {
//                needUpdate = YES;
//            }
//        }
//    }
//    
//    if (needUpdate) {
//        // 根据版本号请求下载地址
//        EMAPP* app = [EMAPP app];
//        NSString* strVer = [NSString stringWithFormat:@"%d.%d.%d", app.majorVersion, app.minorVersion, app.builderNumber];
//        NSString *urlStr = [NSString stringWithFormat:@"%@?osVersion=%@&themeName=%@",kThemeUpdateURL,strVer,themeName];
//        [[EMNetworkManager sharedManager] EMGET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            BOOL success = [[responseObject objectForKey:@"success"] boolValue];
//            if (success) {
//                // 下载
//                // 先删除可能已经存在的文件
//                if (zipFileExist) {
//                    [fileManager removeItemAtPath:zipFilePath error:nil];
//                }
//                if (unzipedFileExist) {
//                    [fileManager removeItemAtPath:unzipedFilePath error:nil];
//                }
//                NSString *downloadUrl = [responseObject objectForKey:@"data"];
//                [self download:downloadUrl themeName:themeName downloadButton:downloadButton completion:completion];
//            }
//            else {
//                completion(NO,nil);
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            completion(NO,[error description]);
//        }];
//    }
//}

- (void)download:(NSString*)urlStr themeName:(NSString*)themeName downloadButton:(MSProgressDownloadButton*)downloadButton completion:(void (^)(BOOL success,NSString *result))completion
{
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3600];
//    
//    NSString *targetDirectoryPath = [kThemeDirectory stringByAppendingPathComponent:themeName];
//    NSString *targetPath = [targetDirectoryPath stringByAppendingPathComponent:kThemeZipFileName];
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if (![fileManager fileExistsAtPath:targetDirectoryPath]) {
//        [fileManager createDirectoryAtPath:targetDirectoryPath withIntermediateDirectories:YES attributes:nil error:NULL];
//    };
//    
//    dispatch_queue_t queue = dispatch_queue_create("theme", nil);
//    dispatch_async(queue, ^{
//        AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:targetPath shouldResume:YES];
//        
//        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"Successfully downloaded file to %@", targetPath);
//            // 下载成功,将本次下载版本号记录在plist中
//            NSString *versionPlistPath = [targetDirectoryPath stringByAppendingPathComponent:kThemeVersionPlistName];
//            NSDictionary *themeDic = @{@"version": EMAppVersion()};
//            [themeDic writeToFile:versionPlistPath atomically:YES];
//            [self unZip:targetDirectoryPath completion:completion];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            completion(NO,[error description]);
//            NSLog(@"Error: %@", error);
//        }];
//        
//        //    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下载中..." message:@"\n\n\n" delegate:self cancelButtonTitle:@"取消下载" otherButtonTitles:nil];
//        //    [alertView show];
//        
//        [operation setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
//            float percentDone = totalBytesReadForFile/(float)totalBytesExpectedToReadForFile;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [downloadButton setTitle:[NSString stringWithFormat:@"取消(%.2f%%)",percentDone*100] forState:UIControlStateNormal];
//                [downloadButton setProgress:percentDone];
//            });
//
////            NSLog(@"------%f",percentDone);
////            NSLog(@"Operation: bytesRead: %ld", (long)bytesRead);
////            NSLog(@"Operation: totalBytesRead: %lld", totalBytesRead);
////            NSLog(@"Operation: totalBytesExpected: %lld", totalBytesExpected);
////            NSLog(@"Operation: totalBytesReadForFile: %lld", totalBytesReadForFile);
////            NSLog(@"Operation: totalBytesExpectedToReadForFile: %lld", totalBytesExpectedToReadForFile);
//        }];
//        
//        [_operationQueue addOperation:operation];
//    });
    
    
}

- (void)cancelDownload
{
    [_operationQueue cancelAllOperations];
}

// ZIP
- (void)unZip:(NSString*)fileDirectoryPath completion:(void (^)(BOOL success,NSString *result))completion
{
    
    NSString *filePath = [fileDirectoryPath stringByAppendingPathComponent:kThemeZipFileName];
    NSString *unzipFilePath = [fileDirectoryPath stringByAppendingPathComponent:kThemeUnzipDirectoryComponent];
    dispatch_queue_t queue = dispatch_queue_create("theme", nil);
    dispatch_async(queue, ^{
        ZipArchive *za = [[ZipArchive alloc] init];
        // 1. 在内存中解压缩文件
        if ([za UnzipOpenFile: filePath]) {
            // 2. 将解压缩的内容写到缓存目录中
            BOOL ret = [za UnzipFileTo: unzipFilePath overWrite: YES];
            if (NO == ret){} [za UnzipCloseFile];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(YES,unzipFilePath);
            });
        }
    });
}

@end
