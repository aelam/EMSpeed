//
//  EMRefreshTableHeaderView.h
//  EMStock
//
//  Created by xoHome on 14-11-3.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

#define EMRefreshTableHeaderView_HEIGHT 65

typedef enum{
    EMPullRefreshPulling = 0,
    EMPullRefreshNormal,
    EMPullRefreshLoading,
} EMPullRefreshState;

typedef enum
{
    EMRefreshViewStyleWhite,
    EMRefreshViewStyleGray
}EMRefreshViewStyle;

@class MSRefreshTableHeaderView;
@protocol EMRefreshTableHeaderViewDelegate
- (void)emRefreshTableHeaderDidTriggerRefresh:(MSRefreshTableHeaderView*)view;
- (BOOL)emRefreshTableHeaderDataSourceIsLoading:(MSRefreshTableHeaderView*)view;
@optional
- (NSDate*)emRefreshTableHeaderDataSourceLastUpdated:(MSRefreshTableHeaderView*)view;
@end


@interface MSRefreshTableHeaderView : UIView {
    
    id __unsafe_unretained _delegate;
    EMPullRefreshState _state;
    
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
    UIImageView *_arrowImage;
    UIActivityIndicatorView *_activityView;
}

@property (nonatomic, assign) id delegate;


- (id)initWithFrame:(CGRect)frame;

- (void)refreshLastUpdatedDate;
- (void)emRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)emRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)emRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

- (void)setArrowImage:(UIImage *)image;

@end


@interface EMAnimatedImagesRefreshTableHeaderView : MSRefreshTableHeaderView {
    
    UIImageView *_animtedImageView;
}

- (id)initWithFrame:(CGRect)frame
             images:(NSArray *)images;

@end






