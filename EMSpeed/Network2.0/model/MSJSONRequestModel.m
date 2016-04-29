//
//  MSJSONRequestModel.m
//  Pods
//
//  Created by flora on 16/4/27.
//
//

#import "MSJSONRequestModel.h"
#import "MSJSONSessionManager.h"
#import <PINCache/PINCache.h>

@implementation MSJSONRequestModel
@synthesize tasks = _tasks;

- (NSURLSessionDataTask *)GET:( NSString *)URLString
                   parameters:(id)parameters
                 headerFields:(id)headerFields
                   completion:(MSJSONObjectBlock)completeBlock
{
    __block NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [[MSJSONSessionManager sharedManager] GET:URLString
                                              parameters:parameters
                                            headerFields:headerFields
                                              completion:^(id json, JSONModelError* err){
                                                  if (completeBlock) {
                                                      completeBlock(json,err);
                                                  }
                                                  [self.tasks removeObject:dataTask];
                                              }];
    
    [self.tasks addObject:dataTask];
    return dataTask;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                  headerFields:(id)headerFields
                    completion:(MSJSONObjectBlock)completeBlock
{
    __block NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [[MSJSONSessionManager sharedManager] POST:URLString
                                               parameters:parameters
                                             headerFields:headerFields
                                               completion:^(id json, JSONModelError* err){
                                                   if (completeBlock) {
                                                       completeBlock(json,err);
                                                   }
                                                   [self.tasks removeObject:dataTask];
                                               }];
    
    [self.tasks addObject:dataTask];
    return dataTask;
}

#pragma mark -
#pragma mark task

- (void)dealloc
{
    [self cancelTasks];
}

- (void)cancelTasks
{
    for (NSURLSessionTask *task in _tasks) {
        [task cancel];
    }
    
    [_tasks removeAllObjects];
}

- (NSMutableArray *)getTasks
{
    if (_tasks == nil) {
        _tasks = [NSMutableArray array];
    }
    
    return _tasks;
}

#pragma mark -
#pragma mark cache

+ (id)cacheObjectForURLString:(NSString *)URLString
{
    NSURL *url = [NSURL URLWithString:URLString];
    return [[PINCache sharedCache] objectForKey:url.absoluteString];
}

+ (void)setCacheObject:(id)json forURLString:(NSString *)URLString disk:(BOOL)disk
{
    NSURL *url = [NSURL URLWithString:URLString];
    
    if (disk)
    {
        [[PINCache sharedCache] setObject:json forKey:url.absoluteString];
    }
    else
    {
        [[PINCache sharedCache].memoryCache setObject:json forKey:url.absoluteString];
    }
}

@end
