//
//  MSRefreshTableController.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-27.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MSRefreshTableController.h"

@interface MSRefreshTableController () {
    NSUInteger _numberOfControllersInStack;
    
    BOOL _refreshWhenFirstViewDidAppear;
    BOOL _enableRefreshHeader;
    BOOL _enableRefreshFooter;
    
}


@property (nonatomic, strong, readwrite) MJRefreshHeader *refreshHeader;
@property (nonatomic, strong, readwrite) MJRefreshFooter *refreshFooter;

@end

@implementation MSRefreshTableController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _refreshWhenFirstViewDidAppear = YES;
        _enableRefreshHeader = YES;
        _enableRefreshFooter = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numberOfControllersInStack = 0;
    
    [self loadHeaderRefresh];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 兼容老版本逻辑
    if (self.refreshWhenFirstViewDidAppear) {
        self.refreshWhenFirstViewDidAppear = NO;
        if ([self respondsToSelector:@selector(headerRefreshing)]) {
            [self headerRefreshing];
        }
    }
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 兼容老版本逻辑
    BOOL isPushBack = _numberOfControllersInStack > 0 && _numberOfControllersInStack - 1 == [self.navigationController.viewControllers count];
    
    if (isPushBack && self.refreshWhenPushBack) {
        [self.refreshHeader beginRefreshing];
    }
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _numberOfControllersInStack = [self.navigationController.viewControllers count];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark - Refresh Header


- (BOOL)loadHeaderRefresh
{
    if ([self refreshHeader]) {
        return YES;
    }
    
    return NO;
}


- (MJRefreshHeader *)refreshHeader
{
    if (!_refreshHeader && _enableRefreshHeader) {
        if ([self respondsToSelector:@selector(refreshHeaderOfTableView)]) {
            _refreshHeader = [self refreshHeaderOfTableView];
        }
        
        if (!_refreshHeader) {
            _refreshHeader = [MJRefreshGifHeader headerWithRefreshingBlock:NULL];
        }
        
        __weak __typeof(self)weakSelf = self;

        _refreshHeader.refreshingBlock = ^(){
            if ([weakSelf respondsToSelector:@selector(refreshHeaderDidRefresh:)])
            {
                [weakSelf refreshHeaderDidRefresh:_refreshHeader];
            }
            else if ([weakSelf respondsToSelector:@selector(headerRefreshing)]) {
                [weakSelf headerRefreshing];
            }
        };
    }
    
    if (_tableView.header != _refreshHeader) {
        _tableView.header = _refreshHeader;
    }
    
    return _refreshHeader;
}

- (void)beginHeaderRefreshing
{
    [self.refreshHeader beginRefreshing];
}


- (MJRefreshHeader *)refreshHeaderOfTableView
{
    return _refreshHeader;
}


- (void)setRefreshHeaderHidden:(BOOL)refreshHeaderHidden
{
    self.tableView.header.hidden = refreshHeaderHidden;
}


- (BOOL)refreshHeaderHidden
{
    return (self.tableView.header && self.tableView.header.hidden);
}


- (void)endHeaderRefreshing
{
    [self.refreshHeader endRefreshing];
}


# pragma mark - Refresh Footer

- (BOOL)loadFooterRefresh
{
    if ([self refreshFooter]) {
        return YES;
    }
    
    return NO;
}


- (MJRefreshFooter *)refreshFooter
{
    if (!_refreshFooter && _enableRefreshFooter){
        if ([self respondsToSelector:@selector(refreshFooterOfTableView)]) {
            _refreshFooter = [self refreshFooterOfTableView];
        }
        
        if (!_refreshFooter) {
            _refreshFooter = [MJRefreshAutoFooter footerWithRefreshingBlock:NULL];
        }
        
        __weak __typeof(self)weakSelf = self;

        _refreshFooter.refreshingBlock = ^(){
            if ([weakSelf respondsToSelector:@selector(refreshFooterDidRefresh:)])
            {
                [weakSelf refreshFooterDidRefresh:_refreshFooter];
            }
            else if ([weakSelf respondsToSelector:@selector(footerRefreshing)]) {
                [weakSelf footerRefreshing];
            }
        };
    }
    
    if (_tableView.footer != _refreshFooter) {
        _tableView.footer = _refreshFooter;
    }
    
    return _refreshFooter;
}


- (void)beginFooterRefreshing
{
    [self.refreshFooter beginRefreshing];
}


- (MJRefreshFooter *)refreshFooterOfTableView
{
    return _refreshFooter; // 
}


- (BOOL)refreshFooterHidden
{
    return (self.tableView.footer && self.tableView.footer.hidden);
}


- (void)endFooterRefreshing
{
    [self.refreshFooter endRefreshing];
}


- (void)setRefreshFooterStatus:(MSRefreshFooterStatus)status
{
    if (status == MSRefreshFooterStatusIdle) {
        self.refreshFooter.hidden = NO;
        [self.refreshFooter resetNoMoreData];
    }
    else if (status == MSRefreshFooterStatusNoMoreData) {
        self.refreshFooter.hidden = NO;
        [self.refreshFooter noticeNoMoreData];
    }
    else if (status == MSRefreshFooterStatusHidden) {
        [self.refreshFooter setHidden:YES];
    }
    else if (status == MSRefreshFooterStatusNoInit) {
        _tableView.footer = nil;
        _refreshFooter = nil;
    }
}

- (MSRefreshFooterStatus)refreshFooterStatus
{
    if (self.refreshFooter.hidden) {
        return MSRefreshFooterStatusHidden;
    }
    else if (self.refreshFooter.state == MJRefreshStateNoMoreData) {
        return MJRefreshStateNoMoreData;
    }
    
    return MSRefreshFooterStatusIdle;
}


# pragma mark - DEPRECATED

-(void)setEnableRefreshHeader:(BOOL)enable
{
    _enableRefreshHeader = enable;
    
    if (_enableRefreshHeader) {
        [self refreshHeader];
    }
    else {
        _refreshHeader = nil;
        if (_tableView) {
            _tableView.header = nil;
        }
    }
}

- (void)setEnableRefreshFooter:(BOOL)enable
{
    _enableRefreshFooter = enable;
    
    if (_enableRefreshFooter) {
        [self refreshFooter];
    }
    else {
        _refreshFooter = nil;
        if (_tableView) {
            _tableView.footer = nil;
        }
    }
}


- (void)headerRefreshing
{
    // do noting
}

- (void)footerRefreshing
{
    // do noting
}

@end
