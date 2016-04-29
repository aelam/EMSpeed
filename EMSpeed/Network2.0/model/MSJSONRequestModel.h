//
//  MSJSONRequestModel.h
//  Pods
//
//  Created by flora on 16/4/27.
//
//MSJSONRequestModel For module 推荐用来管理某一系列相关的数据操作。（例如自选股更新、自选股添加、删除）
//MSJSONRequestModel For controller 推荐用来负责页面相关的数据请求，管理页面相关的数据请求

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "MSJSONSessionManager.h"

/**
 *  json解析为数据对象后的回调
 *
 *  @param jsonModel 数据对象，
 *  @param err       错误信息
 */
typedef void (^MSJSONModelBlock)( id jsonModel, JSONModelError*  err);

@interface MSJSONRequestModel : NSObject

- (NSURLSessionDataTask *)GET:( NSString *)URLString
                   parameters:(id)parameters
                 headerFields:(id)headerFields
                   completion:(MSJSONObjectBlock)completeBlock;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                  headerFields:(id)headerFields
                    completion:(MSJSONObjectBlock)completeBlock;

#pragma mark -
#pragma mark task

@property (nonatomic, strong, readonly, getter=getTasks) NSMutableArray *tasks;

/**
 * 取消请求任务
 */
- (void)cancelTasks;

#pragma mark -
#pragma mark cache

/**
 *  获取url对应的缓存数据
 *
 *  @param URLString 数据请求
 *
 *  @return
 */
+ (id)cacheObjectForURLString:(NSString *)URLString;

/**
 *  存储json 到本地
 *
 *  @param json      数据
 *  @param URLString 地址
 *  @param disk      是否存储到本地，YES：存储到本地。 NO：存储到内存中
 */
+ (void)setCacheObject:(id)json forURLString:(NSString *)URLString disk:(BOOL)disk;

@end
