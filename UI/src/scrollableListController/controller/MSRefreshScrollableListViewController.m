//
//  EMRefreshScrollableListViewController.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-13.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSRefreshScrollableListViewController.h"
#import "MSNameListItem.h"
#import "MSContentListItem.h"
#import "MSScrollableList.h"

@interface MSRefreshScrollableListViewController () {
    
}

@end

@implementation MSRefreshScrollableListViewController

- (id)init
{
    self = [super init];
    if (self) {
        _hasHeaderRefresh = YES;
        _hasFooterRefresh = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRefreshHeaderView];
    [self loadRefreshFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *) scrollView
{
    [super scrollViewDidScroll:scrollView];
    
    if (_hasHeaderRefresh)
    {
        if (NO == _refreshHeaderView.hidden)
        {
            [_refreshHeaderView MSRefreshScrollViewDidScroll:scrollView];
        }
    }
    
    if (_hasFooterRefresh)
    {
        if (NO == _refreshFooterView.hidden) {
            [_refreshFooterView MSRefreshScrollViewDidScroll:scrollView];
            [self loadRefreshFooterView];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    
    if (_hasHeaderRefresh && [scrollView isKindOfClass:[UITableView class]])
    {
        if (!_refreshHeaderView)
        {
            NSAssert(_refreshHeaderView, @"_refreshHeaderView doesnot create when _hasHeaderRefresh is set yes");
        }
        if (NO == _refreshHeaderView.hidden)
        {
            [_refreshHeaderView MSRefreshScrollViewDidEndDragging:scrollView];
        }
    }
    
    
    if (_hasFooterRefresh && [scrollView isKindOfClass:[UITableView class]])
    {
        if (!_refreshFooterView)
        {
            NSAssert(_refreshFooterView, @"_refreshFooterView doesnot create when _hasFooterRefresh is set yes");
        }
        if (NO == _refreshFooterView.hidden)
        {
            [_refreshFooterView MSRefreshScrollViewDidEndDragging:scrollView];
        }
    }
    
}

#pragma mark -
#pragma mark EMRefreshTableHeaderDelegate Methods
- (void)loadRefreshHeaderView
{
    if (_hasHeaderRefresh)
    {
        if (_refreshHeaderView == nil && _titleTableView)
        {
            CGRect rect = CGRectMake(0.0f, 0.0f - _titleTableView.bounds.size.height, self.view.frame.size.width, _titleTableView.bounds.size.height);
            _refreshHeaderView = [[MSRefreshTableHeaderView alloc] initWithFrame:rect];
            _refreshHeaderView.autoresizingMask = UIViewAutoresizingNone;
            _refreshHeaderView.delegate = self;
            [_titleTableView addSubview:_refreshHeaderView];
        }
    }
    else if (_refreshHeaderView)
    {
        _refreshHeaderView.hidden = YES;
    }
}

- (void)loadRefreshFooterView
{
    if (_hasFooterRefresh)
    {
        CGFloat height = MAX(_titleTableView.contentSize.height, _titleTableView.frame.size.height);
        if (_refreshFooterView == nil && _titleTableView)
        {
            CGRect rect = CGRectMake(0.0f, height, self.view.frame.size.width, MSRefreshTableHeaderView_HEIGHT);
            _refreshFooterView = [[MSRefreshTableFooterView alloc] initWithFrame:rect];
            _refreshFooterView.autoresizingMask = UIViewAutoresizingNone;
            _refreshFooterView.delegate = self;
            [_titleTableView addSubview:_refreshFooterView];
            _refreshFooterView.lastUpdatedLabel.hidden = YES;
        }
        else{
            _refreshFooterView.frame = CGRectMake(0.0f, height, self.view.frame.size.width, MSRefreshTableHeaderView_HEIGHT);
        }
    }
    else if (_refreshFooterView)
    {
        _refreshFooterView.hidden = YES;
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self loadRefreshFooterView];
}

- (void)headerRefreshing
{
    // subclass overwrite
}

- (void)footerRefreshing
{
    // subclass overwrite
}

# pragma mark - refresh header delegate

- (void)MSRefreshTableHeaderDidTriggerRefresh:(MSRefreshTableHeaderView*)view
{
    _isRefreshViewReloading = YES;
    [self headerRefreshing];
}

- (BOOL)MSRefreshTableHeaderDataSourceIsLoading:(MSRefreshTableHeaderView*)view
{
    return _isRefreshViewReloading; // should return if data source model is reloading
}

- (NSDate*)MSRefreshTableHeaderDataSourceLastUpdated:(MSRefreshTableHeaderView*)view
{
    return [NSDate date]; // should return date data source was last changed
}


# pragma mark - refresh footer delegate

- (void)emRefreshTableFooterDidTriggerRefresh:(MSRefreshTableFooterView*)view
{
    _isRefreshViewReloading = YES;
    [self footerRefreshing];
}

- (BOOL)emRefreshTableFooterDataSourceIsLoading:(MSRefreshTableFooterView*)view
{
    return _isRefreshViewReloading;
}

- (NSDate*)emRefreshTableFooterDataSourceLastUpdated:(MSRefreshTableFooterView*)view
{
    return [NSDate date];
}

@end
