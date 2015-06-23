//
//  EMScrollableList.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSScrollableProtocol.h"
#import "MSHTTPRequestModel.h"

typedef enum {
    MSScrollableListRequestFirstPage = 0,
    MSScrollableListRequestNextPage = 1,
    MSScrollableListRequestRefresh = 2,
    
} MSScrollableListRequestType;

@interface MSScrollableList : MSHTTPRequestModel <MSScrollableProtocol>

@property (nonatomic, assign) float titleWidth;
@property (nonatomic, assign) float contentWidth;
@property (nonatomic, assign) float headerHeight;
@property (nonatomic, assign) float cellHeight;

@property (nonatomic, strong) NSString *URL;
@property (nonatomic, strong) NSString *nextURL;
@property (nonatomic, strong) NSString *topId;
@property (nonatomic, strong) NSString *lastId;
@property (nonatomic, assign) BOOL hasNextPage;

@property (nonatomic, strong) MSMutableDataSource *titleDataSource;
@property (nonatomic, strong) MSMutableDataSource *contentDataSource;

@property (nonatomic, strong) id<MSCellModel> titleHeaderItem;
@property (nonatomic, strong) id<MSCellModel> contentHeaderItem;


// overwrite
- (void)loadDefaultSetting;


//获取列表
- (void)getFirstPage:(void (^)(MSHTTPResponse *response, BOOL success))block;

//翻页
- (void)getNextPage:(void (^)(MSHTTPResponse *response, BOOL success))block;

//新增
- (void)getRefresh:(void (^)(MSHTTPResponse *response, BOOL success))block;

@end
