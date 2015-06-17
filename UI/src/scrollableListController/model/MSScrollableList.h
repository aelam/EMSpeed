//
//  EMScrollableList.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSScrollableProtocol.h"

@interface MSScrollableList : NSObject <MSScrollableProtocol>



@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL didNeedsRequest;
@property (nonatomic, strong) MSMutableDataSource *titleDataSource;
@property (nonatomic, strong) MSMutableDataSource *contentDataSource;

@property (nonatomic, strong) id<MSCellModel> titleHeaderItem;
@property (nonatomic, strong) id<MSCellModel> contentHeaderItem;


@end