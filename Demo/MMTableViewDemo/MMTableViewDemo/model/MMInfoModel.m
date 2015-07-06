//
//  MMStockWebModel.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MMInfoModel.h"
#import "MMInfoCell.h"
#import "MMInfoCell2.h"
#import "MMInfoItem.h"
#import "MMInfoItem3.h"
#import "MSParseableObject+CellModel.h"
#import "MSHTTPResponse.h"

@implementation MMInfoModel
@synthesize dataSource = _dataSource;

- (NSURLSessionTask *)POST:(NSString *)URLString
                     param:(NSDictionary *)param
                     block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    return [super POST:URLString
                 param:param
                 block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
                     if (success) {
                         BOOL parseSuccess = [self parseHTTPResponse:response URL:URLString];
                         
                         block(response, task, success && parseSuccess);
                     }
                     else{
                         block(response, task, NO);
                     }
                 }];
}

- (BOOL)parseHTTPResponse:(MSHTTPResponse *)response
                      URL:(NSString *)URLString
{
    id responseObject = response.originData;
    
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSArray *array = [responseObject objectForKey:@"o"];
        
        if ([array count] == 0) {
            return NO;
        }
        
        Class cls = [MMInfoCellModel class];
        NSMutableArray *cellModels = [MMInfoItem cellModelsWithArray:array cellModelClass:cls];
                
        if ([cellModels count] > 0) {
            _dataSource = [[MSMutableDataSource alloc] init];
            [_dataSource addNewSection:@"" withItems:cellModels];
            
            return YES;
        }
    }
    
    return NO;
}


@end


@implementation MMInfoModel2

- (BOOL)parseHTTPResponse:(MSHTTPResponse *)response
                      URL:(NSString *)URLString
{
    if (response == nil) {
        return nil;
    }
    
    NSDictionary *responseObject = response.originData;
    
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSArray *array = [responseObject objectForKey:@"o"];
        
        if ([array count] == 0) {
            return NO;
        }
        
        Class cls = [MMInfoCellModel2 class];
        NSMutableArray *items = [MMInfoItem cellModelsWithArray:array cellModelClass:cls];
        
        if ([items count] > 0) {
            _dataSource = [[MSMutableDataSource alloc] init];
            [_dataSource addNewSection:@"" withItems:items];
            
            return YES;
        }
    }
    
    return NO;
}

@end


@implementation MMInfoModel3

- (BOOL)parseHTTPResponse:(MSHTTPResponse *)response
                      URL:(NSString *)URLString
{
    if (response == nil) {
        return nil;
    }
    
    NSDictionary *responseObject = response.originData;
    
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSArray *array = [responseObject objectForKey:@"o"];
        
        NSMutableArray *items = nil;
        
        if ([array count] > 0) {
            items = [MMInfoItem3 parseArray:array];
        }
        
        if ([items count] > 0) {
            _dataSource = [[MSMutableDataSource alloc] init];
            [_dataSource addNewSection:@"" withItems:items];
        }
        
        return YES;
    }
    
    return NO;
}

@end



