//
//  MSRefreshTableController.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-27.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MSRefreshTableController.h"

@interface MSRefreshTableController () 

@end

@implementation MSRefreshTableController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.enableRefreshHeader = YES;
        self.enableRefreshFooter = YES;
        self.refreshWhenFirstViewDidAppear = YES;
        self.refreshWhenPushBack = NO;
        _isBackFromPush = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefresh];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.refreshWhenFirstViewDidAppear || (_isBackFromPush && self.refreshWhenPushBack)) {
        self.refreshWhenFirstViewDidAppear = NO;
        [self.tableView.header beginRefreshing];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _isBackFromPush = YES;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    __weak MSRefreshTableController* weakSelf = self;
    
    if (self.enableRefreshHeader) {
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            [weakSelf headerRefreshing];
        }];
    }

    if (self.enableRefreshFooter) {
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            [weakSelf footerRefreshing];
        }];
    }
    
    self.tableView.header.updatedTimeHidden = YES;
}

- (void)setEnableRefreshHeader:(BOOL)enableRefreshHeader
{
    __weak MSRefreshTableController* weakSelf = self;
    
    _enableRefreshHeader = enableRefreshHeader;
    
    if (self.isViewLoaded) {
        if (self.enableRefreshHeader) {
            [self.tableView addGifHeaderWithRefreshingBlock:^{
                [weakSelf headerRefreshing];
            }];
        }
    }
}

- (void)setEnableRefreshFooter:(BOOL)enableRefreshFooter
{
    __weak MSRefreshTableController* weakSelf = self;
    
    _enableRefreshFooter = enableRefreshFooter;
    
    if (self.isViewLoaded) {
        if (self.enableRefreshFooter) {
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                [weakSelf footerRefreshing];
            }];
        }
    }
}


- (void)headerRefreshing
{
    // 子类实现
    // 不要忘记调用
    [self.tableView.header endRefreshing];
}

- (void)footerRefreshing
{
    // 子类实现
    // 不要忘记调用
    [self.tableView.footer endRefreshing];
}

@end
