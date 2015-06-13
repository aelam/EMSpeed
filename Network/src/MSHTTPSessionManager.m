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


@implementation MSHTTPSessionManager

+ (MSHTTPSessionManager *)manager
{
    static MSHTTPSessionManager *__MSHTTPSessionManager = nil;
    @synchronized(self)
    {
        if (__MSHTTPSessionManager == nil) {
            __MSHTTPSessionManager = [[[self class] alloc] initWithBaseURL:nil];
            __MSHTTPSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        }
    }
    return __MSHTTPSessionManager;
}


- (NSURLSessionDataTask *)GET:(NSString *)URLString
                        param:(NSDictionary *)param
                        block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block
{
    MSHTTPSessionManager *manager = [MSHTTPSessionManager manager];
    
    NSURLSessionDataTask *task = [manager GET:URLString parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        block(response, task, YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithError:error];
        block(response, task, NO);
    }];
    
    return task;
}


- (NSURLSessionDataTask *)POST:(NSString *)URLString
                         param:(NSDictionary *)param
                         block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block
{
    MSHTTPSessionManager *manager = [MSHTTPSessionManager manager];
    
    NSURLSessionDataTask *task = [manager POST:URLString parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        block(response, task, YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithError:error];
        block(response, task, NO);
    }];
    
    return task;
}

@end
