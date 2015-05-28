//
//  NSDate+Formatter.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-7.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)


+ (NSDateFormatter *)ms_dateFormatterWithStyle:(EMDateFormatterStyle)style
{
    NSDateFormatter *dateFormatter = nil;
    
    switch (style) {
        case EMDateFormatterStyleDefault:
            dateFormatter = [NSDate defaultFormatter];
            break;
        case EMDateFormatterStyleDay:
            dateFormatter = [NSDate dayFormatter];
            break;
        case EMDateFormatterStyleTime:
            dateFormatter = [NSDate timeFormatter];
            break;
        case EMDateFormatterStyleYear:
            dateFormatter = [NSDate yearFormatter];
            break;
        case EMDateFormatterStyleFull:
            dateFormatter = [NSDate fullFormatter];
            break;
        case EMDateFormatterStyleFullSlash:
            dateFormatter = [NSDate fullFormatterSlash];
            break;
    }
    
    return dateFormatter;
}


+ (NSDateFormatter *)defaultFormatter
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"defaultFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
                threadDictionary[@"defaultFormatter"] = dateFormatter;
            }
        }
    }
    
    return dateFormatter;
}


+ (NSDateFormatter *)dayFormatter
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"defaultDayFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM月dd日"];
                threadDictionary[@"defaultDayFormatter"] = dateFormatter;
            }
        }
    }
    
    return dateFormatter;
}


+ (NSDateFormatter *)timeFormatter
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"defaultTimeFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm"];
                threadDictionary[@"defaultTimeFormatter"] = dateFormatter;
            }
        }
    }
    
    return dateFormatter;
}

+ (NSDateFormatter *)yearFormatter
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"defaultYearFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                threadDictionary[@"defaultYearFormatter"] = dateFormatter;
            }
        }
    }
    
    return dateFormatter;
}

+ (NSDateFormatter *)fullFormatter
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"defaultFullFormatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                threadDictionary[@"defaultFullFormatter"] = dateFormatter;
            }
        }
    }
    
    return dateFormatter;
}


+ (NSDateFormatter *)fullFormatterSlash
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"defaultFullFormatterSlash"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
                threadDictionary[@"defaultFullFormatterSlash"] = dateFormatter;
            }
        }
    }
    
    return dateFormatter;
}

@end
