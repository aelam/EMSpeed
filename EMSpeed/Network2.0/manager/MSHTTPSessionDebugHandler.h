//
//  MSHTTPSessionHandler.h
//  Pods
//
//  Created by flora on 16/4/29.
//
//

#ifndef MSHTTPSessionDebugHandler_h
#define MSHTTPSessionDebugHandler_h

@protocol MSHTTPSessionDebugHandler <NSObject>

- (void)handleRequestError:(NSError *)error;

- (void)handleRequestFlowData:(NSString *)URL
                  downLoadLen:(NSUInteger)download
                    uploadLen:(NSUInteger)upload;
@end
#endif /* MSHTTPSessionDebugHandler_h */
