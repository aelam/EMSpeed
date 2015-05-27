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


@interface MSRefreshScrollableListViewController () {
    
    //下拉刷新
    MSRefreshTableHeaderView *_refreshHeaderView;
    MSRefreshTableFooterView *_refreshFooterView;
    BOOL _hasHeaderRefresh; //是否可下拉刷新数据，默认为yes
    BOOL _hasFooterRefresh;
    BOOL _reloading;  //用户标记当前是否在请求数据
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
            [_refreshHeaderView emRefreshScrollViewDidScroll:scrollView];
        }
    }
    
    if (_hasFooterRefresh)
    {
        if (NO == _refreshFooterView.hidden) {
            [_refreshFooterView emRefreshScrollViewDidScroll:scrollView];
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
            [_refreshHeaderView emRefreshScrollViewDidEndDragging:scrollView];
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
            [_refreshFooterView emRefreshScrollViewDidEndDragging:scrollView];
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
            CGRect rect = CGRectMake(0.0f, height, self.view.frame.size.width, EMRefreshTableHeaderView_HEIGHT);
            _refreshFooterView = [[MSRefreshTableFooterView alloc] initWithFrame:rect];
            _refreshFooterView.autoresizingMask = UIViewAutoresizingNone;
            _refreshFooterView.delegate = self;
            [_titleTableView addSubview:_refreshFooterView];
        }
        else{
            _refreshFooterView.frame = CGRectMake(0.0f, height, self.view.frame.size.width, EMRefreshTableHeaderView_HEIGHT);
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

- (void)requestDatasource
{
    [self headerRefreshing];
}

- (void)headerRefreshing
{
    [self performSelector:@selector(finishRefreshHeaderLoading) withObject:nil afterDelay:0.5f];
}

- (void)footerRefreshing
{
    [self performSelector:@selector(finishMorePageLoading) withObject:nil afterDelay:0.5f];
}

- (void)finishRefreshHeaderLoading
{
    [_refreshHeaderView emRefreshScrollViewDataSourceDidFinishedLoading:_contentTableView];
    _reloading = NO;
}

- (void)finishMorePageLoading
{
    int numberOfItems = 5;
    NSMutableArray *items = [NSMutableArray array];
    for (int i=0; i<numberOfItems; i++) {
        MSNameListItem *item = [[MSNameListItem alloc] init];
        [items addObject:item];
    }
    
    [_scrollableList.titleDataSource appendItems:items atSection:0];
    
    
    items = [NSMutableArray array];
    for (int i=0; i<numberOfItems; i++) {
        MSContentListItem *item = [[MSContentListItem alloc] init];
        [items addObject:item];
    }
    
    [_scrollableList.contentDataSource appendItems:items atSection:0];
    
    
    [self reloadDataSource];
    
    
    [_refreshFooterView emRefreshScrollViewDataSourceDidFinishedLoading:_contentTableView];
    _reloading = NO;
    
}

# pragma mark - refresh header delegate

- (void)emRefreshTableHeaderDidTriggerRefresh:(MSRefreshTableHeaderView*)view
{
    _reloading = YES;
    [self requestDatasource];
}

- (BOOL)emRefreshTableHeaderDataSourceIsLoading:(MSRefreshTableHeaderView*)view
{
    return _reloading; // should return if data source model is reloading
}

- (NSDate*)emRefreshTableHeaderDataSourceLastUpdated:(MSRefreshTableHeaderView*)view
{
    return [NSDate date]; // should return date data source was last changed
}


# pragma mark - refresh footer delegate

- (void)emRefreshTableFooterDidTriggerRefresh:(MSRefreshTableFooterView*)view
{
    _reloading = YES;
    [self footerRefreshing];
}

- (BOOL)emRefreshTableFooterDataSourceIsLoading:(MSRefreshTableFooterView*)view
{
    return _reloading;
}

- (NSDate*)emRefreshTableFooterDataSourceLastUpdated:(MSRefreshTableFooterView*)view
{
    return [NSDate date];
}

@end
