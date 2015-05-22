//
//  EMHTTPResponse.h
//  EMStock
//
//  Created by Ryan Wang on 4/13/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMHTTPResponse : NSObject {
    
}

@property (nonatomic, strong) id originData; // 原始数据
@property (nonatomic, strong) id responseData; // 标准JSON返回格式中的data数据, 非标准格式中为nil
@property (nonatomic, assign) NSInteger status; // 状态码, 0为正常
@property (nonatomic, strong) NSDate *updateTime; // 更新时间
@property (nonatomic, strong) NSString *message; // 消息, 一般为错误消息
@property (nonatomic, strong) NSError *error;


/**
 *  创建HTTP响应对象
 *
 *  @param object JSON数据, 格式可能是数组或字典
 *
 *  @return 
 */
+ (instancetype)responseWithObject:(id)object;


/**
 *  是否是标准的JSON返回格式, 包含status, updatetime, data
 *
 *  @param responseObject JSON数据
 *
 *  @return 是否
 */
+ (BOOL)isEMStandardResponse:(id)responseObject;

@end
