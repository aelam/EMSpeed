//
//  EMStockListViewController.h
//  EMStock
//
//  Created by flora on 14-9-15.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSScrollableList.h"

NSString *const MSScrollableListCellSelectedNotification;
NSString *const MSScrollableListCellHighlightedNotification;

@interface MSScrollableListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIEdgeInsets _contentInsets;
    
    UIView       *_backgroundView;
    UITableView  *_titleTableView;
    UITableView  *_contentTableView;
    UIScrollView *_contentScrollView;

    UIView *_titleHeaderView;
    UIView *_contentHeaderView;
    
    UIView *_emptyView;
    
    //行情数据左右滚动提示视图
    UILabel *_scrollTipImageViewLeft;
    UILabel *_scrollTipImageViewRight;
    
    //数据模块，负责数据的收发、数据绘制解析等工作
    MSScrollableList *_scrollableList;
    
    NSMutableArray *_operationArray;
}


@property (nonatomic, strong, readonly) MSScrollableList *scrollableList;


- (instancetype)init;

/**
 *请求返回数据后加载数据
 *读取缓存数据后加载数据
 */
- (void)reloadDataSource;


@end
