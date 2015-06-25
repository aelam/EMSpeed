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
    BOOL _hasHeaderRefresh; //是否可下拉刷新数据，默认为yes
    BOOL _hasFooterRefresh;
    
    
    BOOL _isRefreshViewReloading;  //用户标记当前是否在请求数据
    
}

// subclass overwrite
- (void)headerRefreshing;
- (void)footerRefreshing;

@end
