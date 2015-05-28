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
    }
    
    return __MSHTTPSessionManager;
}


- (NSURLSessionDataTask *)GET:(NSString *)URLString
                        param:(NSDictionary *)param
                        block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block
{
    AFHTTPSessionManager *manager = [[self class] networkManager];
    
    return [manager GET:URLString parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        BOOL flag = [self parseHTTPResponse:response URL:URLString];
        block(response, task, flag);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MSHTTPResponse *response = [[MSHTTPResponse alloc] init];
        response.error = error;
        block(response, task, NO);
    }];
}


- (NSURLSessionDataTask *)POST:(NSString *)URLString
                         param:(NSDictionary *)param
                         block:(void (^)(MSHTTPResponse *response, AFHTTPRequestOperation *operation, BOOL success))block
{
    AFHTTPSessionManager *manager = [[self class] networkManager];
    
    return [manager POST:URLString parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        BOOL flag = [self parseHTTPResponse:response URL:URLString];
        block(response, task, flag);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MSHTTPResponse *response = [[MSHTTPResponse alloc] init];
        response.error = error;
        block(response, task, NO);
    }];
}


- (BOOL)parseHTTPResponse:(MSHTTPResponse *)response
                      URL:(NSString *)URLString
{
    // 解析 response.responseData
    
    NSAssert(0, @"子类请自己实现具体内容的解析!");
    return response;
}

@end