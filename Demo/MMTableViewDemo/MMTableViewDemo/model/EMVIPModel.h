//
//  EMInfoNewsModel.h
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MSHTTPRequestModel.h"
#import "MSMutableDataSource.h"


@interface EMVIPModel : MSHTTPRequestModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) int Id;
@property (nonatomic, strong) NSString *URL;
@property (nonatomic, strong) MSMutableDataSource *dataSource;
@property (nonatomic, strong) NSArray *cellIdentifiers;
@property (nonatomic, assign) id actionDelegate;

- (id)initWithTitle:(NSString *)title
                 Id:(int)Id
                URL:(NSString *)URL;

- (AFHTTPRequestOperation *)modelWithURL:(NSString *)URL block:(void (^)(id, AFHTTPRequestOperation *, BOOL))block;
// subclass over write
- (BOOL)parseURLResponse:(NSDictionary*)dictionary URL:(NSString*)url;

@end
