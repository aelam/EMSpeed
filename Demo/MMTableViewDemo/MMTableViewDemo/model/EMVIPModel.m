//
//  EMInfoNewsModel.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "EMVIPModel.h"
#import "MSMutableDataSource.h"
#import "EMInfoNewsItem.h"

static NSString *kVIPNewsTitle = @"VIP资讯";
static NSString *kInfoNewsPullRefreshKey = @"refresh";
static NSString *kInfoNewsNextPageURLKey = @"more";


NSString *InfoNewsIDStringWithObject(id obj);

@implementation EMVIPModel

- (id)initWithTitle:(NSString *)title
                 Id:(int)Id
                URL:(NSString *)URL
{
    self = [super init];
    if (self) {
        self.title = title;
        self.Id = Id;
        self.URL = URL;
    }
    
    return self;
}

- (NSURLSessionDataTask *)modelWithURL:(NSString *)URL block:(void (^)(id, NSURLSessionDataTask *, BOOL))block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    return [manager POST:URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        BOOL flag = [self parseURLResponse:responseObject URL:URL];
        block(responseObject, task, flag);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, task, NO);
    }];
}

- (NSMutableArray *)originItems
{
    NSMutableArray *existItems = nil;
    
    MSMutableDataSource *ds = (MSMutableDataSource *)self.dataSource;
    if ([ds itemsAtSectionWithTitle:kVIPNewsTitle]) {
        NSArray *items = [ds itemsAtSectionWithTitle:kVIPNewsTitle];
        existItems = [NSMutableArray arrayWithArray:items];
    }
    
    if (existItems==nil) {
        existItems = [NSMutableArray array];
    }
    
    return existItems;
}

- (NSMutableArray *)appendItemsWithOriginItems:(NSMutableArray *)originItems
                       response:(NSDictionary *)dictionary
                            URL:(NSString *)URL
{
    NSArray *newsInfos = [dictionary objectForKey:@"news"];
    
    if ([newsInfos count] <= 0) {
        return originItems;
    }
    
    if (originItems == nil) {
        originItems = [NSMutableArray array];
    }
    
    NSMutableArray *results = [NSMutableArray arrayWithArray:originItems];
    BOOL isPullRefresh = [URL rangeOfString:@"topid"].location != NSNotFound;
    NSArray *newsItems = [EMInfoNewsItem parseArray:newsInfos];
    
    if (isPullRefresh) {
        // 刷新的插入方式是反的
        NSEnumerator *enumerator = [newsItems reverseObjectEnumerator];
        newsItems = [NSMutableArray arrayWithArray:[enumerator allObjects]];
    }
    
    [results addObjectsFromArray:newsItems];
    
    return results;
}

- (NSString *)nextPageURLWithDictionary:(NSDictionary *)dictionary
                                    URL:(NSString *)URL
                      originNextPageURL:(NSString *)nextPageURL
{
    NSString *moreID = InfoNewsIDStringWithObject([dictionary objectForKey:kInfoNewsNextPageURLKey]);
    if ([moreID length] <= 0) {
        return nextPageURL;
    }
    
    NSString *resultURL = nil;
    
    if ([moreID length]>0) {
        if ([moreID isEqualToString:@"-1"]) {
            resultURL = nil;
        }
        else{
            resultURL = [NSString stringWithFormat:@"%@?lastid=%@", self.URL, moreID];
        }
    }
    else{
        resultURL = nextPageURL;
    }
    
    return resultURL;
}

- (NSString *)pullRefreshURLWithDictionary:(NSDictionary *)dictionary
                                       URL:(NSString *)URL
                      originPullRefreshURL:(NSString *)originPullRefreshURL
{
    NSString *refreshID = InfoNewsIDStringWithObject([dictionary objectForKey:kInfoNewsPullRefreshKey]);
    if ([refreshID length] <= 0) {
        return originPullRefreshURL;
    }
    
    NSString *resultURL = nil;
    if ([refreshID length]>0) {
        resultURL = [NSString stringWithFormat:@"%@?topid=%@", self.URL, refreshID];
    }
    else{
        resultURL = originPullRefreshURL;
    }
    
    return resultURL;
}



- (BOOL)parseURLResponse:(NSDictionary*)dictionary URL:(NSString *)URL
{
    if (dictionary==nil || [[dictionary allKeys] count]<=0) {
        return NO;
    }
    
    // 1. 取出老的数据
    NSMutableArray *items = [self originItems];
    
    // 2. 插入新的数据
    items = [self appendItemsWithOriginItems:items
                                    response:dictionary
                                         URL:URL];
    
    // 3. 获取下一页URL
    NSString *nextPageURL = [self nextPageURLWithDictionary:dictionary
                                                        URL:URL
                                          originNextPageURL:_dataSource.nextPageURL];
    
    // 4. 获取下拉刷新URL
    NSString *pullRefreshURL = [self pullRefreshURLWithDictionary:dictionary
                                                              URL:URL
                                             originPullRefreshURL:_dataSource.refreshURL];
    
    // 5. 创建新的data source
    MSMutableDataSource *dsTmp = [[MSMutableDataSource alloc] init];
    [dsTmp addNewSection:kVIPNewsTitle withItems:items];
    dsTmp.nextPageURL = nextPageURL;
    dsTmp.refreshURL = pullRefreshURL;
    self.dataSource = dsTmp;
    
    return YES;
}


@end


NSString *InfoNewsIDStringWithObject(id obj)
{
    if ([obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    }
    
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%d", [((NSNumber *)obj) intValue]];
    }
    
    return nil;
}

