//
//  EMSrollSegmentedControl.m
//  EMStock
//
//  Created by flora on 14-10-11.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMSrollSegmentedControl.h"
#import "EMSegmentCellFactory.h"
#import "EMCore.h"

@implementation EMSrollSegmentedControl

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = self.backgroundColor;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        
        _selectedView = [[EMSegmentSelectedIndicatorView alloc] init];
        _selectedView.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:_selectedView];
        
        _segments = [[NSMutableArray alloc] init];
        self.items = items;
        
        self.selectedIndicatorStyle = EMselectedIndicatorStyleMenuTitle;
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapScrollView:)];
        recognizer.delegate = self;
        recognizer.numberOfTapsRequired = 1;
        [_scrollView addGestureRecognizer:recognizer];
        
        self.backgroundColor = RGB(0xff, 0xff, 0xff);
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    _scrollView.backgroundColor = backgroundColor;
}

- (void)updateItems
{
    NSUInteger count = [_items count];
    
    for (int i = 0; i < count; i++)
    {
        UIView<EMSegmentCell> *cell =  [[self segmentCellFactoryClass] segmentCellForSegmentControl:self atIndex:i withObject:[_items objectAtIndex:i]];
        cell.userInteractionEnabled = NO;
        [_scrollView addSubview:cell];
        [_segments addObject:cell];
        
        if (self.selectedSegmentIndex == i)
        {
            cell.selected = YES;
        }
    }
    
    [_scrollView bringSubviewToFront:_selectedView];
    [self setNeedsLayout];
}

/**
 *每一页显示的个数
 */
- (NSUInteger)itemsCountOfOnePage
{
    NSUInteger countOfOnePage =  [_segments count];
    
    if (countOfOnePage > self.pageMaxCount && self.pageMaxCount > 0)
    {
        countOfOnePage = self.pageMaxCount;
    }
    return countOfOnePage;
}

- (void)layoutSubviews
{
    NSUInteger pageCount =  [self itemsCountOfOnePage];
    
    CGFloat width = self.frame.size.width / pageCount;
    CGFloat begin_x = 0;
    
    for (int i = 0;  i < [_segments count] ; i++)
    {
        UIView<EMSegmentCell> *view = [_segments objectAtIndex:i];
        view.frame = CGRectMake(begin_x, 0, width, self.frame.size.height);
        begin_x += width;
        
        if (i == self.selectedSegmentIndex)
        {
            _selectedView.selectedRect = view.frame;
        }
        if (self.didNeedsSeperateLine && [view respondsToSelector:@selector(seperateLayer)])
        {
            if (i < [_segments count] - 1)
            {
                view.seperateLayer.hidden = NO;
            }
            else
            {
                view.seperateLayer.hidden = YES;
            }
        }
    }
    
    _scrollView.frame = self.bounds;
    _scrollView.contentSize = CGSizeMake(begin_x, self.frame.size.height);
    _selectedView.frame = CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height);
}

- (void)didTapScrollView:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:_scrollView];

    NSInteger pageCount =  [self itemsCountOfOnePage];
    CGFloat width = self.frame.size.width / pageCount;
    NSUInteger index = (int)(location.x/width);

    if (self.selectedSegmentIndex != index)
    {
        self.selectedSegmentIndex = index;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
}

@end

