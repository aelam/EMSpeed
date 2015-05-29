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
    if (networkManager && [networkManager isKindOfClass:[AFHTTPSessionManager class]]) {
        __MSHTTPSessionManager = networkManager;
    }
}

+ (AFHTTPSessionManager *)networkManager
{
    if (__MSHTTPSessionManager == nil) {
        __MSHTTPSessionManager = [AFHTTPSessionManager manager];
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
}

- (NSMutableArray *)getTasks
{
    if (_tasks == nil) {
        _tasks = [NSMutableArray array];
    }
    
    return _tasks;
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
      block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block
{
    AFHTTPSessionManager *manager = [[self class] networkManager];
    
    NSURLSessionDataTask *task = [manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        block(response, task, YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithError:error];
        block(response, task, NO);
    }];
    
    [self.tasks addObject:task];
}


- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
       block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *operation, BOOL success))block
{
    AFHTTPSessionManager *manager = [[self class] networkManager];
    
    NSURLSessionDataTask *task = [manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        block(response, task, YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithError:error];
        block(response, task, NO);
    }];
    
    [self.tasks addObject:task];
}

@end