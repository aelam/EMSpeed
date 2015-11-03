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


extern NSString * const MSHTTPSessionManagerTaskDidFailedNotification;


@interface MSHTTPSessionManager : AFHTTPSessionManager

+ (MSHTTPSessionManager *)sharedManager;

@property (nonatomic, strong) NSDictionary *defaultHeaders;   // 附加授权信息
@property (nonatomic, strong) NSDictionary *defaultParameters;// 附加授权信息


- (NSURLSessionTask *)GET:(NSString *)URLString
                    param:(NSDictionary *)param
                    block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;

- (NSURLSessionTask *)POST:(NSString *)URLString
                     param:(NSDictionary *)param
                     block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;


- (NSURLSessionTask *)method:(NSString *)method
                   URLString:(NSString *)URLString
                  parameters:(NSDictionary *)parameters
                headerFields:(NSDictionary *)headerFields
                     success:(void (^)(NSURLSessionTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionTask *task, NSError *error))failure;


@end
