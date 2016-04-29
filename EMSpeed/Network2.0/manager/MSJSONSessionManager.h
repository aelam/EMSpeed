//
//  MSJSONSessionManager.h
//  Pods
//
//  Created by flora on 16/4/27.
//
//

#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModelError.h>
#import "MSHTTPSessionDebugHandler.h"

typedef void (^MSJSONObjectBlock)(__nullable id json, JSONModelError* _Nullable  err);

@interface MSJSONSessionManager : AFHTTPSessionManager

@property (nonatomic, strong) __nullable id <MSHTTPSessionDebugHandler> debugHandler;

+ (nonnull instancetype)sharedManager;

- (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)URLString
                            parameters:(nullable id)parameters
                          headerFields:(nullable id)headerFields
                            completion:(nullable MSJSONObjectBlock)completeBlock;

- (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)URLString
                             parameters:(nullable id)parameters
                           headerFields:(nullable id)headerFields
                             completion:(nullable MSJSONObjectBlock)completeBlock;


@end
