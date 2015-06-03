//
//  ViewController.h
//  ScrollView2010Demo
//
//  Created by Chen Weigang on 12-7-3.
//  Copyright (c) 2012年 Fugu Mobile Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSBaseViewController.h"

@protocol EMMultiPagingProtocol;

static const NSInteger kMultiPageControllerLoopSize;
static const NSInteger kMultiPageControllerLoopSizeMax;


/*
 多页面滚动基类
 */
@interface MSMultiPagingBaseController : MSBaseViewController <UIScrollViewDelegate> {
    
    BOOL                _isPagesInited;             // 页面是否初始化
    int                 _initPageIndex;             // 初始化页面下标，默认0
    
    NSArray             *_pageTitles;               // 资讯标题或个股代码
    
    UIScrollView        *_pagingScrollView;         // 滚动的scrollview
    
    
    NSMutableSet        *_visibleControlls;         // 当前显示的controller
    NSMutableSet        *_recycledControlls;        // 回收的controller
    
    int                 _currentDisplayPageIndex;   // 当前显示页下标
    
    int                 _lastDisplayFirstIndex;
    int                 _lastDisplayLastIndex;
    
    CGFloat             _padding;                   // 左右滚动时的边框 默认10
    
    int                 _isLoop;
}

@property (nonatomic, assign, readonly) BOOL isPagesInited;
@property (nonatomic, assign, readonly) int isLoop; // 是否循环滚动
@property (nonatomic, assign, readonly) int loopSize;

@property (nonatomic, assign, readonly) int currentDisplayPageIndex; // 当前显示页下标
@property (nonatomic, assign, readonly) UIViewController<EMMultiPagingProtocol> *currentDisplayController; // 当前显示的Controller

@property (nonatomic, assign) BOOL isPushBack; // 是否pushViewController返回

/*
   子类必须重写以下三个方法
 - (NSArray *)titlesOfPages;
 - (int)numberOfPages;
 - (UIViewController<EMMultiPagingProtocol> *)controllerAtPageIndex:(int)index;
 */

// 页面的标题数组
- (NSArray *)titlesOfPages;
// 页面总个数
- (int)numberOfPages;
// 某一页控制器应该显示
- (UIViewController<EMMultiPagingProtocol> *)controllerAtPageIndex:(int)index;


// 取回收的controller
- (UIViewController<EMMultiPagingProtocol> *)dequeueReusableControllerByClassName:(NSString *)className;

// 直接跳转某页
- (void)setCurrentPageIndex:(int)page
                   animated:(BOOL)animated
                 reloadData:(BOOL)needReloadData;

// 当前的页面发包和取页面缓存
- (void)reloadData;

- (NSMutableSet *)getVisibleControllers;

@end


/* 滚动的子controller必须实现*/
@protocol EMMultiPagingProtocol <NSObject>

@required
- (void)setMultiPageIndex:(int)index;
- (int)getMultiPageIndex;

- (MSMultiPagingBaseController *)getMultiPagingController;
- (void)setMultiPagingController:(MSMultiPagingBaseController *)controller;
- (UINavigationController *)navigationController;


// 有一些EMController老的接口, 如果EMController, 则可以杠掉
- (void)refreshDelay:(CGFloat)interval;
- (void)cancelRefresh;
- (void)cancelRequest;
- (void)requestDatasource;
- (void)loadCacheData;


@optional
- (void)pageViewDidEndDecelerating:(MSMultiPagingBaseController *)controller;
- (void)pageViewDidAddToScrollView:(MSMultiPagingBaseController *)controller;
- (void)pageViewDidRemoveFromScrollView:(MSMultiPagingBaseController *)controller;

/** 
    pageViewDidEndDecelerating
    滚动停止时调用到，如果不实现，则默认如果当前页,发包sendPackage, 如果时当前页两边, 取缓存updateResult
 
    pageViewDidAddToScrollView
    当page加到scrollView上时调用到, 如果不实现，默认什么也不干
 
    pageViewDidRemoveFromScrollView
    当page从scrollView上移除时调用到, 如果不实现，默认什么也不干
 */
- (void)updateResult;
@end

