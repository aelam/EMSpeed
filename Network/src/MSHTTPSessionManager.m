//
//  MSHTTPSessionManager.m
//  Pods
//
//  Created by Mac mini 2012 on 15/6/13.
//
//

#import "MSHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "MSHTTPResponse.h"

NSString * const MSHTTPSessionManagerTaskDidFailedNotification = @"com.emoneyet.emstock.task.failed";

@implementation MSHTTPSessionManager

+ (MSHTTPSessionManager *)sharedManager
{
    static MSHTTPSessionManager *__manager = nil;
    @synchronized(self)
    {
        if (__manager == nil) {
            __manager = [MSHTTPSessionManager manager];
            __manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"application/octet-stream", nil];
        }
    }
    return __manager;
}


- (NSURLSessionTask *)GET:(NSString *)URLString
                        param:(NSDictionary *)param
                        block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    MSHTTPSessionManager *manager = [MSHTTPSessionManager sharedManager];
    
    NSURLSessionTask *task = [manager GET:URLString parameters:param success:^(NSURLSessionTask *task, id responseObject) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        block(response, task, YES);
        
    } failure:^(NSURLSessionTask *task, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MSHTTPSessionManagerTaskDidFailedNotification object:task];
        MSHTTPResponse *response = [MSHTTPResponse responseWithError:error];
        block(response, task, NO);
    }];
    
    return task;
}


- (NSURLSessionTask *)POST:(NSString *)URLString
                         param:(NSDictionary *)param
                         block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    MSHTTPSessionManager *manager = [MSHTTPSessionManager sharedManager];
    
    NSURLSessionTask *task = [manager POST:URLString parameters:param success:^(NSURLSessionTask *task, id responseObject) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        block(response, task, YES);
        
    } failure:^(NSURLSessionTask *task, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MSHTTPSessionManagerTaskDidFailedNotification object:task];
        MSHTTPResponse *response = [MSHTTPResponse responseWithError:error];
        block(response, task, NO);
    }];
    
    return task;
}

@end
