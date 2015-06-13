//
//  MSHTTPSessionManager.h
//  Pods
//
//  Created by Mac mini 2012 on 15/6/13.
//
//

#import "AFHTTPSessionManager.h"


@class MSHTTPResponse;

@interface MSHTTPSessionManager : AFHTTPSessionManager

+ (MSHTTPSessionManager *)manager;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                        param:(NSDictionary *)param
                        block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                         param:(NSDictionary *)param
                         block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block;

@end
