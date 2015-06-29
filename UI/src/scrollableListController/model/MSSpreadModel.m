//
//  EMSpread.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSSpreadModel.h"
#import "MSSpreadTableTitleHeaderView.h"
#import "MSSpreadTableContentHeaderView.h"
#import "MSCellModel.h"
#import "MSContext.h"
#import "MSCoreMetrics.h"

#define kDefaultCellHeight 44
#define kDefaultHeaderHeight 30

@interface MSSpreadModel() {
    NSURLSessionTask *_task;
}

@end


@implementation MSSpreadModel
@synthesize titleWidth;
@synthesize contentWidth;
@synthesize titleHeaderItem;
@synthesize contentHeaderItem;
@synthesize titleDataSource;
@synthesize contentDataSource;


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadDefaultSetting];
    }
    
    return self;
}

- (void)loadDefaultSetting
{
    // subclass overwrite
}

- (float)cellHeightAtIndexPath:(NSIndexPath *)indexPath
{
    id<MSCellModel> item = [self.titleDataSource itemAtIndex:indexPath.row];
    if (item.height > 0) {
        return item.height;
    }
    
    return kDefaultCellHeight;
}

- (float)headerHeight
{
    id<MSCellModel> item = self.titleHeaderItem;
    if (item && item.height > 0) {
        return item.height;
    }
    
    return kDefaultHeaderHeight;
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.titleDataSource numberOfItemsAtSection:section];
}

- (NSArray *)visiableItems
{
    return nil;
}

//获取列表
- (void)getFirstPage:(void (^)(MSHTTPResponse *response, BOOL success))block
{
    if (_task) {
        [_task cancel];
        [_tasks removeObject:_task];
    }
    
    NSDictionary *parameters = [self parameters];
    
    _task = [self GET:self.URL
                param:parameters
                block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
        BOOL flag = NO;
        if (success) {
            flag = [self parseFirstPageResponse:response];
        }
        block(response, success && flag);
        [_tasks removeObject:task];
    }];
    
    [_tasks addObject:_task];
}

//翻页
- (void)getNextPage:(void (^)(MSHTTPResponse *response, BOOL success))block
{
    if (_task) {
        [_task cancel];
        [_tasks removeObject:_task];
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self nextPageParameters]];
    if (self.lastId)
    {
        [parameters setObject:self.lastId forKey:@"lastid"];
    }
    NSString *URL = self.nextURL ? self.nextURL : self.URL;
    
    if (_task) {
        [_task cancel];
        [_tasks removeObject:_task];
    }
    
    _task = [self GET:URL param:parameters block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
        BOOL flag = NO;
        if (success) {
            flag = [self parseNextPageResponse:response];
        }
        block(response, success && flag);
        [_tasks removeObject:task];
    }];
    
    [_tasks addObject:_task];
}

//新增
- (void)getRefresh:(void (^)(MSHTTPResponse *response, BOOL success))block
{
    if (self.topId && self.topId.length) {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self parameters]];
        [parameters setObject:self.topId forKey:@"topid"];
        
        if (_task) {
            [_task cancel];
            [_tasks removeObject:_task];
        }
        
        _task = [self GET:self.URL param:parameters block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
            BOOL flag = NO;
            if (success) {
                flag = [self parseRefreshResponse:response];
            }
            block(response, success && flag);
            [_tasks removeObject:task];
        }];
        
        [_tasks addObject:_task];
    }
    else{
        [self getFirstPage:block];
    }
}


- (BOOL)parseFirstPageResponse:(MSHTTPResponse *)response
{
    return NO;
}

- (BOOL)parseRefreshResponse:(MSHTTPResponse *)response
{
    return NO;
}

- (BOOL)parseNextPageResponse:(MSHTTPResponse *)response
{
    return NO;
}

- (BOOL)isEmpty
{
   return (self.titleDataSource == nil && self.contentDataSource == nil) || ([self.titleDataSource isEmpty] && [self.contentDataSource isEmpty]);
}

- (NSDictionary *)parameters
{
    return [NSDictionary dictionary];
}


- (NSDictionary *)nextPageParameters
{
    return [self parameters];
}

@end
