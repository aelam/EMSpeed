//
//  ViewController.m
//  ScrollView2010Demo
//
//  Created by Chen Weigang on 12-7-3.
//  Copyright (c) 2012年 Fugu Mobile Limited. All rights reserved.
//

#import "EMMultiPagingBaseController.h"
#import "MSCoreFunction.h"
#import "MSCore.h"


static const NSInteger kMultiPagingPadding = 10;
static const NSInteger kMultiPageControllerLoopSize = (16*2);
static const NSInteger kMultiPageControllerLoopSizeMax = 512;

@interface EMMultiPagingBaseController() {
    int _firstVisiblePageIndexBeforeRotation;
    CGFloat _percentScrolledIntoFirstVisiblePage;
    int _loopSize;
}

- (void)reloadPages;// 重新加载页面
@end

@implementation EMMultiPagingBaseController
@synthesize currentDisplayPageIndex = _currentDisplayPageIndex;
@synthesize isPagesInited = _isPagesInited;
@synthesize isPushBack = _isPushBack;

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        self.title = @"MultiPageScroll";
        _isPushBack = NO;
        _padding = kMultiPagingPadding;
        _isLoop = NO;
        _isPagesInited = NO;
    }
    return self;
}

- (void)dealloc
{
}

# pragma mark - Create Views

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reloadPages];
}

- (void)reloadPages
{
    [self clearOldSubViews];
    [self createScrollView];
    [self createPages];
}

- (void)reloadData
{
    _currentDisplayPageIndex = -1;
    [self refreshPageData];
}

- (void)createScrollView
{
    if (_pagingScrollView==nil) {
        CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
        _pagingScrollView = [[UIScrollView alloc] initWithFrame:pagingScrollViewFrame];
        _pagingScrollView.pagingEnabled = YES;
        _pagingScrollView.backgroundColor = RGB(31, 31, 31);
        _pagingScrollView.showsVerticalScrollIndicator = NO;
        _pagingScrollView.showsHorizontalScrollIndicator = NO;
        _pagingScrollView.delegate = self;
        _pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
        _pagingScrollView.directionalLockEnabled = YES;
        
        if (EMOSVersion()<5.0) {
            _pagingScrollView.bounces = NO;
        }
    }
    [self.view addSubview:_pagingScrollView];
}

- (void)createPages
{
    if (_recycledControlls==nil) {
        _recycledControlls = [[NSMutableSet alloc] init];
    }
    
    if (_visibleControlls==nil) {
        _visibleControlls  = [[NSMutableSet alloc] init];
    }
    
    _currentDisplayPageIndex = -1;
    _lastDisplayFirstIndex = -1;
    _lastDisplayLastIndex = -1;
}

- (void)clearOldSubViews
{
    if (_pagingScrollView) {
        [_pagingScrollView removeFromSuperview];
        _pagingScrollView = nil;
    }
    
    if (_visibleControlls) {
        [_visibleControlls removeAllObjects];
    }
    
    if (_recycledControlls) {
        [_recycledControlls removeAllObjects];
    }
    
    self.isPushBack = NO;
}

- (UIViewController<EMMultiPagingProtocol> *)currentDisplayController
{
    if (!_isPagesInited && _currentDisplayPageIndex==-1 && [_visibleControlls count]==1) {
        return [_visibleControlls anyObject];
    }
    
    for (UIViewController<EMMultiPagingProtocol> *controller in _visibleControlls) {
        if ([controller getMultiPageIndex] == _currentDisplayPageIndex) {
            return controller;
        }
    }
    
    return nil;
}

- (int)loopSize
{
    if (_loopSize==0) {
        _loopSize = 1;
        
        if (_isLoop) {
            int sizeMax = [self numberOfPages] * kMultiPageControllerLoopSize;
            
            if (sizeMax <= kMultiPageControllerLoopSizeMax) {
                _loopSize = kMultiPageControllerLoopSize;
            }
            else{
                _loopSize = kMultiPageControllerLoopSizeMax / [self numberOfPages] / 2 * 2;
            }
        }

        NSLog(@"%d", _loopSize);
    }
    
    return _loopSize;
}

# pragma mark - Layout

- (void)viewDidLayoutSubviews
{
//    [super layoutSubviewsForView:view];
    CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
    _pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
    _pagingScrollView.frame = pagingScrollViewFrame;
    [self layoutVisiblePages];
}

- (void)layoutVisiblePages
{
    for (UIViewController<EMMultiPagingProtocol> *controller in _visibleControlls) {
        int infoPageIndex = [controller getMultiPageIndex];
        controller.view.frame = [self frameForPageAtIndex:infoPageIndex];
    }
}

# pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!_isPagesInited) {
        [self setInitPageIndex:_initPageIndex];
        [self addDisplayedControllers];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [theDelegate.statusBar hideImmediately];
    
    if (!_isPagesInited) {
        int page = _initPageIndex + (_isLoop ? [self numberOfPages]*self.loopSize/2 : 0);
        _currentDisplayPageIndex = page;
        for (UIViewController<EMMultiPagingProtocol> *controller in _visibleControlls) {
            if ([controller getMultiPageIndex]==_currentDisplayPageIndex) {
                [controller requestDatasource];
                break;
            }
        }
        _isPagesInited = YES;
    }
    else if (!self.isPushBack) {
        for (UIViewController<EMMultiPagingProtocol> *controller in _visibleControlls) {
            if ([controller getMultiPageIndex]==_currentDisplayPageIndex) {
                [controller requestDatasource];
                break;
            }
        }
    }
    
    self.isPushBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self cancelRequest];
}

- (void)didReceiveMemoryWarning
{
    if ( [self isViewLoaded] && nil == self.view.window) {
        [self clearOldSubViews];
        _isPagesInited = NO;
        _currentDisplayPageIndex = -1;
        _lastDisplayFirstIndex = -1;
        _lastDisplayLastIndex = -1;
    }
    [super didReceiveMemoryWarning];
    [_recycledControlls removeAllObjects];
    self.isPushBack = NO;
}

- (void)viewDidUnload
{
    [self clearOldSubViews];
    [super viewDidUnload];
}

- (void)setCurrentPageIndex:(int)page
                   animated:(BOOL)animated
                reloadData:(BOOL)needReloadData
{
    if (page<0) {
        page = 0;
    }
    if (page>[self numberOfPages]*self.loopSize-1) {
        page=[self numberOfPages]*self.loopSize-1;
    }
    
    CGPoint origin = CGPointMake([self frameForPageAtIndex:page].origin.x-_padding,
                                 [self frameForPageAtIndex:page].origin.y);
    
    if (animated) {
        [UIView animateWithDuration:0.3f animations:^{
            [_pagingScrollView setContentOffset:origin];
        } completion:^(BOOL finished) {
            if (CGPointEqualToPoint(origin, _pagingScrollView.contentOffset)) {
                [self deceleratingScrollView:_pagingScrollView animated:NO sendPackage:needReloadData];
            }
        }];
    }
    else{
        [_pagingScrollView setContentOffset:origin];
        if (CGPointEqualToPoint(origin, _pagingScrollView.contentOffset)) {
            [self deceleratingScrollView:_pagingScrollView animated:NO sendPackage:needReloadData];
        }
    }
}

- (void)setInitPageIndex:(int)page
{
    if (page<0 || page>=[self numberOfPages]) {
        page = 0;
    }
    
    page = page + (_isLoop ? [self numberOfPages]*self.loopSize/2 : 0);
    
    CGPoint origin = CGPointMake([self frameForPageAtIndex:page].origin.x-_padding,
                                 [self frameForPageAtIndex:page].origin.y);
    [_pagingScrollView setContentOffset:origin];
    
    _lastDisplayFirstIndex = page;
    _lastDisplayLastIndex = page+1;
}

- (NSArray *)titlesOfPages
{
    NSAssert(0, @"titlesOfPages - Subclass overwrite");
    return nil;
}


# pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

- (BOOL)tilePageIndexesChanged
{
    CGRect visibleBounds = _pagingScrollView.bounds;
    
    // 正常情况是不用-1/+1的缓存2个界面，这里想多缓存1个界面 以保证流畅滑动
    int firstNeededPageIndex = floorf((CGRectGetMinX(visibleBounds)) / CGRectGetWidth(visibleBounds)) - 1;
    int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)) / CGRectGetWidth(visibleBounds)) + 1;
    
    firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
    lastNeededPageIndex  = MIN(lastNeededPageIndex, [self numberOfPages]*self.loopSize);
    
    // 保证最多只显示3页
    if (firstNeededPageIndex==0) {
        lastNeededPageIndex = MIN([self numberOfPages]*self.loopSize, 3);
    }
    if (lastNeededPageIndex==[self numberOfPages]*self.loopSize) {
        firstNeededPageIndex = MAX(0, [self numberOfPages]*self.loopSize - 3);
    }
    //    assert(lastNeededPageIndex-firstNeededPageIndex<=3);
    
//    NSLog(@"first = %d last = %d", firstNeededPageIndex, lastNeededPageIndex);
    
    if (_lastDisplayFirstIndex == firstNeededPageIndex && _lastDisplayLastIndex == lastNeededPageIndex) {
        return NO;
    }
    _lastDisplayFirstIndex = firstNeededPageIndex;
    _lastDisplayLastIndex = lastNeededPageIndex;
    
    return YES;
}

- (void)recycleUnDisplayedControllers
{
    // 回收不显示的界面
    for (UIViewController<EMMultiPagingProtocol> *controller in _visibleControlls) {
        if ([controller getMultiPageIndex] < _lastDisplayFirstIndex
            || [controller getMultiPageIndex] > _lastDisplayLastIndex) {
            [controller setMultiPagingController:nil];
            [_recycledControlls addObject:controller];
            [controller viewWillDisappear:NO];
            [controller.view removeFromSuperview];
            [controller viewDidDisappear:NO];
            
            if ([controller respondsToSelector:@selector(pageViewDidRemoveFromScrollView:)]) {
                [controller pageViewDidRemoveFromScrollView:self];
            }
        }
    }
    [_visibleControlls minusSet:_recycledControlls];
}

- (void)addDisplayedControllers
{
    // 添加新进入的界面
    for (int index = _lastDisplayFirstIndex; index < _lastDisplayLastIndex; index++) {
        UIViewController<EMMultiPagingProtocol> *controller = [self isDisplayingPageForIndex:index];
        if (controller == nil) {
            controller = [self controllerAtPageIndex:index]; // 用户提供
            [controller setMultiPagingController:self];
            [controller setMultiPageIndex:index];
            if (![[controller class] conformsToProtocol:NSProtocolFromString(@"EMMultiPagingProtocol")]) {
                NSAssert(0, @"controller 必须实现 EMMultiPagingProtocol");
            }
            controller.view.frame = [self frameForPageAtIndex:index];
            [controller viewWillAppear:NO];
            [_pagingScrollView addSubview:controller.view];
//            [controller viewDidAppear:NO];
            [_pagingScrollView sendSubviewToBack:controller.view];
            
            [_visibleControlls addObject:controller];
            [_recycledControlls removeObject:controller];// 可能是回收的, 从recycle中删掉
            if ([controller respondsToSelector:@selector(pageViewDidAddToScrollView:)]) {
                [controller pageViewDidAddToScrollView:self];
            }
        }
    }
}

- (void)tilePages
{
    if ([self tilePageIndexesChanged]) {
        [self recycleUnDisplayedControllers];
        [self addDisplayedControllers];
    }
}

- (void)refreshPageData
{
    int currentIndex = _pagingScrollView.contentOffset.x/_pagingScrollView.frame.size.width;
    if (!_isPagesInited || self.currentDisplayPageIndex!=currentIndex) {
        _currentDisplayPageIndex = currentIndex;
        
        for (UIViewController<EMMultiPagingProtocol> *controller in _visibleControlls) {
            if ([controller respondsToSelector:@selector(pageViewDidEndDecelerating:)]) {
                [controller pageViewDidEndDecelerating:self];
            }
            
            if ([controller getMultiPageIndex]==currentIndex) {
                [controller requestDatasource]; // 当前页显示时，发包
            }
            else if (ABS([controller getMultiPageIndex]-currentIndex)==1){
                [controller loadCacheData]; // 当前页两边时，取缓存
            }
        }
    }
}

- (void)deceleratingScrollView:(UIScrollView *)scrollView
                      animated:(BOOL)animated
                   sendPackage:(BOOL)canSendPackage
{
    [self tilePages];
    if (canSendPackage) {
        [self refreshPageData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self deceleratingScrollView:scrollView animated:NO sendPackage:YES];
}

- (UIViewController<EMMultiPagingProtocol> *)dequeueReusableControllerByClassName:(NSString *)className
{
    Class class = NSClassFromString(className);
    UIViewController<EMMultiPagingProtocol> *result = nil;
    for (UIViewController<EMMultiPagingProtocol> *controller in [_recycledControlls allObjects]) {
        if ([controller isMemberOfClass:class]) {
            result =  controller;
            break;
        }
    }
    return result;
}

- (UIViewController<EMMultiPagingProtocol> *)isDisplayingPageForIndex:(int)pageIndex
{
    for (UIViewController<EMMultiPagingProtocol> *controller in [_visibleControlls allObjects]) {
        if ([controller getMultiPageIndex] == pageIndex) {
            return controller;
        }
    }
    
    return nil;
}

#pragma mark - Calc frame

- (CGRect)frameForPagingScrollView {
    CGRect frame = self.view.bounds;
    frame.size.height = EMScreenHeight()-EMStatusBarHeight()-EMNavigationBarHeight()-EMTabBarHeight();
    frame.origin.x -= _padding;
    frame.size.width += (2 * _padding);
    return frame;
}

- (CGSize)contentSizeForPagingScrollView {
    CGRect bounds = _pagingScrollView.bounds;
    return CGSizeMake(bounds.size.width * [self numberOfPages]*self.loopSize , bounds.size.height);
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index {
    CGRect bounds = _pagingScrollView.bounds;
    CGRect pageFrame = bounds;
    pageFrame.size.width -= (2 * _padding);
    pageFrame.origin.x = (bounds.size.width * index) + _padding;
    return pageFrame;
}

#pragma mark - send package

- (void)requestRefresh:(CGFloat)interval
{
    [[self currentDisplayController] refreshDelay:interval];
}

- (void)updateResult
{
    [[self currentDisplayController] loadCacheData];
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // here, our pagingScrollView bounds have not yet been updated for the new interface orientation. So this is a good
    // place to calculate the content offset that we will need in the new orientation
    CGFloat offset = _pagingScrollView.contentOffset.x;
    CGFloat pageWidth = _pagingScrollView.bounds.size.width;
    if (offset >= 0) {
        _firstVisiblePageIndexBeforeRotation = floorf(offset / pageWidth);
        _percentScrolledIntoFirstVisiblePage = (offset - (_firstVisiblePageIndexBeforeRotation * pageWidth)) / pageWidth;
    } else {
        _firstVisiblePageIndexBeforeRotation = 0;
        _percentScrolledIntoFirstVisiblePage = offset / pageWidth;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // recalculate contentSize based on current orientation
    // adjust contentOffset to preserve page location based on values collected prior to location
    CGFloat pageWidth = _pagingScrollView.bounds.size.width;
    CGFloat newOffset = (_firstVisiblePageIndexBeforeRotation * pageWidth) + (_percentScrolledIntoFirstVisiblePage * pageWidth);
    _pagingScrollView.contentOffset = CGPointMake(newOffset, 0);
    _pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;// 默认不支持旋转
}



# pragma mark - Subclass overwrite

- (int)numberOfPages
{
    NSAssert(0, @"numberOfPages - Subclass overwrite");
    return 0;
}

- (UIViewController<EMMultiPagingProtocol> *)controllerAtPageIndex:(int)index
{
    NSAssert(0, @"controllerAtPageIndex - Subclass overwrite");
    return nil;
}

- (NSMutableSet *)getVisibleControllers
{
    return _visibleControlls;
}

@end

