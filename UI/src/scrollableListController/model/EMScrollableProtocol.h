//
//  EMScrollableProtocol.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMModelProtocol.h"
#import "MMMutableDataSource.h"

@protocol MMCellModel;

@protocol EMScrollableProtocol <EMModelProtocol>

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL didNeedsRequest;
@property (nonatomic, strong) MMMutableDataSource *titleDataSource;
@property (nonatomic, strong) MMMutableDataSource *contentDataSource;
@property (nonatomic, strong) id<MMCellModel> titleHeaderItem;
@property (nonatomic, strong) id<MMCellModel> contentHeaderItem;

@required

- (Class)titleCellClassWithIndexPath:(NSIndexPath *)indexPath;
- (Class)contentCellClassWithIndexPath:(NSIndexPath *)indexPath;

- (NSUInteger)numberOfRowsInSection:(NSInteger)section;
- (BOOL)isCached;
- (BOOL)resetDataWithCurrentRow:(NSInteger)row;

- (id<MMCellModel>)titleItemAtIndexPath:(NSIndexPath *)indexPath;
- (id<MMCellModel>)contentItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)visiableItems;
- (int)currentSelectedIndex:(NSIndexPath *)indexPath;

- (CGFloat)calculateTitleTableViewWidth:(CGFloat)width;
- (CGFloat)calculateContentTableViewWidth:(CGFloat)width;
- (CGFloat)tableViewHeaderHeight;

- (CGFloat)titleCellHeightAtIndex:(NSIndexPath *)indexPath;
- (CGFloat)contentCellHeightAtIndex:(NSIndexPath *)indexPath;

- (BOOL)isEmpty;

@optional
- (BOOL)hasMorePages; // 是否有下一页

@end
