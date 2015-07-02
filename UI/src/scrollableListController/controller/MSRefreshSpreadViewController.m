//
//  EMRefreshSpreadViewController.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-13.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSRefreshSpreadViewController.h"
#import "MSSpreadModel.h"

@interface MSRefreshSpreadViewController () {
    
}

@end

@implementation MSRefreshSpreadViewController

- (id)init
{
    self = [super init];
    if (self) {
        _enableRefreshHeader = YES;
        _enableRefreshFooter = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRefreshHeaderView];
    [self loadRefreshFooterView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.refreshWhenFirstViewDidAppear || (_isBackFromPush && self.refreshWhenPushBack)) {
        self.refreshWhenFirstViewDidAppear = NO;
        [self headerRefreshing];
    }
    _isBackFromPush = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *) scrollView
{
    [super scrollViewDidScroll:scrollView];
    
    if (_enableRefreshHeader)
    {
        if (NO == _refreshHeaderView.hidden)
        {
            [_refreshHeaderView MSRefreshScrollViewDidScroll:scrollView];
        }
    }
    
    if (_enableRefreshFooter)
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
    
    if (_enableRefreshHeader && [scrollView isKindOfClass:[UITableView class]])
    {
        if (!_refreshHeaderView)
        {
            NSAssert(_refreshHeaderView, @"_refreshHeaderView doesnot create when _enableRefreshHeader is set yes");
        }
        if (NO == _refreshHeaderView.hidden)
        {
            [_refreshHeaderView MSRefreshScrollViewDidEndDragging:scrollView];
        }
    }
    
    if (_enableRefreshFooter && [scrollView isKindOfClass:[UITableView class]])
    {
        if (!_refreshFooterView)
        {
            NSAssert(_refreshFooterView, @"_refreshFooterView doesnot create when _enableRefreshFooter is set yes");
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
    if (_enableRefreshHeader)
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
    if (_enableRefreshFooter)
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

- (void)setEnableRefreshFooter:(BOOL)enableRefreshFooter
{
    _enableRefreshFooter = enableRefreshFooter;
    [self loadRefreshFooterView];
}

- (void)setEnableRefreshHeader:(BOOL)enableRefreshHeader
{
    _enableRefreshHeader = enableRefreshHeader;
    [self loadRefreshHeaderView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self loadRefreshFooterView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self headerRefreshing];
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
