//
//  NSDateFormatter+EMCommon.h
//  EMStock
//
//  Created by Ryan Wang on 4/25/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  NSDateFormatter (EMCommon)

+ (instancetype)ms_serverDateFormatter; // "2015-06-29T17:12:46.9409259+08:00"

+ (instancetype)ms_longDateFormatter; // "2015-04-25 13:39:09"

+ (instancetype)ms_shortDateFormatter; // "2015-04-25"

+ (instancetype)ms_timeFormatter; // "13:39:09"

@end
