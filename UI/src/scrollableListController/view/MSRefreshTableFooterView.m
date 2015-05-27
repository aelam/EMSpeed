//
//  EMRefreshTableFooterView.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-14.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSRefreshTableFooterView.h"

@implementation MSRefreshTableFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _lastUpdatedLabel.frame = CGRectMake(0.0f, 30.0f, self.frame.size.width, 20.0f);
        _statusLabel.frame = CGRectMake(0.0f, 10.0f, self.frame.size.width, 20.0f);
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    _lastUpdatedLabel.frame = CGRectMake(0.0f, 30.0f, self.frame.size.width, 20.0f);
//    _statusLabel.frame = CGRectMake(0.0f, 10.0f, self.frame.size.width, 20.0f);
}

- (void)refreshLastUpdatedDate {
    
    if ([_delegate respondsToSelector:@selector(emRefreshTableFooterDataSourceLastUpdated:)]) {
        
        NSDate *date = [_delegate emRefreshTableFooterDataSourceLastUpdated:self];
        
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:date]];
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EMRefreshTableView_LastRefresh"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        
        _lastUpdatedLabel.text = nil;
        
    }
    
}

- (void)emRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_state == EMPullRefreshLoading) {
        CGFloat offset = MAX(scrollView.contentOffset.y- (scrollView.contentSize.height - scrollView.frame.size.height), 0);
        offset = MIN(offset, 60);
        UIEdgeInsets e = scrollView.contentInset;
        e.bottom = offset;
        scrollView.contentInset = e;
        
    } else if (scrollView.isDragging) {
        BOOL _loading = NO;
        
        if ([_delegate respondsToSelector:@selector(emRefreshTableFooterDataSourceIsLoading:)]) {
            _loading = [_delegate emRefreshTableFooterDataSourceIsLoading:self];
        }
        
        if (_state == EMPullRefreshPulling && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height + EMRefreshTableHeaderView_HEIGHT) && !_loading) {
            [self setState:EMPullRefreshNormal];
        } else if (_state == EMPullRefreshNormal && scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + EMRefreshTableHeaderView_HEIGHT) && !_loading) {
            [self setState:EMPullRefreshPulling];
        }
        
        if (scrollView.contentInset.bottom != 0) {
            UIEdgeInsets e = scrollView.contentInset;
            e.bottom = 0;
            scrollView.contentInset = e;
        }
    }
}

- (void)emRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
    BOOL _loading = NO;
    if ([_delegate respondsToSelector:@selector(emRefreshTableFooterDataSourceIsLoading:)]) {
        _loading = [_delegate emRefreshTableFooterDataSourceIsLoading:self];
    }
    
    if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + EMRefreshTableHeaderView_HEIGHT) && !_loading) {
        
        if ([_delegate respondsToSelector:@selector(emRefreshTableFooterDidTriggerRefresh:)]) {
            [_delegate emRefreshTableFooterDidTriggerRefresh:self];
        }
        
        [self setState:EMPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationBeginsFromCurrentState:YES];
        UIEdgeInsets e = scrollView.contentInset;
        e.bottom = 60.f;
        scrollView.contentInset = e;
        [UIView commitAnimations];
    }
}

- (void)emRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.6];
    [UIView setAnimationBeginsFromCurrentState:YES];
    UIEdgeInsets e = scrollView.contentInset;
    e.bottom = 0;
    [scrollView setContentInset:e];
    [UIView commitAnimations];
    
    [self setState:EMPullRefreshNormal];
}




@end