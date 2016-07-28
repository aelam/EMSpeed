//
//  MSJSONSessionManager.h
//  Pods
//
//  Created by flora on 16/4/27.
//
//

#import <AFNetworking/AFNetworking.h>
#import "MSHTTPSessionDebugHandler.h"
#import <JSONModel/JSONModel.h>

/**
 *  json解析为数据对象后的回调
 *
 *  @param jsonModel 数据对象，
 *  @param err       错误信息
 */
typedef void (^MSJSONModelBlock)(__nullable id jsonModel, JSONModelError* _Nullable  err);

typedef void (^MSJSONObjectBlock)(__nullable id json, JSONModelError* _Nullable  err);

@interface MSJSONSessionManager : AFHTTPSessionManager

@property (nonatomic, strong) __nullable id <MSHTTPSessionDebugHandler> debugHandler;
@property (nonatomic, strong) NSDictionary *defaultHeaders;   // 附加授权信息

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

@interface MSJSONSessionManager(JSONModel)

- (nullable NSURLSessionDataTask *)JM_GET:(nonnull NSString *)URLString
                               parameters:(nullable id)parameters
                             headerFields:(nullable id)headerFields
                           JSONModelClass:(nonnull Class)jsonModelClass
                               completion:(nullable MSJSONModelBlock)completeBlock;

- (nullable NSURLSessionDataTask *)JM_POST:(nonnull NSString *)URLString
                                parameters:(nullable id)parameters
                              headerFields:(nullable id)headerFields
                            JSONModelClass:(nonnull Class)jsonModelClass
                                completion:(nullable MSJSONModelBlock)completeBlock;

@end
