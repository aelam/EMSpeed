//
//  EMSpread.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSpreadProtocol.h"
#import "MSHTTPRequestModel.h"
#import "MSSectionViewModel.h"


@interface MSSpreadModel : MSHTTPRequestModel <MSSpreadProtocol>

@property (nonatomic, assign) float titleWidth;
@property (nonatomic, assign) float contentWidth;
@property (nonatomic, assign) float headerHeight;

@property (nonatomic, strong) NSString *URL;
@property (nonatomic, strong) NSString *nextURL;
@property (nonatomic, strong) NSString *topId;
@property (nonatomic, strong) NSString *lastId;

@property (nonatomic, strong) MSMutableDataSource *titleDataSource;
@property (nonatomic, strong) MSMutableDataSource *contentDataSource;

@property (nonatomic, strong) id<MSSectionViewModel> titleHeaderItem;
@property (nonatomic, strong) id<MSSectionViewModel> contentHeaderItem;


- (float)cellHeightAtIndexPath:(NSIndexPath *)indexPath;


// overwrite
- (void)loadDefaultSetting;


//获取列表
- (void)getFirstPage:(void (^)(MSHTTPResponse *response, BOOL success))block;

//翻页
- (void)getNextPage:(void (^)(MSHTTPResponse *response, BOOL success))block;

//新增
- (void)getRefresh:(void (^)(MSHTTPResponse *response, BOOL success))block;


// overwrite
- (BOOL)parseFirstPageResponse:(MSHTTPResponse *)response;
- (BOOL)parseRefreshResponse:(MSHTTPResponse *)response;
- (BOOL)parseNextPageResponse:(MSHTTPResponse *)response;

@end
