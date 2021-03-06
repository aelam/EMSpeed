//
//  NSDate+TimeAgo.h
//  EMStock
//
//  Created by Allen on 4/29/16.
//  Copyright © 2016 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TimeAgo)

//2016-12-22T05:47:14.X***X格式的字符串，分割成2016-12-22T05:47:14，在转成date
+ (NSDate *)ms_serverTDateFromString:(NSString *)string;

/**
 *  日期处理
 *  1小时以内，返回多少分钟前，
 *  1天以内，返回10:10
 *  其他返回：04-25 13:39格式
 *  @return NSString
 */
- (NSString *)ms_minuteTimeAgo;

/**
 *  日期处理
 *  1小时以内，返回多少分钟前，
 *  1天以内，返回多少小时前
 *  其他返回：04月25日 格式
 *  @return NSString
 */
- (NSString *)ms_hourTimeAgo;

@end
