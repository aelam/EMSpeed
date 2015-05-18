//
//  EMStockListViewController.m
//  EMStock
//
//  Created by flora on 14-9-15.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMStockListViewController.h"
#import "EMBorderView.h"
#import "UIView+autoLayout.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "UIView+AutoLayout.h"
#import "EMPriceHeaderButton.h"
#import "MMCellModel.h"
#import "MMCellUpdating.h"


#define kStockListNameWidth 90
#define kStocklistHeaderHeight 30
#define kScrollTipLabelSize CGSizeMake(10, 24)



@interface EMStockListViewController ()
{
}
@property (nonatomic, assign) CGFloat nameWidth;
@property (nonatomic, assign) NSUInteger lastLoadingCellRow;//最后一条加载的cell的行数标示

@end

@implementation EMStockListViewController

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
        
        self.nameWidth = kStockListNameWidth;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _stockListView = [[UIView alloc] init];
    [self.view addSubview:_stockListView];
    
    [_stockListView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view em_addConstraintsWithContentInsets:_contentInsets subView:_stockListView];
    
    // Do any additional setup after loading the view.
    [self loadTableView];
}

- (UITableView *)createTitleTableView
{
    UITableView *titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    titleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    titleTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    titleTableView.contentInset = UIEdgeInsetsZero;
    titleTableView.backgroundView = nil;
    titleTableView.backgroundColor = [UIColor clearColor];
    titleTableView.showsVerticalScrollIndicator = NO;
    [titleTableView setDataSource:self];
    [titleTableView setDelegate:self];
    
    return titleTableView;
}

- (UITableView *)createContentTableView
{
    UITableView *contentTableView = [[UITableView alloc] init];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    contentTableView.contentInset = UIEdgeInsetsZero;
    contentTableView.backgroundView = nil;
    contentTableView.backgroundColor = [UIColor clearColor];
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
    contentScrollView.backgroundColor = [UIColor clearColor];
    contentScrollView.showsHorizontalScrollIndicator = NO;
    [contentScrollView setDelegate:self];
    
    return contentScrollView;
}

/**
 *创建tableView
 *视图层次，做nameTableView，右priceTableView，priceTableView 上加载priceTableView。
 *
 */
- (void)loadTableView
{
    _titleTableView = [self createTitleTableView];
    _contentTableView = [self createContentTableView];
    _contentScrollView = [self createContentScrollView];
    _scrollTipImageViewLeft = [self createLeftScrollTipLabel];
    _scrollTipImageViewRight = [self createRightScrollTipLabel];
    
    [_stockListView addSubview:_titleTableView];
    [_contentScrollView addSubview:_contentTableView];
    [_stockListView addSubview:_contentScrollView];
    [_stockListView addSubview:_scrollTipImageViewLeft];
    [_stockListView addSubview:_scrollTipImageViewRight];
    
    [self setViewLayouts];
}

- (UILabel *)createLeftScrollTipLabel
{
    CGSize tipSize = kScrollTipLabelSize;
    CGFloat originY = .5 * (kStocklistHeaderHeight - tipSize.height);
    UILabel *scrollTipImageViewLeft = [self scrollTipLabel:FAIconAngleLeft];
    scrollTipImageViewLeft.frame = CGRectMake(kStockListNameWidth-tipSize.width, originY, tipSize.width, tipSize.height);
    scrollTipImageViewLeft.hidden = YES;
    
    return scrollTipImageViewLeft;
}

- (UILabel *)createRightScrollTipLabel
{
    CGSize tipSize = kScrollTipLabelSize;
    CGFloat originY = .5 * (kStocklistHeaderHeight - tipSize.height);
    UILabel *scrollTipImageViewRight = [self scrollTipLabel:FAIconAngleRight];
    scrollTipImageViewRight.frame = CGRectMake(self.view.frame.size.width - tipSize.width, originY, tipSize.width, tipSize.height);
    
    return scrollTipImageViewRight;
}

- (UILabel *)scrollTipLabel:(FAIcon)faicon
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];;
    label.text = [NSString fontAwesomeIconStringForEnum:faicon];
    label.font = [UIFont fontAwesomeFontOfSize:24];
    return label;
}

- (void)setViewLayouts
{
    CGSize tipSize = CGSizeMake(10, 24);
    CGFloat originY = .5 * (kStocklistHeaderHeight - tipSize.height);
    
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
    [_stockListView addConstraints:tmpConstraints];
    [_stockListView em_addConstraintsWithContentInsets:UIEdgeInsetsMake(0, kStockListNameWidth, 0, 0)
                                               subView:_contentScrollView];
}


/**
 *重新加载priceHeaderView上的子视图（button）
 *先复用之前的button，后创建新的button，多余的button从原始图上移除
 *大盘指数、重点指数不支持排序
 *根据当前排序的正序、倒序分配指示箭头
 */
-(void)reloadPriceHeaderView
{
//    NSArray* buttons = [NSArray arrayWithArray:[_priceHeaderView subviews]];
//    CGFloat beginY = 0;
//    CGFloat beginX = _stockList.xSpace;
//    int reuseIndex = 0;
//    for (int i = 0; i < _stockList.fieldsCount; i++)
//    {
//        EMPriceHeaderButton *button = nil;
//        if (i < [buttons count])
//        {
//            button = [buttons objectAtIndex:i];
//            reuseIndex++;
//        }
//        else
//        {
//            button = [[EMPriceHeaderButton alloc] init];
//            [button addTarget:self action:@selector(doActionResort:) forControlEvents:UIControlEventTouchDown];
//        }
//		[button setTitle:_stockList.fieldsName[i] forState:UIControlStateNormal];
//		button.fieldSort = _stockList.fieldsSort[i];
//        button.fieldName = _stockList.fieldsName[i];
//        button.frame = CGRectMake(beginX-.5*_stockList.xSpace, beginY, _stockList.fieldsWidths[i]+_stockList.xSpace, _priceHeaderView.frame.size.height);
//        beginX += (_stockList.xSpace + _stockList.fieldsWidths[i]);
//        
//		if(_stockList.groupId != _group_zs && _stockList.groupId != _group_impzs && button.fieldSort != __sort_None)
//        {
//			if(button.fieldSort == abs(_stockList.sortId))
//            {
//                NSString *orderTag = (_stockList.sortId < 0) ? @"↑" : @"↓";
//                [button setTitle:[NSString stringWithFormat:@"%@%@", button.fieldName,orderTag]
//                        forState:UIControlStateNormal];
//                _currentOrderButton = button;
//			}
//            [button setEnabled:YES];
//		}
//		else
//        {
//            [button setEnabled:NO];
//        }
//        [_priceHeaderView addSubview:button];
//	}
//    
//    while (reuseIndex < [buttons count])
//    {
//        UIButton *button = [buttons objectAtIndex:reuseIndex];
//        [button removeFromSuperview];
//        reuseIndex++;
//    }
//
//    [_priceHeaderView  bringSubviewToFront:_scrollTipImageViewLeft];
//    [_priceHeaderView  bringSubviewToFront:_scrollTipImageViewRight];
}

- (void)didReceiveMemoryWarning
{
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && self.view.window == nil)
    {
//        [_stockList reset];
        _titleTableView.delegate    = nil;
        _titleTableView.dataSource  = nil;
        _contentTableView.delegate   = nil;
        _contentTableView.dataSource = nil;
        _contentScrollView.delegate  = nil;
        
        _stockListView = nil;
        _titleHeaderView = nil;
        _contentHeaderView = nil;
        _titleTableView = nil;
        _contentTableView = nil;
        _contentScrollView = nil;
//        _refreshHeaderView = nil;
    }
    [super didReceiveMemoryWarning];    
}

- (void)viewDidUnload
{
//    [_stockList reset];
    _titleTableView.delegate    = nil;
    _titleTableView.dataSource  = nil;
    _contentTableView.delegate   = nil;
    _contentTableView.dataSource = nil;
    _contentScrollView.delegate  = nil;
    _stockListView = nil;
    _titleHeaderView = nil;
    _contentHeaderView = nil;
    _titleTableView = nil;
    _contentTableView = nil;
    _contentScrollView = nil;
//    _refreshHeaderView = nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark -
#pragma mark sort action

-(void)doActionResort:(EMPriceHeaderButton*)button
{
//    if (_currentOrderButton && [_currentOrderButton isEqual:button] == NO)
//    {
//        [_currentOrderButton setTitle:_currentOrderButton.fieldName forState:UIControlStateNormal];
//    }
//    
//	int oldSordId = _stockList.sortId;
//	if(abs(_stockList.sortId) == abs((int)button.fieldSort))
//    {
//		_stockList.sortId = -_stockList.sortId;
//	}
//	else
//    {
//		_stockList.sortId = (int)button.fieldSort;
//	}
//    
//	if(oldSordId != _stockList.sortId)
//	{
//        if(button.fieldSort == abs(_stockList.sortId))
//        {
//            NSString *orderTag = (_stockList.sortId < 0) ? @"↑" : @"↓";
//            [button setTitle:[NSString stringWithFormat:@"%@%@", button.fieldName,orderTag]
//                    forState:UIControlStateNormal];
//        }
//        
//        [self requestDatasource];
//	}
}

#pragma mark -
#pragma mark request

/**
 *1、请求数据 _reloading 标记置为 YES
 *2、回包后将 _reloading 标记置为 NO
 *3、设置 _refreshHeaderView 完成加载
 *4、分发解析后数据，视图重新加载数据
 *5、判断是否需要自动更新行情数据
 */
- (void)requestDatasource
{
    _scrollableList.isLoading = YES;
    
   NSOperation *operation =
    [_scrollableList modelWithBlock:^(NSOperation *operation, BOOL success) {
        _scrollableList.isLoading = NO;
        [_operationArray removeObject:operation];
        
        if (success)
        {
            [self didLoadDataSource];
        }
    }];
    
    if (operation)
    {
        [_operationArray addObject:operation];
    }
}

/**
 *根据新数据加载视图
 *1、数据根据视图宽度计算每一项的数据的宽度 fieldWidth
 *2、根据计算结果重新加载priceHeaderView
 *3、加载两个 TableView
 */
- (void)didLoadDataSource
{
    CGFloat priceWidth = self.nameWidth;//[_stockList calculateWithPriceWidth:_priceScrollView.frame.size.width];
    CGRect priceRect = _contentTableView.frame;
    priceRect.size.width = priceWidth;
    _contentTableView.frame = priceRect;
    _contentScrollView.contentSize = CGSizeMake(priceWidth, _contentScrollView.frame.size.height);
    _contentHeaderView.frame = CGRectMake(0, 0, priceWidth, kStocklistHeaderHeight);
    
    [self reloadPriceHeaderView];
    
    [_titleTableView reloadData];
    [_contentTableView reloadData];
}


/**
 *加载缓存数据
 *如果有缓存且在盘后 返回NO
 *否则 返回yes
 */
- (BOOL)loadCacheData
{
    if ([_scrollableList isCached])
    {
        [self didLoadDataSource];
    }
    return NO;
}

#pragma mark -
#pragma mark UITableView datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_scrollableList numberOfRowsInSection:section];
}

/**
 *判断当前加载行是否在缓存数据区间内
 *如果超过了缓存数据区间，记录当前行
 *
 *由于通过 tableview 对象判断，区分应该加载什么数据
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_scrollableList resetDataWithCurrentRow:indexPath.row];

    if ([tableView isEqual:_titleTableView])
    {
        return [self nameTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else
    {
        return [self priceTableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)nameTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<MMCellModel> item = [_scrollableList titleItemAtIndexPath:indexPath];
    return [self tableView:tableView item:item indexPath:indexPath];
}

- (UITableViewCell *)priceTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<MMCellModel> item = [_scrollableList contentItemAtIndexPath:indexPath];
    return [self tableView:tableView item:item indexPath:indexPath];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
                          item:(id<MMCellModel>)item
                     indexPath:(NSIndexPath *)indexPath
{
    Class class = item.Class;
    
    if (class != NULL)
    {
        NSString* identifier = NSStringFromClass(class);
        id cell = (id)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        if ([cell respondsToSelector:@selector(update:indexPath:)]) {
            [cell update:item indexPath:indexPath];
        }
        else if ([cell respondsToSelector:@selector(update:)]) {
            [cell update:item];
        }
        
        if ([cell isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *aCell = cell;
            if ([aCell respondsToSelector:@selector(setLayoutMargins:)]) {
                aCell.layoutMargins = UIEdgeInsetsZero;
                aCell.preservesSuperviewLayoutMargins = NO;
            }
        }
        
        return cell;
    }
    else
    {
        return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _scrollableList.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kStocklistHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_titleTableView])
    {
        if (_titleHeaderView == nil) {
            _titleHeaderView = [[EMBorderView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kStocklistHeaderHeight)];
            _titleHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            _titleHeaderView.backgroundColor = [UIColor redColor];
            _titleHeaderView.border = EMBorderStyleBottom;
            _titleHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_titleHeaderButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [_titleHeaderButton setTitle:@"名称" forState:UIControlStateNormal];
            _titleHeaderButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            _titleHeaderButton.titleLabel.textAlignment = NSTextAlignmentLeft;
            _titleHeaderButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            _titleHeaderButton.titleEdgeInsets = UIEdgeInsetsFromString(@"{0.0,15.0f,0,0}");
            _titleHeaderButton.frame = CGRectMake(0, 0, tableView.frame.size.width, kStocklistHeaderHeight - 1);
            _titleHeaderButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [_titleHeaderView addSubview:_titleHeaderButton];
            _titleHeaderButton.userInteractionEnabled = NO;
        }
        return _titleHeaderView;
    }
    else
    {
        if (_contentHeaderView == nil)
        {
            _contentHeaderView = [[EMBorderView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kStocklistHeaderHeight)];
            _contentHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            _contentHeaderView.backgroundColor = [UIColor yellowColor];
            _contentHeaderView.border = EMBorderStyleBottom;
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
        [self didLoadDataSource];
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



@end
