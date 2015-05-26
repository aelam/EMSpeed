//
//  EMSegmentControl.m
//  EMStock
//
//  Created by xoHome on 14-10-7.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMSegmentedControl.h"
#import "EMSegmentCellFactory.h"
#import "UIColor+HexString.h"
#import "MSCoreMetrics.h"
#import "EMTextSegmentCell.h"
#import "MSCore.h"


@interface EMSegmentedControl()
{
    int _willSelectedIndex;//保存即将选中的index，默认为-1
}

@end



@interface EMSegmentedControl()
{
}

@end

@implementation EMSegmentedControl

- (instancetype)initWithItems:(NSArray *)items
{
    CGFloat defaultWidth = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithFrame:CGRectMake(0, 0, defaultWidth, 35)];
    if(self)
    {
        self.backgroundColor = RGB(0xff, 0xff, 0xff);
        _selectedSegmentIndex = UISegmentedControlNoSegment;
        _willSelectedIndex = UISegmentedControlNoSegment;
        _segments = [[NSMutableArray alloc] init];
        
        self.items = items;
        
        self.selectedIndicatorStyle = EMselectedIndicatorStyleMenuTitle;
        _segmentWidths = malloc(sizeof(CGFloat)*[items count]);
        memset(_segmentWidths, 0, sizeof(CGFloat)*[items count]);
    }
    return self;
}

- (void)dealloc
{
    [_items removeAllObjects];
    [_segments removeAllObjects];
    _selectedView = nil;
    free(_segmentWidths);
}

- (void)setIndicatorBackgroundColor:(UIColor *)color
{
    _selectedView.indicatorBackgroundColor = color;
}

- (NSUInteger)numberOfSegments
{
    return [_items count];
}

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated
{
    [_items insertObject:title atIndex:segment];
    if (animated)
    {
        
    }
}

- (void)insertSegmentWithObject:(EMTextSegmentCellObject *)object  atIndex:(NSUInteger)segment animated:(BOOL)animated
{
    [_items insertObject:object atIndex:segment];
    if(animated)
    {
        
    }
}

- (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated
{
    if ([_items count] > segment)
    {
        [_items removeObjectAtIndex:segment];
    }
    
    if (animated)
    {
        
    }
}

- (void)removeAllSegments
{
    for (UIView *view in _segments)
    {
        [view removeFromSuperview];
    }
    [_items removeAllObjects];
    [_segments removeAllObjects];
    self.selectedSegmentIndex = EMSegmentedControlNoSegment;
    _selectedView.selectedRect = CGRectZero;
}

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment
{
    [_items replaceObjectAtIndex:segment withObject:title];
    
    UILabel<EMSegmentCell> *cell = [_segments objectAtIndex:segment];
    cell.text = [_items objectAtIndex:segment];
    
    [cell setNeedsDisplay];
}

- (NSString *)titleForSegmentAtIndex:(NSUInteger)segment
{
    return [_items objectAtIndex:segment];
}

- (NSString *)titleForSegmentAtCurrentIndex
{
    return [_items objectAtIndex:_selectedSegmentIndex];
}

- (void)setSegmentObject:(id)object forSegmentAtIndex:(NSUInteger)segment
{
    [_items replaceObjectAtIndex:segment withObject:object];
}

- (instancetype)segmentObjectForSegmentAtIndex:(NSUInteger)segment
{
    return [_items objectAtIndex:segment];
}

- (void)setFont:(UIFont *)font
{
    for (int i=0; i<[_segments count]; i++) {
        UILabel<EMSegmentCell> *cell = [_segments objectAtIndex:i];
        cell.font = [UIFont systemFontOfSize:16];
    }
}

- (void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment
{
    _segmentWidths[segment] = width;
}

- (CGFloat)widthForSegmentAtIndex:(NSUInteger)segment
{
    if (segment < [_segments count])
    {
        UIView *cell  = [_segments objectAtIndex:segment];
        return MAX(_segmentWidths[segment], cell.frame.size.width);
    }
    return 0;
}

- (void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment
{
    
}

- (BOOL)isEnabledForSegmentAtIndex:(NSUInteger)segment
{
    return YES;
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    if (_selectedSegmentIndex != selectedSegmentIndex)
    {
        //取消上一次的选择
        _selectedSegmentIndex = selectedSegmentIndex;
        _highlightedSegmentView.selected = NO;
        
        if (_selectedSegmentIndex < [_segments count])
        {//展现选中效果
            _highlightedSegmentView = [_segments objectAtIndex:_selectedSegmentIndex];
            _highlightedSegmentView.selected = YES;
            _selectedView.selectedRect = CGRectInset(_highlightedSegmentView.frame, 5, 0);
            NSLog(@"selectedRect = %@", NSStringFromCGRect(_selectedView.selectedRect));
            _selectedView.selectedItem = [_items objectAtIndex:_selectedSegmentIndex];
        }
        
        if (selectedSegmentIndex != EMSegmentedControlNoSegment)
        {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (void)setSelectedIndicatorStyle:(EMSegmentSelectedIndicatorStyle)style
{
    _selectedIndicatorStyle = style;
    _selectedView.style = style;
    
    if (_selectedView) {
        [_selectedView removeFromSuperview];
    }
    
    _selectedView = [[[self selectedViewClassWithStyle:style] alloc] init];
    [self addSubview:_selectedView];
}


- (Class)selectedViewClassWithStyle:(EMSegmentSelectedIndicatorStyle)style
{
    if (style == EMselectedIndicatorStyleMenuTitle) {
        return [EMSegmentSelectedIndicatorArrowBar class];
    }
    else if (style == EMselectedIndicatorStyleMenuContent) {
        return [EMSegmentSelectedIndicatorArrowLine class];
    }

    // add more style here...
    
    return nil;
}

#pragma mark -
#pragma mark load items

- (void)setItems:(NSArray *)items
{
    [self removeAllSegments];
    if (_items == nil)
    {
        _items = [[NSMutableArray alloc] init];
    }
    [_items removeAllObjects];
    [_items addObjectsFromArray:items];
    
    [self updateItems];
}

- (void)updateItems
{
    CGFloat maxTitleWidth = 0;
    NSUInteger count = [_items count];

    for (int i = 0; i < count; i++)
    {
        id object = [_items objectAtIndex:i];
        UIView<EMSegmentCell> *cell =  [[self segmentCellFactoryClass] segmentCellForSegmentControl:self atIndex:i withObject:object];
        cell.userInteractionEnabled = NO;
        [self addSubview:cell];
        [_segments addObject:cell];
        
        if ([object isKindOfClass:[NSString class]])
        {
            CGFloat textWidth = [(NSString *)object sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
            maxTitleWidth = MAX(maxTitleWidth, textWidth);
        }
    }
    
    _selectedView.fixedWidth = maxTitleWidth;
    [self bringSubviewToFront:_selectedView];
    [self setNeedsLayout];
}

- (Class)segmentCellFactoryClass
{
    return [EMSegmentCellFactory class];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _selectedView.frame = self.bounds;
    
    CGFloat totalWidth = 0;
    int averageCount = 0;
    
    for (int i = 0; i < [_items count]; i++)
    {
        if (_segmentWidths[i] > 0)
        {
            totalWidth += _segmentWidths[i];
        }
        else
        {
            averageCount++;
        }
    }

    CGFloat width = 0;
    if (averageCount)
    {
        width = (self.frame.size.width - totalWidth) / averageCount;
    }
    CGFloat begin_x = 0;
    
    for (int i = 0;  i < [_segments count] ; i++)
    {
        CGFloat cellWidth = width;
        if (_segmentWidths[i] > 0)
        {
            cellWidth = _segmentWidths[i];
        }
        
        UIView<EMSegmentCell> *view = [_segments objectAtIndex:i];
        view.frame = CGRectMake(begin_x, 0, cellWidth, self.frame.size.height);
        begin_x += cellWidth;

        if (i == _selectedSegmentIndex)
        {
            CGRect frame = view.frame;
            frame.origin.x += 5;
            frame.size.width -= 10;
            _selectedView.selectedRect = frame;
            _selectedView.selectedItem = [_items objectAtIndex:_selectedSegmentIndex];
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
}

#pragma mark -
#pragma mark actions

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    //表现一个按下的效果
    CGPoint location = [touch locationInView:self];
    for (int i = 0; i < [_segments count]; i++)
    {
        UIView *view = [_segments objectAtIndex:i];
        if (CGRectContainsPoint(view.frame, location))
        {
            _willSelectedIndex = i;
            break;
        }
    }
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    //确认按下
    if (_willSelectedIndex != UISegmentedControlNoSegment)
    {
        self.selectedSegmentIndex = _willSelectedIndex;
        _willSelectedIndex = UISegmentedControlNoSegment;
    }
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    _willSelectedIndex = UISegmentedControlNoSegment;
    [super cancelTrackingWithEvent:event];
}

- (void)reload
{
    [_segments removeAllObjects];
    [self updateItems];
}

- (void)setSelectedSegmentIndexWithTitle:(NSString *)title
{
    for (int i=0; i<[_items count]; i++) {
        NSString *item = [_items objectAtIndex:i];
        if ([item isEqualToString:title]) {
            self.selectedSegmentIndex = i;
            return;
        }
    }
    
    self.selectedSegmentIndex = UISegmentedControlNoSegment;
}


@end

