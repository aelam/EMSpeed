//
//  NSDate+Formatter.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-7.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 常用的一些转换类型
 */
typedef NS_ENUM(NSUInteger, EMDateFormatterStyle) {
    EMDateFormatterStyleDefault,    // MM月dd日 HH:mm
    EMDateFormatterStyleDay,        // MM月dd日
    EMDateFormatterStyleTime,       // HH:mm
    EMDateFormatterStyleYear,       // YYYY年MM月dd日
    EMDateFormatterStyleFull,       // YYYY年MM月dd日 HH:mm
};

@interface NSDate (Formatter)

+ (NSDateFormatter *)dateFormatterWithStyle:(EMDateFormatterStyle)style;

+ (NSDateFormatter *)fullFormatterSlash;
@end
