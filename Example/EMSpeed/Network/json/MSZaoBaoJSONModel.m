//
//  MSZaoBaoJSONModel.m
//  EMSpeed
//
//  Created by flora on 16/11/18.
//  Copyright © 2016年 Ryan Wang. All rights reserved.
//

#import "MSZaoBaoJSONModel.h"

@implementation MSZaoBaoJSONModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:
            @{
              @"data":@"data.body",
              }];
}
@end

@implementation MSZaoBaoItem
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end
