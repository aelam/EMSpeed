//
//  MSHTTPSessionManager.h
//  Pods
//
//  Created by Mac mini 2012 on 15/6/13.
//
//

#import "AFHTTPSessionManager.h"
#import "MSHTTPResponse.h"

@class MSHTTPResponse;

@interface MSHTTPSessionManager : AFHTTPSessionManager

+ (MSHTTPSessionManager *)sharedManager;

- (NSURLSessionTask *)GET:(NSString *)URLString
                        param:(NSDictionary *)param
                        block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;

- (NSURLSessionTask *)POST:(NSString *)URLString
                         param:(NSDictionary *)param
                         block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;

@end
