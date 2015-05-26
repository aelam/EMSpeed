//
//  NSObject+NSDate_description.m
//  EMStock
//
//  Created by flora deng on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDate+String.h"

static NSDateFormatter *g_currentDateFormatter = nil;

@implementation NSDate(String)


- (NSString*)ms_dateString
{
    return [self ms_dateStringWithStyle:EMDateFormatterStyleDefault];
}


+ (NSDate *)ms_dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormatter = [NSDate dateFormatterWithStyle:EMDateFormatterStyleFull];
    return [dateFormatter dateFromString:string];
}


- (NSString *)ms_dateStringWithStyle:(EMDateFormatterStyle)style
{
    NSDateFormatter *dateFormatter = [NSDate dateFormatterWithStyle:style];
    return [dateFormatter stringFromDate:self];
}

+ (NSDate *)ms_dateWithString:(NSString *)string
                        style:(EMDateFormatterStyle)style
{
    NSDateFormatter *dateFormatter = [NSDate dateFormatterWithStyle:style];
    return [dateFormatter dateFromString:string];
}


- (NSString *)ms_dateStringWithFormatter:(NSString *)formate
                                amSymbol:(NSString *)amSymbol
                                pmSymbol:(NSString *)pmSymbol
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:formate];
    [format setAMSymbol:amSymbol];
    [format setPMSymbol:pmSymbol];
    
    return [format stringFromDate:self];
}

@end



