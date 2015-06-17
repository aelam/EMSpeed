//
//  EMStockListViewController.m
//  EMStock
//
//  Created by flora on 14-9-15.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSScrollableListViewController.h"
#import "MSBorderView.h"
#import "UIView+autoLayout.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "UIView+AutoLayout.h"
#import "MSPriceHeaderButton.h"
#import "MSCellModel.h"
#import "MSCellUpdating.h"
#import "MSScrollableCellProtocol.h"
#import "MSTableEmptyView.h"

#define kScrollTipLabelSize CGSizeMake(10, 24)

NSString *const MSScrollableListCellSelectedNotification = @"MSScrollableListCellSelectedNotification";
NSString *const MSScrollableListCellHighlightedNotification = @"MSScrollableListCellHighlightedNotification";


@interface MSScrollableListViewController ()
{
    BOOL _autoDisplayEmptyView;
}
@property (nonatomic, assign) BOOL autoDisplayEmptyView;
@end


@implementation MSScrollableListViewController

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
        
        _scrollableList = [[MSScrollableList alloc] init];
    }
    return self;
}

- (instancetype)initWithList:(MSScrollableList *)list
{
    self = [self init];
    if (self) {
        _scrollableList = list;
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MSScrollableListCellSelectedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MSScrollableListCellHighlightedNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reloadDataSource];
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
    
    [self registerTableViewCell];
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
    [titleTableView setDelegate:self];
    
    return titleTableView;
}

- (UITableView *)createContentTableView
{
    UITableView *contentTableView = [[UITableView alloc] init];
    contentTableView.backgroundColor = [UIColor clearColor];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentTableView.contentInset = UIEdgeInsetsZero;
    contentTableView.backgroundView = nil;
    contentTableView.showsHorizontalScrollIndicator = NO;
    contentTableView.showsVerticalScrollIndicator = NO;
    contentTableView.autoresizesSubviews = YES;
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
    CGFloat originX = [_scrollableList calculateTitleTableViewWidth:_contentScrollView.frame.size.width] - tipSize.width;
    CGFloat originY = 0;//.5 * (self.tableHeaderHeight - tipSize.height);
    CGPoint origin = CGPointMake(originX, originY);
    
    UILabel *scrollTipImageViewLeft = [self scrollTipLabel:FAIconAngleLeft];
    scrollTipImageViewLeft.frame = CGRectMake(origin.x, origin.y, tipSize.width, tipSize.height);
    scrollTipImageViewLeft.hidden = YES;
    
    return scrollTipImageViewLeft;
}

- (UILabel *)createRightScrollTipLabel
{
    CGSize tipSize = kScrollTipLabelSize;
    CGFloat originY = 0;//.5 * (self.tableHeaderHeight - tipSize.height);
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

- (void)registerTableViewCell
{
    [_titleTableView registerNib:[UINib nibWithNibName:@"MSNameListCell" bundle:nil] forCellReuseIdentifier:@"MSNameListCell"];
    [_contentTableView registerNib:[UINib nibWithNibName:@"MSContentListCell" bundle:nil] forCellReuseIdentifier:@"MSContentListCell"];
}

- (void)setViewConstraints
{
    CGSize tipSize = CGSizeMake(10, 24);
    CGFloat headerHeight = [_scrollableList tableViewHeaderHeight];
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
    
    CGFloat titleTableViewWidth = [_scrollableList calculateTitleTableViewWidth:_contentScrollView.frame.size.width];
    [_backgroundView ms_addConstraintsWithContentInsets:UIEdgeInsetsMake(0, titleTableViewWidth, 0, 0)
                                                subView:_contentScrollView];
    [self.view ms_addConstraintsWithContentInsets:_contentInsets subView:_backgroundView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

#pragma mark -
#pragma mark request

/**
 *1、请求数据 _isLoading 标记置为 YES
 *2、回包后将 _isLoading 标记置为 NO
 *3、设置 _refreshHeaderView 完成加载
 *4、分发解析后数据，视图重新加载数据
 *5、判断是否需要自动更新行情数据
 */
- (void)requestDatasource
{
    _scrollableList.isLoading = YES;
    
   NSURLSessionTask *task =
    [_scrollableList modelWithBlock:^(NSURLSessionTask *task, BOOL success) {
        _scrollableList.isLoading = NO;
        [_operationArray removeObject:task];
        
        if (success)
        {
            [self reloadDataSource];
        }
    }];
    
    if (task)
    {
        [_operationArray addObject:task];
    }
}

/**
 *根据新数据加载视图
 *1、数据根据视图宽度计算每一项的数据的宽度 fieldWidth
 *2、根据计算结果重新加载priceHeaderView
 *3、加载两个 TableView
 */
- (void)reloadDataSource
{
    BOOL showEmptyView = self.autoDisplayEmptyView && [_scrollableList isEmpty];
    
    if (showEmptyView) {
        [self.view addSubview:self.emptyBackgroundView];
        self.emptyBackgroundView.hidden = NO;
    }
    else{
        self.emptyBackgroundView.hidden = YES;
        [self layoutTableView];
    
        if (_titleTableView.dataSource != _scrollableList.titleDataSource) {
            _titleTableView.dataSource = _scrollableList.titleDataSource;
        }
        
        if (_contentTableView.dataSource != _scrollableList.contentDataSource) {
            _contentTableView.dataSource = _scrollableList.contentDataSource;
        }
        
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
    if ([_scrollableList isCached])
    {
        [self reloadDataSource];
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
    CGFloat contentWidth = [_scrollableList calculateContentTableViewWidth:_contentScrollView.frame.size.width];
    CGRect contentRect = _contentTableView.frame;
    contentRect.size.width = contentWidth;
    _contentTableView.frame = contentRect;
    _contentScrollView.contentSize = CGSizeMake(contentWidth, _contentScrollView.frame.size.height);
}

-(void)layoutTableViewHeader
{
    CGFloat headerHeight = [_scrollableList tableViewHeaderHeight];
    CGFloat titleWidth = [_scrollableList calculateTitleTableViewWidth:_titleTableView.frame.size.width];
    CGFloat contentWidth = [_scrollableList calculateContentTableViewWidth:_contentScrollView.frame.size.width];
    
    _titleHeaderView.frame = CGRectMake(0, 0, titleWidth, headerHeight);
    _contentHeaderView.frame = CGRectMake(0, 0, contentWidth, headerHeight);
}

#pragma mark -
#pragma mark UITableView delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_scrollableList resetDataWithCurrentRow:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _titleTableView) {
        return [_scrollableList titleCellHeightAtIndex:indexPath];
    }
    else if (tableView == _contentTableView) {
        return [_scrollableList contentCellHeightAtIndex:indexPath];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [_scrollableList tableViewHeaderHeight];
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
                                                item:_scrollableList.titleHeaderItem
                                              height:[_scrollableList tableViewHeaderHeight]];
            _titleHeaderView = view;
        }
        
        return _titleHeaderView;
    }
    else
    {
        if (_contentHeaderView == nil) {
            UIView *view = [self headerWithTableView:tableView
                                        item:_scrollableList.contentHeaderItem
                                      height:[_scrollableList tableViewHeaderHeight]];
            _contentHeaderView = view;
        }
        
        return _contentHeaderView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *items = [_scrollableList visiableItems];
//    int current = [_scrollableList currentSelectedIndex:indexPath];

    // 接来的事情, 自己处理了好伐
}

#pragma mark -
#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *) scrollView
{
	CGPoint offset = [scrollView contentOffset];
	if(offset.x == 0 && [scrollView isKindOfClass:[UITableView class]])
	{
        UIScrollView *destinationScollView = ([scrollView isEqual:_contentTableView] ? _titleTableView : _contentTableView);
        [destinationScollView setContentOffset:offset];
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
				  willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        if ([scrollView isKindOfClass:[UITableView class]])
        {
            [self loadDataWhenUserDragDown];
        }
        else if ([scrollView isEqual:_contentScrollView])
        {
            [self updateScrollTipImageViewStatus];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]])
    {
        [self loadDataWhenUserDragDown];
    }
    else if ([scrollView isEqual:_contentScrollView])
    {
        [self updateScrollTipImageViewStatus];
    }
}

- (void)loadDataWhenUserDragDown
{
    if(_scrollableList.didNeedsRequest)
    {
        [self requestDatasource];
        _scrollableList.didNeedsRequest = NO;
    }
    else
    {
        [self reloadDataSource];
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

- (UIView *)emptyBackgroundView
{
    if (_emptyBackgroundView == nil) {
        _emptyBackgroundView = [[MSTableEmptyView alloc] initWithFrame:self.view.bounds];
    }
    
    return _emptyBackgroundView;
}

- (void)setEmptyBackgroundView:(UIView *)emptyView
{
    _emptyBackgroundView = emptyView;
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
