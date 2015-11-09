//
//  NSDateFormatter+EMCommon.m
//  EMStock
//
//  Created by Ryan Wang on 4/25/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import "NSDateFormatter+EMCommon.h"

@implementation NSDateFormatter (EMCommon)

+ (instancetype)ms_serverDateFormatter { // "2015-06-29T17:12:46.9409259+08:00"
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        //        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        NSTimeZone *timezone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
        fmt.timeZone = timezone;
        fmt.dateFormat = @"yyyy-MM-ddTHH:mm:ss.SSSSSSSZ";
    });
    return fmt;
}

+ (instancetype)ms_longDateFormatter {
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
//        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        NSTimeZone *timezone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
        fmt.timeZone = timezone;
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return fmt;
}

+ (instancetype)ms_shortDateFormatter {
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        //[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
        fmt.timeZone = timezone;
        fmt.dateFormat = @"yyyy-MM-dd";
    });
    return fmt;
}

+ (instancetype)ms_timeFormatter {
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        //[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
        fmt.timeZone = timezone;
        fmt.dateFormat = @"HH:mm:ss";
    });
    return fmt;
}


@end
