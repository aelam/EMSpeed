//
//  NSDateFormatter+EMCommon.m
//  EMSpeed
//
//  Created by Ryan Wang on 4/25/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import "NSDateFormatter+MS.h"

@implementation NSDateFormatter (MS)

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

+ (instancetype)ms_shortDateTimeFormatter { // "04-25 13:39"
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        //[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
        fmt.timeZone = timezone;
        fmt.dateFormat = @"MM-dd HH:mm";
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

+ (instancetype)ms_hourMinuteFormatter{ // "13:39"
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        //[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
        fmt.timeZone = timezone;
        fmt.dateFormat = @"HH:mm";
    });
    return fmt;
}

+ (instancetype)ms_monthDayFormatter{ // "13:39"
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        //[NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
        fmt.timeZone = timezone;
        fmt.dateFormat = @"MM-dd";
    });
    return fmt;
}

//yyyy/MM/dd HH:mm:ssm
+ (instancetype)em_longSlashDateFormatter{ // "13:39"
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        fmt.timeZone = timezone;
        fmt.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    });
    return fmt;
}


+ (instancetype)em_zhMonthDayFormatter
{
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        fmt.timeZone = timezone;
        fmt.dateFormat = @"MM月dd日";
    });
    return fmt;
}

+ (instancetype)em_shortPointDateFormatter
{
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSTimeZone *timezone = [NSTimeZone localTimeZone];
        fmt.timeZone = timezone;
        fmt.dateFormat = @"yyyy.MM.dd";
    });
    return fmt;
}

+ (instancetype)ms_serverDateFormatter_T {
    // "2015-06-29T17:12:46"
    static NSDateFormatter* fmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc] init];
        NSTimeZone *timezone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
        fmt.timeZone = timezone;
        fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    });
    return fmt;
}

@end
