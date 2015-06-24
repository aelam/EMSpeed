//
//  EMStockListViewController.m
//  EMStock
//
//  Created by flora on 14-9-15.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSScrollableListViewController.h"
#import "MSBorderView.h"
#import "UIView+AutoLayout.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "MSPriceHeaderButton.h"
#import "MSCellModel.h"
#import "MSCellUpdating.h"
#import "MSScrollableCellProtocol.h"
#import "MSTableEmptyView.h"

#define kScrollTipLabelSize CGSizeMake(10, 24)
#define kDefaultHeaderHeight 30

NSString *const MSScrollableListCellSelectedNotification = @"MSScrollableListCellSelectedNotification";
NSString *const MSScrollableListCellHighlightedNotification = @"MSScrollableListCellHighlightedNotification";


@implementation MSScrollableListViewController

@synthesize scrollableList = _scrollableList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.autoDisplayEmptyView = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCellChangeSelectStatus:) name:MSScrollableListCellSelectedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCellChangeHighligtedStatus:) name:MSScrollableListCellHighlightedNotification object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MSScrollableListCellSelectedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MSScrollableListCellHighlightedNotification object:nil];
}

- (void)loadView
{
    [super loadView];
    [self loadTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

/**
 *创建tableView
 *视图层次，做nameTableView，右priceTableView，priceTableView 上加载priceTableView。
 *
 */
- (void)loadTableView
{
    _backgroundView = [self createBackgroundView];
    _titleTableView = [self createTitleTableView];
    _contentTableView = [self createContentTableView];
    _contentScrollView = [self createContentScrollView];
    _scrollTipImageViewLeft = [self createLeftScrollTipLabel];
    _scrollTipImageViewRight = [self createRightScrollTipLabel];
    
    [self.view addSubview:_backgroundView];
    [_backgroundView addSubview:_titleTableView];
    [_backgroundView addSubview:_contentScrollView];
    [_contentScrollView addSubview:_contentTableView];
    [_backgroundView addSubview:_scrollTipImageViewLeft];
    [_backgroundView addSubview:_scrollTipImageViewRight];
    
    [self tableViewDidRegisterTableViewCell];
    [self setViewConstraints];
}

- (UIView *)createBackgroundView
{
    UIView *listBackgroundView = [[UIView alloc] init];
    return listBackgroundView;
}

- (UITableView *)createTitleTableView
{
    UITableView *titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    titleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    titleTableView.autoresizingMask = UIViewAutoresizingNone;
    titleTableView.contentInset = UIEdgeInsetsZero;
    titleTableView.backgroundView = nil;
    titleTableView.showsVerticalScrollIndicator = NO;
    [titleTableView setDataSource:self];
    [titleTableView setDelegate:self];
    
    return titleTableView;
}

- (UITableView *)createContentTableView
{
    UITableView *contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    contentTableView.backgroundColor = [UIColor clearColor];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.contentInset = UIEdgeInsetsZero;
    contentTableView.backgroundView = nil;
    contentTableView.showsHorizontalScrollIndicator = NO;
    contentTableView.showsVerticalScrollIndicator = NO;
    contentTableView.autoresizesSubviews = YES;
    [contentTableView setDataSource:self];
    [contentTableView setDelegate:self];
    
    return contentTableView;
}

- (UIScrollView *)createContentScrollView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.showsHorizontalScrollIndicator = NO;
    [contentScrollView setDelegate:self];
    
    return contentScrollView;
}

- (UILabel *)createLeftScrollTipLabel
{
    CGSize tipSize = kScrollTipLabelSize;
    CGFloat originX = self.scrollableList.titleWidth;
    CGFloat originY = 0;
    CGPoint origin = CGPointMake(originX, originY);
    
    UILabel *scrollTipImageViewLeft = [self scrollTipLabel:FAIconAngleLeft];
    scrollTipImageViewLeft.frame = CGRectMake(origin.x, origin.y, tipSize.width, tipSize.height);
    scrollTipImageViewLeft.hidden = YES;
    
    return scrollTipImageViewLeft;
}

- (UILabel *)createRightScrollTipLabel
{
    CGSize tipSize = kScrollTipLabelSize;
    CGFloat originY = 0;
    UILabel *scrollTipImageViewRight = [self scrollTipLabel:FAIconAngleRight];
    scrollTipImageViewRight.frame = CGRectMake(self.view.frame.size.width - tipSize.width, originY, tipSize.width, tipSize.height);
    
    return scrollTipImageViewRight;
}

- (UILabel *)scrollTipLabel:(FAIcon)faicon
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];;
    label.text = [NSString fontAwesomeIconStringForEnum:faicon];
    label.font = [UIFont fontAwesomeFontOfSize:24];
    return label;
}

- (void)tableViewDidRegisterTableViewCell
{
    [_titleTableView registerNib:[UINib nibWithNibName:@"MSNameListCell" bundle:nil] forCellReuseIdentifier:@"MSNameListCell"];
    [_contentTableView registerNib:[UINib nibWithNibName:@"MSContentListCell" bundle:nil] forCellReuseIdentifier:@"MSContentListCell"];
}

- (void)setViewConstraints
{
    CGSize tipSize = kScrollTipLabelSize;
    CGFloat headerHeight = self.scrollableList.headerHeight;
    if (headerHeight==0) {
        headerHeight = kDefaultHeaderHeight;
    }
    CGFloat originY = .5 * (headerHeight - tipSize.height);
    
    [_backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_contentScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_scrollTipImageViewRight setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSString *tipRightFormatString = [NSString stringWithFormat:@"|-(>=30)-[_scrollTipImageViewRight(==%d)]-0-|",(int)tipSize.width];
    NSString *VtipRightFormatString = [NSString stringWithFormat:@"V:|-%f-[_scrollTipImageViewRight(==%d)]",originY,(int)tipSize.height];
    
    NSMutableArray *tmpConstraints = [NSMutableArray array];
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:tipRightFormatString
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(_scrollTipImageViewRight)]];
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:VtipRightFormatString
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(_scrollTipImageViewRight)]];
    [_backgroundView addConstraints:tmpConstraints];
    
//    CGFloat titleTableViewWidth = self.scrollableList.titleWidth;
//    [_backgroundView ms_addConstraintsWithContentInsets:UIEdgeInsetsMake(0, titleTableViewWidth, 0, 0)
//                                                subView:_contentScrollView];
    [self.view ms_addConstraintsWithContentInsets:_contentInsets subView:_backgroundView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect rect = self.view.bounds;
    
    CGRect curRect = _backgroundView.frame;
    curRect = UIEdgeInsetsInsetRect(rect, _contentInsets);
    _backgroundView.frame = curRect;
    
    int width = curRect.size.width;
    int height = curRect.size.height;
    _titleTableView.frame = CGRectMake(0, 0, width, height);
    
    _contentScrollView.frame = CGRectMake(self.scrollableList.titleWidth, 0, width - self.scrollableList.titleWidth, height);
    curRect.origin = CGPointZero;
    curRect.size.width = MAX(_contentScrollView.contentSize.width, _contentScrollView.frame.size.width);
    curRect.size.height = MAX(_contentScrollView.contentSize.height, _contentScrollView.frame.size.height);
    _contentTableView.frame = curRect;
}

- (void)reloadPages:(MSScrollableList *)model
{
    if (self.autoDisplayEmptyView && [self.scrollableList isEmpty]) {
        [self.view addSubview:self.emptyView];
        self.emptyView.hidden = NO;
    }
    else{
        [self emptyView].hidden = YES;
        
//        if (_titleTableView.dataSource != model.titleDataSource) {
            _titleTableView.dataSource = model.titleDataSource;
//        }
    
//        if (_contentTableView.dataSource != model.contentDataSource) {
            _contentTableView.dataSource = model.contentDataSource;
//        }
        
        [self layoutTableView];
        
        [_titleTableView reloadData];
        [_contentTableView reloadData];
    }
}

/**
 *加载缓存数据
 *如果有缓存且在盘后 返回NO
 *否则 返回yes
 */
- (BOOL)loadCachedData
{
    if ([self.scrollableList isCached])
    {
        [self reloadPages:self.scrollableList];
    }
    
    return NO;
}

- (void)layoutTableView
{
    [self layoutTableViews];
    [self layoutTableViewHeader];
}

- (void)layoutTableViews
{
    CGFloat contentWidth = self.scrollableList.contentWidth;
    
    CGRect contentRect = _contentTableView.frame;
    contentRect.size.width = contentWidth;
    _contentTableView.frame = contentRect;
    _contentScrollView.contentSize = CGSizeMake(contentWidth, _contentScrollView.frame.size.height);
}

-(void)layoutTableViewHeader
{
    CGFloat headerHeight = self.scrollableList.headerHeight;
    CGFloat titleWidth = self.scrollableList.titleWidth;
    CGFloat contentWidth = self.scrollableList.contentWidth;
    
    _titleHeaderView.frame = CGRectMake(0, 0, titleWidth, headerHeight);
    _contentHeaderView.frame = CGRectMake(0, 0, contentWidth, headerHeight);
}


#pragma mark -
#pragma mark UITableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGFloat numberOfRows = [self.scrollableList numberOfRowsInSection:section];
    return numberOfRows;
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.scrollableList cellHeightAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.scrollableList.headerHeight;
}

- (UIView *)headerWithTableView:(UITableView *)tableView
                           item:(id<MSCellModel>)item
                         height:(CGFloat)headerHeight
{
    UIView *view = nil;
    if (item.isRegisterByClass) {
        view = [[item.Class alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
    }
    else{
        if (item && [item.reuseIdentify length] > 0) {
            UINib *nib = [UINib nibWithNibName:item.reuseIdentify bundle:[NSBundle mainBundle]];
            view = [[nib instantiateWithOwner:self options:0] lastObject];
        }
    }
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_titleTableView])
    {
        if (_titleHeaderView == nil) {
            UIView *view = [self headerWithTableView:tableView
                                                item:self.scrollableList.titleHeaderItem
                                              height:self.scrollableList.headerHeight];
            
            _titleHeaderView = view;
        }
        
        [_titleHeaderView update:self.scrollableList.titleHeaderItem];
        
        return _titleHeaderView;
    }
    else
    {
        if (_contentHeaderView == nil) {
            UIView *view = [self headerWithTableView:tableView
                                        item:self.scrollableList.contentHeaderItem
                                      height:self.scrollableList.headerHeight];
            _contentHeaderView = view;
        }
        
        [_contentHeaderView update:self.scrollableList.contentHeaderItem];
        return _contentHeaderView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 接来的事情, 自己处理了
}

#pragma mark -
#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *) scrollView
{
    CGPoint pt = [scrollView contentOffset];
    if(pt.x == 0)
    {
        if(scrollView == _contentTableView)
        {
            [_titleTableView setContentOffset:pt];
        }
        else if(scrollView == _titleTableView)
        {
            [_contentTableView setContentOffset:pt];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
				  willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        if ([scrollView isEqual:_contentScrollView])
        {
            [self updateScrollTipImageViewStatus];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_contentScrollView])
    {
        [self updateScrollTipImageViewStatus];
    }
}

- (void)updateScrollTipImageViewStatus
{
    if (_contentTableView.contentOffset.y < -5)
    {
        _scrollTipImageViewLeft.hidden = YES;
        _scrollTipImageViewRight.hidden = YES;
    }
    else
    {
        CGPoint contentoffset = _contentScrollView.contentOffset;
        _scrollTipImageViewLeft.hidden = (contentoffset.x > 0) ? NO : YES;
        _scrollTipImageViewRight.hidden = (contentoffset.x + _contentScrollView.frame.size.width >= _contentScrollView.contentSize.width) ? YES : NO;
    }
}

#pragma mark -
#pragma mark high light notification

- (void)didCellChangeSelectStatus:(NSNotification *)notification
{
    UITableViewCell<MSScrollableCellProtocol> *currentCell = notification.object;
    
    UITableView *otherTableView = currentCell.isTitleTableViewCell ? _contentTableView : _titleTableView;
    
    if (currentCell.selected)
    {
        [otherTableView selectRowAtIndexPath:currentCell.indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
        [otherTableView deselectRowAtIndexPath:currentCell.indexPath animated:NO];
    }
}

- (void)didCellChangeHighligtedStatus:(NSNotification *)notification
{
    UITableViewCell<MSScrollableCellProtocol> *currentCell = notification.object;
    UITableView *otherTableView = currentCell.isTitleTableViewCell ? _contentTableView : _titleTableView;
    
    UITableViewCell *cell = [otherTableView cellForRowAtIndexPath:currentCell.indexPath];
	[cell setHighlighted:currentCell.highlighted];
}

# pragma mark - EmptyView

- (UIView *)emptyView
{
    if (_emptyView == nil) {
        _emptyView = [[MSTableEmptyView alloc] initWithFrame:self.view.bounds];
    }
    
    return _emptyView;
}

- (void)setEmptyView:(UIView *)emptyView
{
    _emptyView = emptyView;
}


- (BOOL)isEmpty
{
    return [self.scrollableList isEmpty];
}


#pragma mark -
#pragma mark Memory Warning

- (void)didReceiveMemoryWarning
{
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && self.view.window == nil)
    {
        _titleTableView.delegate    = nil;
        _titleTableView.dataSource  = nil;
        _contentTableView.delegate   = nil;
        _contentTableView.dataSource = nil;
        _contentScrollView.delegate  = nil;
        
        _backgroundView = nil;
        _titleHeaderView = nil;
        _contentHeaderView = nil;
        _titleTableView = nil;
        _contentTableView = nil;
        _contentScrollView = nil;
    }
    [super didReceiveMemoryWarning];
}

@end
