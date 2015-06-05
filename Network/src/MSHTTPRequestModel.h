//
//  EMStockWebModel.h
//  EMStock
//
//  Created by Mac mini 2012 on 14-9-19.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "AFNetworking.h"

@class MSHTTPResponse;

/**
 *  HTTP请求的Model, 具有收发包功能,
 */
@interface MSHTTPRequestModel : NSObject {
    NSMutableArray *_tasks;
}

@property (nonatomic, strong, getter=getTasks) NSMutableArray *tasks;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                        param:(NSDictionary *)param
                        block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                         param:(NSDictionary *)param
                         block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block;

/**
 *  解析HTTP请求返回的对象, 如果是标准格式下, 子类只需要实现这个方法就可以了, 所有数据已保存在EMHTTResponse的responseData或originData中
 *
 *  @param response  经过解析的EMHTTResponse对象
 *  @param URLString HTTP请求的URL
 *
 *  @return 是否解析成功
 */
- (BOOL)parseHTTPResponse:(MSHTTPResponse *)response
                      URL:(NSString *)URLString;


/**
 *  设置网络管理的类, 默认是 AFHTTPSessionManager, 也可支持AFHTTPSessionManager的子类, 例如EMNetworkManager
 *
 *  @param networkManagerClass 网络管理的类
 */
+ (void)setNetworkManager:(AFHTTPRequestOperationManager *)manager;

/**
 *  当前使用的网络管理的类
 *
 *  @return 当前使用的网络管理的类, AFHTTPSessionManager或者它的子类
 */
+ (AFHTTPSessionManager *)networkManager;

/**
 *  取消请求任务
 */
- (void)cancelTasks;

@end
