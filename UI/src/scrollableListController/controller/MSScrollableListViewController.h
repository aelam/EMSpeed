//
//  EMStockListViewController.h
//  EMStock
//
//  Created by flora on 14-9-15.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"
#import "MSCellUpdating.h"
#import "MSScrollableList.h"

NSString *const MSScrollableListCellSelectedNotification;
NSString *const MSScrollableListCellHighlightedNotification;

@interface MSScrollableListViewController : MSViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIEdgeInsets _contentInsets;
    
    UIView       *_backgroundView;
    UITableView  *_titleTableView;
    UITableView  *_contentTableView;
    UIScrollView *_contentScrollView;

    UIView<MSCellUpdating> *_titleHeaderView;
    UIView<MSCellUpdating> *_contentHeaderView;
    
    BOOL _autoDisplayEmptyView;
    UIView *_emptyView;
    
    //行情数据左右滚动提示视图
    UILabel *_scrollTipImageViewLeft;
    UILabel *_scrollTipImageViewRight;
    
    MSScrollableList *_scrollableList;
}

@property (nonatomic, strong) MSScrollableList *scrollableList;
@property (nonatomic, assign) BOOL autoDisplayEmptyView;

- (instancetype)init;

- (void)reloadPages:(MSScrollableList *)model;

// 子类需要实现的方法
// 注册tableview cell
- (void)tableViewDidRegisterTableViewCell;
// scrollview 停下然后去加载数据
- (void)loadDataWhenUserDragDown;

@end
