//
//  MSSpreadProtocol.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSModelProtocol.h"
#import "MSMutableDataSource.h"

@protocol MSCellModel;

@protocol MSSpreadProtocol <MSModelProtocol>

@required

- (Class)titleCellClassWithIndexPath:(NSIndexPath *)indexPath;
- (Class)contentCellClassWithIndexPath:(NSIndexPath *)indexPath;

- (NSUInteger)numberOfRowsInSection:(NSInteger)section;
- (BOOL)isCached;
- (BOOL)resetDataWithCurrentRow:(NSInteger)row;

- (id<MSCellModel>)titleItemAtIndexPath:(NSIndexPath *)indexPath;
- (id<MSCellModel>)contentItemAtIndexPath:(NSIndexPath *)indexPath;

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
