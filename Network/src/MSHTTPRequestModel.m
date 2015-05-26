//
//  EMHTTPRequestModel.m
//  EMStock
//
//  Created by Mac mini 2012 on 14-9-19.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSHTTPRequestModel.h"
#import "MSHTTPResponse.h"

static AFHTTPRequestOperationManager *__EMHTTPRequestModelNetworkManager = nil;

@implementation MSHTTPRequestModel


+ (void)setNetworkManager:(AFHTTPRequestOperationManager *)networkManager
{
    if (networkManager && [networkManager isKindOfClass:[AFHTTPRequestOperationManager class]]) {
        __EMHTTPRequestModelNetworkManager = networkManager;
    }
}


+ (AFHTTPRequestOperationManager *)networkManager
{
    if (__EMHTTPRequestModelNetworkManager == nil) {
        __EMHTTPRequestModelNetworkManager = [AFHTTPRequestOperationManager manager];
    }
    
    return __EMHTTPRequestModelNetworkManager;
}


- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                          param:(NSDictionary *)param
                          block:(void (^)(MSHTTPResponse *response, AFHTTPRequestOperation *operation, BOOL success))block
{
    AFHTTPRequestOperationManager *manager = [[self class] networkManager];
    
    return [manager GET:URLString parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        BOOL flag = [self parseHTTPResponse:response URL:URLString];
        block(response, operation, flag);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MSHTTPResponse *response = [[MSHTTPResponse alloc] init];
        response.error = error;
        block(response, operation, NO);
    }];
}


- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                           param:(NSDictionary *)param
                           block:(void (^)(MSHTTPResponse *response, AFHTTPRequestOperation *operation, BOOL success))block
{
    AFHTTPRequestOperationManager *manager = [[self class] networkManager];
    
    return [manager POST:URLString parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
        BOOL flag = [self parseHTTPResponse:response URL:URLString];
        block(response, operation, flag);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MSHTTPResponse *response = [[MSHTTPResponse alloc] init];
        response.error = error;
        block(response, operation, NO);
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