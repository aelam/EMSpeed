//
//  EMSpread.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSSpreadModel.h"
#import "MSNameListItem.h"
#import "MSContentListItem.h"
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
    // default test data
    int numberOfItems = 15;
    NSMutableArray *items = [NSMutableArray array];
    for (int i=0; i<numberOfItems; i++) {
        MSNameListItem *item = [[MSNameListItem alloc] init];
        [items addObject:item];
    }
    self.titleDataSource = [[MSMutableDataSource alloc] initWithItems:@[items] sections:@[@""]];
    
    
    items = [NSMutableArray array];
    for (int i=0; i<numberOfItems; i++) {
        MSContentListItem *item = [[MSContentListItem alloc] init];
        [items addObject:item];
    }
    
    self.contentDataSource = [[MSMutableDataSource alloc] initWithItems:@[items] sections:@[@""]];
    
    self.titleHeaderItem = [[MSSpreadTableTitleHeaderItem alloc] init];
    self.contentHeaderItem = [[MSSpreadTableContentHeaderItem alloc] init];
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
    
    item = self.contentHeaderItem;
    if (item && item.height > 0) {
        return item.height;
    }
    
    return kDefaultHeaderHeight;
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.titleDataSource numberOfItemsAtSection:section];
}

- (id<MSCellModel>)titleItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.titleDataSource itemAtIndexPath:indexPath];
}

- (id<MSCellModel>)contentItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.contentDataSource itemAtIndexPath:indexPath];
}

- (NSArray *)visiableItems
{
    return nil;
}


//获取列表
- (void)getFirstPage:(void (^)(MSHTTPResponse *response, BOOL success))block
{
    NSString *URL = self.URL;
    
    if (_task) {
        [_tasks removeObject:_task];
        [_task cancel];
        _task = nil;
    }
    
    _task = [self GET:URL param:nil block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
        BOOL flag = NO;
        if (success) {
            flag = [self parseHTTPResponse:response URL:URL requestType:MSSpreadModelRequestFirstPage];
        }
        block(response, success && flag);
        [_tasks removeObject:task];
    }];
    
    [_tasks addObject:_task];
}

//翻页
- (void)getNextPage:(void (^)(MSHTTPResponse *response, BOOL success))block
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.hasNextPage) {
        if (self.lastId) {
            params[@"lastid"] = self.lastId;
        }else{
            block(nil, NO);
            return;
        }
    }
    else{
        block(nil, NO);
        return;
    }
    
    NSString *URL = self.nextURL ? self.nextURL : self.URL;
    
    if (_task) {
        [_tasks removeObject:_task];
        [_task cancel];
        _task = nil;
    }
    
    _task = [self GET:URL param:params block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
        self.hasNextPage = NO;
        BOOL flag = NO;
        if (success) {
            flag = [self parseHTTPResponse:response URL:URL requestType:MSSpreadModelRequestNextPage];
        }
        block(response, success && flag);
        [_tasks removeObject:task];
    }];
    
    [_tasks addObject:_task];
}

//新增
- (void)getRefresh:(void (^)(MSHTTPResponse *response, BOOL success))block
{
    if (self.topId) {
        NSString *URL = self.URL;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        if (self.topId) {
            params[@"topId"] = self.topId;
        }
        
        if (_task) {
            [_tasks removeObject:_task];
            [_task cancel];
            _task = nil;
        }
        
        _task = [self GET:URL param:params block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
            BOOL flag = NO;
            if (success) {
                flag = [self parseHTTPResponse:response URL:URL requestType:MSSpreadModelRequestRefresh];
            }
            block(response, success && flag);
            [_tasks removeObject:task];
        }];
        
        [_tasks addObject:_task];
    }
    else{
        block(nil, NO);
    }
}


- (BOOL)parseHTTPResponse:(MSHTTPResponse *)response
                      URL:(NSString *)URLString
              requestType:(MSSpreadModelRequestType)type
{
    return NO;
}

- (BOOL)isEmpty
{
   return (self.titleDataSource == nil && self.contentDataSource == nil) || ([self.titleDataSource isEmpty] && [self.contentDataSource isEmpty]);
}



@end
