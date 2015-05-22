//
//  EMHTTPRequestModel.m
//  EMStock
//
//  Created by Mac mini 2012 on 14-9-19.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMHTTPRequestModel.h"
#import "EMHTTPResponse.h"

static AFHTTPRequestOperationManager *__EMHTTPRequestModelNetworkManager = nil;

@implementation EMHTTPRequestModel


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
                          block:(void (^)(EMHTTPResponse *response, AFHTTPRequestOperation *operation, BOOL success))block
{
    AFHTTPRequestOperationManager *manager = [[self class] networkManager];
    
    return [manager GET:URLString parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        EMHTTPResponse *response = [EMHTTPResponse responseWithObject:responseObject];
        BOOL flag = [self parseHTTPResponse:response URL:URLString];
        block(response, operation, flag);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        EMHTTPResponse *response = [[EMHTTPResponse alloc] init];
        response.error = error;
        block(response, operation, NO);
    }];
}


- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                           param:(NSDictionary *)param
                           block:(void (^)(EMHTTPResponse *response, AFHTTPRequestOperation *operation, BOOL success))block
{
    AFHTTPRequestOperationManager *manager = [[self class] networkManager];
    
    return [manager POST:URLString parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        EMHTTPResponse *response = [EMHTTPResponse responseWithObject:responseObject];
        BOOL flag = [self parseHTTPResponse:response URL:URLString];
        block(response, operation, flag);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        EMHTTPResponse *response = [[EMHTTPResponse alloc] init];
        response.error = error;
        block(response, operation, NO);
    }];
}


- (BOOL)parseHTTPResponse:(EMHTTPResponse *)response
                      URL:(NSString *)URLString
{
    // 解析 response.responseData
    
    NSAssert(0, @"子类请自己实现具体内容的解析!");
    return response;
}

@end