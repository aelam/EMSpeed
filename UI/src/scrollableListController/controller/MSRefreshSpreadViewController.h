//
//  EMRefreshSpreadViewController.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-13.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSSpreadViewController.h"
#import "MSRefreshTableHeaderView.h"
#import "MSRefreshTableFooterView.h"

@interface MSRefreshSpreadViewController : MSSpreadViewController <MSRefreshTableHeaderViewDelegate, MSRefreshTableFooterViewDelegate> {
    
    //下拉刷新
    MSRefreshTableHeaderView *_refreshHeaderView;
    MSRefreshTableFooterView *_refreshFooterView;
    
    BOOL _isRefreshViewReloading;  //用户标记当前是否在请求数据
    BOOL _isBackFromPush;
}

/**
 *  下拉刷新, 初始化时设置, 默认YES
 */
@property (nonatomic, assign) BOOL enableRefreshHeader;


/**
 *  上拉刷新, 初始化时设置, 默认YES
 */
@property (nonatomic, assign) BOOL enableRefreshFooter;


/**
 *  当viewDidAppear显示时, 是否要刷新, 默认是YES
 */
@property (nonatomic, assign) BOOL refreshWhenFirstViewDidAppear;


/**
 *  从其他界面返回viewDidAppear时, 是否需要刷新, 默认是NO
 */
@property (nonatomic, assign) BOOL refreshWhenPushBack;


/**
 *  下拉刷新触发时调用, 子类实现即可
 */
- (void)headerRefreshing;


/**
 *  上拉刷新触发时调用, 子类实现即可
 */
- (void)footerRefreshing;

// subclass overwrite
- (void)headerRefreshing;
- (void)footerRefreshing;

@end
