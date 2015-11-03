//
//  NSDictionary+Query.m
//  EMStock
//
//  Created by Ryan Wang on 4/27/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import "NSDictionary+Query.h"
#import "NSString+URLEncoding.h"

@implementation NSDictionary (Query)

- (NSString *)ms_query {
    
    NSMutableArray *parts = [NSMutableArray array];
    for(NSString *key in self) {
        NSString *value = [NSString stringWithFormat:@"%@",self[key]];
        NSString *kv = [NSString stringWithFormat:@"%@=%@", [key URLEncodedString],[value URLEncodedString]];
        [parts addObject:kv];
    }

    return [parts componentsJoinedByString:@"&"];
}

@end
