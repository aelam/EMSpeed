//
//  EMHTTPRequestModel.m
//  EMStock
//
//  Created by Mac mini 2012 on 14-9-19.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSHTTPRequestModel.h"
#import "MSHTTPResponse.h"

static AFHTTPSessionManager *__MSHTTPSessionManager = nil;

@implementation MSHTTPRequestModel
@synthesize tasks = _tasks;

+ (void)setNetworkManager:(AFHTTPSessionManager *)networkManager
{
    if (networkManager && [networkManager isKindOfClass:[AFHTTPRequestOperationManager class]]) {
        __MSHTTPSessionManager = networkManager;
    }
}


+ (AFHTTPSessionManager *)networkManager
{
    if (__MSHTTPSessionManager == nil) {
        __MSHTTPSessionManager = [AFHTTPSessionManager manager];
        __MSHTTPSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    }
    
    return __MSHTTPSessionManager;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)dealloc
{
    [self cancelTasks];
}

- (void)cancelTasks
{
    for (NSURLSessionDataTask *task in _tasks) {
        [task cancel];
    }
    
    [_tasks removeAllObjects];
}

- (NSMutableArray *)getTasks
{
    if (_tasks == nil) {
        _tasks = [NSMutableArray array];
    }
    
    return _tasks;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                        param:(NSDictionary *)param
                        block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block
{
    AFHTTPSessionManager *manager = [[self class] networkManager];
    
    NSURLSessionDataTask *task = [manager GET:URLString parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        block(response, task, YES);
        [self.tasks removeObject:task];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithError:error];
        block(response, task, NO);
        [self.tasks removeObject:task];
    }];
    
    [self.tasks addObject:task];

    return task;
}


- (NSURLSessionDataTask *)POST:(NSString *)URLString
                         param:(NSDictionary *)param
                         block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block
{
    AFHTTPSessionManager *manager = [[self class] networkManager];
    
    NSURLSessionDataTask *task = [manager POST:URLString parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        block(response, task, YES);
        [self.tasks removeObject:task];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithError:error];
        block(response, task, NO);
        [self.tasks removeObject:task];
    }];
    
    [self.tasks addObject:task];
    
    return task;
}

@end