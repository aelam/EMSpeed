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
 *  HTTP请求的Model, 具有收发包功能
 */
@interface MSHTTPRequestModel : NSObject {
    NSMutableArray *_tasks;
}

@property (nonatomic, strong, getter=getTasks) NSMutableArray *tasks;

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
      block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block;

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
       block:(void (^)(MSHTTPResponse *response, NSURLSessionDataTask *task, BOOL success))block;



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
