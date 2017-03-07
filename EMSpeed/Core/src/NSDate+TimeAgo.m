//
//  NSDate+TimeAgo.m
//  EMStock
//
//  Created by Allen on 4/29/16.
//  Copyright © 2016 flora. All rights reserved.
//

#import "NSDate+TimeAgo.h"
#import "NSDateFormatter+MS.h"

@implementation NSDate (TimeAgo)

+ (NSDate *)ms_serverTDateFromString:(NSString *)string {
    if (!string) {
        return nil;
    }
    
    NSArray *components = [string componentsSeparatedByString:@"."];
    if (!components) {
        return [[NSDateFormatter ms_serverDateFormatter_T] dateFromString:string];
    }
    
    if (components.count > 0) {
        return [[NSDateFormatter ms_serverDateFormatter_T] dateFromString:[components firstObject]];
    }
}


- (NSString *)ms_minuteTimeAgo
{
    
    NSDateComponents *components = [self components];
    NSString *result;
    
    if (components.day >= 1) {
        result = [[NSDateFormatter ms_shortDateTimeFormatter] stringFromDate:self];
    }
    
    else if(components.hour >= 1){
        result = [[NSDateFormatter ms_hourMinuteFormatter] stringFromDate:self];
    }
    
    else if(components.minute >= 1){
        result = [NSString stringWithFormat:@"%zd分钟前",components.minute];
    } else {
        result = @"1分钟前";
    }
    return  result;
}

- (NSString *)ms_hourTimeAgo {
    NSDateComponents *components = [self components];
    NSString *result;
    
    if (components.day >= 1) {
        result = [[NSDateFormatter em_zhMonthDayFormatter] stringFromDate:self];
    }
    
    else if(components.hour >= 1){
        result = [NSString stringWithFormat:@"%zd小时前",components.hour];
    }
    
    else if(components.minute >= 1){
        result = [NSString stringWithFormat:@"%zd分钟前",components.minute];
    } else {
        result = @"1分钟前";
    }
    return  result;
}

//- (NSString *)formatString:

- (NSDateComponents *)components {
    //把字符串转为NSdate
    //    NSDate *timeDate = [[NSDateFormatter ms_longDateFormatter] dateFromString:str];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate * now = [NSDate date];
    NSDateComponents *components = [calendar components:
                                    NSCalendarUnitDay|
                                    NSCalendarUnitHour|
                                    NSCalendarUnitMinute|
                                    NSCalendarUnitSecond
                                               fromDate:self
                                                 toDate:now
                                                options:0];
    return components;
}


@end
