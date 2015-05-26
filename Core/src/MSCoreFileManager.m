//
//  EMCoreFileManager.m
//  Core
//
//  Created by Mac mini 2012 on 15-3-9.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MSCoreFileManager.h"


static NSString *__defaultImageDirectory = nil; // 默认的图片文件夹路径

NSString* EMGetDefaultImageDirectory();


NSURL* EMFileURL(NSString *path)
{
    return [[NSURL alloc] initFileURLWithPath:path];
}

BOOL EMIsFileExistAtPath(NSString *filePath)
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    const bool isExist = [fileManager fileExistsAtPath:filePath];
    
    if (!isExist){
        NSLog(@"%@ not exist!", filePath);
    }
    
    return isExist;
}


# pragma mark -
# pragma mark Read and write plist file

NSArray* EMArrayFromMainBundle(NSString *filename)
{
    NSArray *arrayForReturn = nil;
    NSString *path = EMPathForBundleResource(nil, filename);
    
    if (EMIsFileExistAtPath(path)){
        arrayForReturn = [NSArray arrayWithContentsOfFile:path];
    }
    return arrayForReturn;
}


NSDictionary* EMDictionaryFromMainBundle(NSString *filename)
{
    NSDictionary *dictionaryForReturn = nil;
    NSString *path = EMPathForBundleResource(nil, filename);
    
    if (EMIsFileExistAtPath(path)){
        dictionaryForReturn = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return dictionaryForReturn;
}


NSArray* EMArrayFromCachesDirectory(NSString *filename)
{
    NSString *path = EMPathForCachesResource(filename);
    return [NSArray arrayWithContentsOfFile:path];
}


NSDictionary* EMDictionaryFromDocumentDirectory(NSString *filename)
{
    NSString *path = EMPathForCachesResource(filename);
    return [NSDictionary dictionaryWithContentsOfFile:path];
}


BOOL EMSaveArrayToCachesDirectory(NSString *filename, NSArray *array)
{
    NSString *path = EMPathForCachesResource(filename);
    return [array writeToFile:path atomically:YES];
}


BOOL EMSaveDictionaryToCachesDirectory(NSString *filename, NSDictionary *dictionary)
{
    NSString *path = EMPathForCachesResource(filename);
    return [dictionary writeToFile:path atomically:YES];
}


BOOL EMFileManagerCreateDirectory(NSString *dir)
{
    BOOL flag = NO;
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error = nil;
    
    if (![fileManger fileExistsAtPath:dir])
    {
        flag = [fileManger createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"createDirectoryAtPath faild:%@", error);
        }
    }
    else{
        NSLog(@"%@ 文件夹已存在", dir);
    }
    
    return flag;
}


BOOL EMFileManagerRemoveDirectory(NSString *dir)
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:dir error:nil];
}


BOOL EMFileManagerRemoveFile(NSString *file)
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:file error:nil];
}


BOOL EMFileManagerSaveFile(NSString *file, NSData *data)
{
    NSError *error = nil;
    BOOL flag = [data writeToFile:file options:NSDataWritingAtomic error:&error];

    if (flag == NO) {
        NSLog(@"EMFileManagerSaveFile error = %@", error);
    }
    
    return flag;
}


NSData *EMFileManagerFileAtPath(NSString *filePath)
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    return data;
}


NSString* EMGetDefaultImageDirectory()
{
    if (__defaultImageDirectory==nil) {
        __defaultImageDirectory = EMPathForCachesResource(@"/pic");
        EMFileManagerCreateDirectory(__defaultImageDirectory);
    }
    
    return __defaultImageDirectory;
}


BOOL EMFileManagerSaveImage(NSString *filename, UIImage *image)
{
    NSData *data = nil;
    
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", EMGetDefaultImageDirectory(), filename];
    
    return EMFileManagerSaveFile(filePath, data);
}



void EMSetDefaultImageDirectory(NSString *directory)
{
    if (__defaultImageDirectory==nil) {
        __defaultImageDirectory = EMGetDefaultImageDirectory();
    }
    
    __defaultImageDirectory = directory;
}



UIImage* EMFileManagerLoadImage(NSString *filename)
{
    NSString *dir = EMGetDefaultImageDirectory();
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", dir, filename];
    
    return [UIImage imageWithContentsOfFile:filePath];
}


# pragma mark - Path

NSString* EMPathForMainBundleResource(NSString* relativePath)
{
    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}


NSString* EMPathForBundleResource(NSBundle* bundle, NSString* relativePath) {
    NSString* resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}


NSString* EMPathForDocumentsResource(NSString* relativePath) {
    
    if (relativePath==nil) {
        relativePath = @"";
    }
    
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        documentsPath = [dirs objectAtIndex:0];
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}


NSString* EMPathForLibraryResource(NSString* relativePath) {
    static NSString* libraryPath = nil;
    if (nil == libraryPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        libraryPath = [dirs objectAtIndex:0];
    }
    return [libraryPath stringByAppendingPathComponent:relativePath];
}


NSString* EMPathForCachesResource(NSString* relativePath) {
    static NSString* cachesPath = nil;
    if (nil == cachesPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        cachesPath = [dirs objectAtIndex:0];
    }
    return [cachesPath stringByAppendingPathComponent:relativePath];
}
