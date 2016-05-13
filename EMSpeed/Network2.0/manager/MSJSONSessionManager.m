//
//  MSJSONSessionManager.m
//  Pods
//
//  Created by flora on 16/4/27.
//
//

#import "MSJSONSessionManager.h"

@implementation MSJSONSessionManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceQueue;
    static MSJSONSessionManager *mSJSONSessionManager = nil;
    
    dispatch_once(&onceQueue, ^{
        mSJSONSessionManager = [[self alloc] init];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 15;
        mSJSONSessionManager = [[MSJSONSessionManager alloc] initWithSessionConfiguration:config];
        mSJSONSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"application/octet-stream", nil];
        
        if ([mSJSONSessionManager.responseSerializer isKindOfClass:[AFJSONResponseSerializer class]])
        {
            AFJSONResponseSerializer *serializer = (AFJSONResponseSerializer *)mSJSONSessionManager.responseSerializer;
            serializer.removesKeysWithNullValues = YES;
        }
    });
    return mSJSONSessionManager;
}

- (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)URLString
                            parameters:(nullable id)parameters
                          headerFields:(nullable id)headerFields
                            completion:(nullable MSJSONObjectBlock)completeBlock
{
    
    return  [self __dataTaskWithHTTPMethod:@"GET"
                                 URLString:URLString
                                parameters:parameters
                              headerFields:headerFields
                                  progress:nil
                                completion:completeBlock];
}

- (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)URLString
                             parameters:(nullable id)parameters
                           headerFields:(nullable id)headerFields
                             completion:(nullable MSJSONObjectBlock)completeBlock
{
   return  [self __dataTaskWithHTTPMethod:@"POST"
                         URLString:URLString
                        parameters:parameters
                      headerFields:headerFields
                          progress:nil
                               completion:completeBlock];

}

- (NSURLSessionDataTask *)__dataTaskWithHTTPMethod:(NSString *)method
                                         URLString:(NSString *)URLString
                                        parameters:(id)parameters
                                      headerFields:(nullable id)headerFields
                                          progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                        completion:(nullable MSJSONObjectBlock)completeBlock
{
    NSURL *url = [NSURL URLWithString:URLString relativeToURL:self.baseURL];
    NSError *serializationError = nil;
    
    __weak typeof(self) weakSelf = self;
    
    void (^completionHandler)(id, NSURLResponse *, NSError *) = ^(id json, NSURLResponse *origResponse, NSError *origError) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)origResponse;
        JSONModelError *error = nil;
        
        //convert an NSError to a JSONModelError
        if (origError) {
            error = [JSONModelError errorWithDomain:origError.domain code:origError.code userInfo:origError.userInfo];
        }
        
        //special case for http error code 401
        if (error.code == NSURLErrorUserCancelledAuthentication) {
            response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:401 HTTPVersion:@"HTTP/1.1" headerFields:@{}];
        }
        
        //if not OK status set the err to a JSONModelError instance
        if (!error && (response.statusCode >= 300 || response.statusCode < 200)) {
            error = [JSONModelError errorBadResponse];
        }
        
        //if there was an error, assign the response to the JSONModel instance
        if (error) {
            error.httpResponse = [response copy];
            [weakSelf __failureRequest:error];
        }
        else
        {
            [weakSelf __successRequest:URLString parameters:parameters json:json];
        }

        if (completeBlock)
        {
            completeBlock(json, error);
        }
    };
    
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:method URLString:[url absoluteString] parameters:parameters constructingBodyWithBlock:nil error:&serializationError];
    if (serializationError) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
        dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
            completionHandler(nil,nil,serializationError);
        });
#pragma clang diagnostic pop
        
        return nil;
    }
    
    for (NSString *key in [headerFields allKeys])
    {
        [request setValue:[headerFields objectForKey:key] forHTTPHeaderField:key];
    }
    
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        completionHandler(responseObject,response,error);
    }];
    
    [task resume];
    
    return task;
}

#pragma mark -
#pragma mark debug handler

- (void)__failureRequest:(NSError *)error
{
    if (error.code == NSUserCancelledError) {
        return;
    }
    
    if (self.debugHandler && [self.debugHandler respondsToSelector:@selector(handleRequestError:)]) {
        [self.debugHandler handleRequestError:error];
    }
}

- (void)__successRequest:(NSString *)URLString parameters:(NSDictionary *)parameters json:(id)json
{
    if (self.debugHandler && [self.debugHandler respondsToSelector:@selector(handleRequestFlowData:downLoadLen:uploadLen:)])
    {
        NSUInteger uploadLen = 0;
        NSData *uploaddata = [NSKeyedArchiver archivedDataWithRootObject:parameters];
        uploadLen = [uploaddata length];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:json];
        NSUInteger downloadLen = [data length];
        
        [self.debugHandler handleRequestFlowData:URLString
                                     downLoadLen:downloadLen
                                       uploadLen:uploadLen];
    }
}



@end