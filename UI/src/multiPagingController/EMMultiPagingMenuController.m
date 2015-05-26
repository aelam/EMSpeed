//
//  EMMultiPagingMenuController.m
//  EMStock
//
//  Created by Mac mini 2012 on 14-4-21.
//
//

#import "EMMultiPagingMenuController.h"
#import "EMMultiPagingSubclass.h"

#import "MSCoreFunction.h"
#import "MSCoreMetrics.h"
//#import "EMInfoMacros.h"

@interface EMMultiPagingMenuController ()

@end

@implementation EMMultiPagingMenuController

- (void)dealloc
{
}

-(void)loadView
{
    [super loadView];
}

- (void)createMenu
{
    if (_menu==nil) {
        _pageTitles = [[self titlesOfPages] copy];
        _menu = [[EMMultiPagingMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kMultiPagingMenuBarHeight)
                                                  titles:_pageTitles
                                                editable:NO];
        _menu.delegate = self;
        _menu.clipsToBounds = YES;
    }
    [self.view addSubview:_menu];
}

- (NSArray *)titlesOfPages
{
    NSAssert(0, @"titlesOfPages - Subclass overwrite");
    return nil;
}

- (void)createPages
{
    [super createPages];
    [self.view bringSubviewToFront:_menu];
}

- (void)reloadMenuAndPages
{
    [self clearOldSubViews];
    [self createScrollView];
    [self createMenu];
    [self createPages];
}

- (void)reloadData
{
    [self reloadMenuAndPages];
    _currentDisplayPageIndex = 0;
}


- (void)clearOldSubViews
{
    [super clearOldSubViews];
    [_menu removeFromSuperview];
    _menu = nil;
}

- (void)setMenuHidden:(BOOL)hidden
{
    _isMenuHidden = hidden;
    [self viewDidLayoutSubviews];
}

- (void)viewDidLayoutSubviews
{
    if (_isMenuHidden) {
        _menu.frame = CGRectZero;
    }
    else{
        _menu.frame = CGRectMake(0, 0, self.view.frame.size.width, kMultiPagingMenuBarHeight);
    }
}

- (void)deceleratingScrollView:(UIScrollView *)scrollView
                      animated:(BOOL)animated
                   sendPackage:(BOOL)canSendPackage
{
    [super deceleratingScrollView:scrollView animated:animated sendPackage:canSendPackage];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    float calcOffset = scrollView.contentOffset.x + MSScreenWidth()/2;
//    NSLog(@"w = %.f", scrollView.contentSize.width);
    calcOffset = (calcOffset > scrollView.contentSize.width) ? scrollView.contentSize.width : calcOffset;
    int currentIndex = calcOffset/scrollView.frame.size.width;
    if (currentIndex != _menu.selectedIndex)
    {
        [_menu setCurrentMenuIndex:currentIndex animated:YES];
    }
}

- (CGRect)frameForPagingScrollView {
    CGRect frame = self.view.bounds;
    frame.size.height = MSScreenHeight()-MSStatusBarHeight()-MSNavigationBarHeight()-MSTabBarHeight();
    frame.origin.x -= _padding;
    frame.size.width += (2 * _padding);
    frame.origin.y = _menu.hidden? 0 : kMultiPagingMenuBarHeight;
    frame.size.height -= _menu.hidden? 0 : kMultiPagingMenuBarHeight;
    return frame;
}

# pragma mark - InfoMenuDelegate

- (void)EMMultiPagingMenuDidPressed:(EMMultiPagingMenu *)infoMenu
                            atIndex:(NSUInteger)index
{
    CGPoint origin = CGPointMake([self frameForPageAtIndex:index].origin.x-_padding,
                                 [self frameForPageAtIndex:index].origin.y);
    [_pagingScrollView setContentOffset:origin];
    if (CGPointEqualToPoint(origin, _pagingScrollView.contentOffset)) {
        [self scrollViewDidEndDecelerating:_pagingScrollView];
    }
    
    [_menu setCurrentMenuIndex:index animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
