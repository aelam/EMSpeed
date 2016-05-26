//
//  MSSessionTaskManager.h
//  Pods
//
//  Created by flora on 16/5/25.
//
//

#import <Foundation/Foundation.h>

@interface MSSessionTaskManager : NSObject

+ (id)sharedManager;

- (void)addGlobalTask:(NSURLSessionTask *)task;
- (void)cancelGlobalTask:(NSURLSessionTask *)task;

- (void)addTask:(NSURLSessionTask *)task forGroup:(NSString *)group;
- (void)cancelTask:(NSURLSessionTask *)task forGroup:(NSString *)group;
- (void)cancelTask:(NSURLSessionTask *)task;
- (void)cancelTasksForGroup:(NSString *)group;

@end
