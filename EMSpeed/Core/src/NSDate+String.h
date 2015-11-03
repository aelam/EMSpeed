//
//  NSObject+NSDate_description.h
//  EMStock
//
//  Created by flora deng on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Formatter.h"

/**
 *  日期和字符串 互相转化
 */
@interface NSDate (String)


/**
 *  date转字符串  MM月dd日 HH:mm
 *
 *  @return 返回字符串
 */
- (NSString *)ms_dateString;


/**
 *  date转字符串  MM月dd日 HH:mm
 *
 *  @return 返回字符串
 */
+ (NSString *)ms_dateString;

/**
 *  字符串转date  MM月dd日 HH:mm
 *
 *  @param string 字符串
 *
 *  @return 返回日期
 */
+ (NSDate *)ms_dateFromString:(NSString *)string;


/**
 *  字符串转date, 根据常用的style
 *
 *  @param dateStyle 日期格式类型
 *
 *  @return 字符串
 */
- (NSString *)ms_dateStringWithStyle:(EMDateFormatterStyle)style;


/**
 *  string转date, 根据常用的style
 *
 *  @param string   字符串
 *  @param dateStyle 日期格式类型
 *
 *  @return 日期
 */
+ (NSDate *)ms_dateWithString:(NSString *)string
                        style:(EMDateFormatterStyle)style;


/**
 *  字符串转date, 自定义, 效率略低些
 *
 *  @param formate  字符串
 *  @param amSymbol 上午格式
 *  @param pmSymbol 下午格式
 *
 *  @return 字符串
 */
- (NSString *)ms_dateStringWithFormatter:(NSString *)formate
                                amSymbol:(NSString *)amSymbol
                                pmSymbol:(NSString *)pmSymbol;


+ (NSDate *)ms_dateFromStringSlash:(NSString *)string;

@end




