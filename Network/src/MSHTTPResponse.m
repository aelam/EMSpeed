//
//  MSHTTPResponse.m
//  EMStock
//
//  Created by Ryan Wang on 4/13/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import "MSHTTPResponse.h"

@interface MSHTTPResponse() {
    
}
+ (NSDateFormatter *)updateTimeFormatter;
@end

@implementation MSHTTPResponse


+ (instancetype)responseWithObject:(id)object
{
    return [MSHTTPResponse responseWithResponse:object];
}


+ (instancetype)responseWithResponse:(NSDictionary *)responseObject {
    
    if (responseObject == nil) {
        return nil;
    }
    
    MSHTTPResponse *response = [[MSHTTPResponse alloc] init];
    response.originData = responseObject;
    
    if ([MSHTTPResponse isStandardResponse:responseObject]) {
        response.status = [responseObject[@"status"] integerValue];
        NSDateFormatter *formatter = [self updateTimeFormatter];
        response.updateTime = [formatter dateFromString:responseObject[@"updatetime"]];
        response.responseData = responseObject[@"data"];
        response.message = responseObject[@"message"];
    }
    
    return response;
}

+ (NSDateFormatter *)updateTimeFormatter {
    static NSDateFormatter *_dateFormatter = nil;
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return _dateFormatter;
}

+ (BOOL)isStandardResponse:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSDictionary class]]
        && responseObject[@"status"]
        && responseObject[@"updatetime"]
        && responseObject[@"data"])
    {
        return YES;
    }
    
    return NO;
}

@end




