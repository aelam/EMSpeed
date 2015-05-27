//
//  EMScrollableList.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSScrollableList.h"
#import "MSNameListItem.h"
#import "MSContentListItem.h"
#import "MSScrollableTableTitleHeaderView.h"
#import "MSScrollableTableContentHeaderView.h"
#import "MSCellModel.h"

@implementation MSScrollableList

@synthesize cellHeight;
@synthesize isLoading;
@synthesize didNeedsRequest;
@synthesize titleHeaderItem;
@synthesize contentHeaderItem;
@synthesize titleDataSource;
@synthesize contentDataSource;


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 44;
        self.isLoading = NO;
        self.didNeedsRequest = YES;
        
        int numberOfItems = 15;
        NSMutableArray *items = [NSMutableArray array];
        for (int i=0; i<numberOfItems; i++) {
            MSNameListItem *item = [[MSNameListItem alloc] init];
            [items addObject:item];
        }
        self.titleDataSource = [[MSMutableDataSource alloc] initWithItems:@[items] sections:@[@""]];


        items = [NSMutableArray array];
        for (int i=0; i<numberOfItems; i++) {
            MSContentListItem *item = [[MSContentListItem alloc] init];
            [items addObject:item];
        }
        
        self.contentDataSource = [[MSMutableDataSource alloc] initWithItems:@[items] sections:@[@""]];
        
        self.titleHeaderItem = [[MSScrollableTableTitleHeaderItem alloc] init];
        self.contentHeaderItem = [[MSScrollableTableContentHeaderItem alloc] init];
    }
    
    return self;
}

- (Class)titleCellClassWithIndexPath:(NSIndexPath *)indexPath
{
    id<MSCellModel> model = [self.titleDataSource itemAtIndexPath:indexPath];
    return model.Class;
}

- (Class)contentCellClassWithIndexPath:(NSIndexPath *)indexPath
{
    id<MSCellModel> model = [self.contentDataSource itemAtIndexPath:indexPath];
    return model.Class;
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.titleDataSource numberOfItemsAtSection:section];
}

- (BOOL)isCached
{
    return NO;
}

- (BOOL)resetDataWithCurrentRow:(NSInteger)row
{
    return YES;
}

- (id<MSCellModel>)titleItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.titleDataSource itemAtIndexPath:indexPath];
}

- (id<MSCellModel>)contentItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.contentDataSource itemAtIndexPath:indexPath];
}

- (NSArray *)visiableItems
{
    return nil;
}

- (int)currentSelectedIndex:(NSIndexPath *)indexPath
{
    return 0;
}

- (CGFloat)calculateTitleTableViewWidth:(CGFloat)width
{
    return 90;
}

- (CGFloat)calculateContentTableViewWidth:(CGFloat)width
{
    return 800;
}

- (CGFloat)tableViewHeaderHeight
{
    NSAssert(self.titleHeaderItem.height == self.contentHeaderItem.height, @"标题和内容header高度一致");
    CGFloat height = self.titleHeaderItem.height;
    return height == 0 ? 30 : height;
}

- (BOOL)hasMorePages
{
    return YES;
}

- (CGFloat)titleCellHeightAtIndex:(NSIndexPath *)indexPath
{
    id<MSCellModel> model = [self.titleDataSource itemAtIndexPath:indexPath];
    return model.height;
}

- (CGFloat)contentCellHeightAtIndex:(NSIndexPath *)indexPath
{
    id<MSCellModel> model = [self.contentDataSource itemAtIndexPath:indexPath];
    return model.height;
}

- (id)modelWithBlock:(void (^)(NSOperation *operation, BOOL success))block
{
    return nil;
}

- (BOOL)isEmpty
{
   return (self.titleDataSource == nil && self.contentDataSource == nil) || ([self.titleDataSource isEmpty] && [self.contentDataSource isEmpty]);
}

@end
