//
//  EMHorizontalPagingView.h
//  Coll
//
//  Created by Samuel on 15/4/16.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMCollectionDataSource;
@protocol MMCollectionCellModel;


typedef NS_ENUM(NSUInteger, EMHorizontalPagingControlAlignment)
{
    EMHorizontalPagingControlAlignmentLeft,
    EMHorizontalPagingControlAlignmentCenter,
    EMHorizontalPagingControlAlignmentRight,
};


@class EMHorizontalCollectionView;

@protocol EMHorizontalCollectionViewDelegate <NSObject>

- (void)EMHorizontalCollectionView:(EMHorizontalCollectionView *)collectionView
                       didTapModel:(id<MMCollectionCellModel>)model
                       atIndexPath:(NSIndexPath *)indexPath;
@end


@interface EMHorizontalCollectionView : UIView <UICollectionViewDelegate, UIScrollViewDelegate>{
    
    UICollectionView *_collectionView;
    UIPageControl *_pageControl;
    MMCollectionDataSource *_dataSource;
    
    EMHorizontalPagingControlAlignment _alignment;
    UIEdgeInsets _pageControlEdgeInsets;
    
    __unsafe_unretained id<EMHorizontalCollectionViewDelegate> _delegate;
}

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic, assign) BOOL enablePageControl;

@property (nonatomic, strong) MMCollectionDataSource *dataSource;
@property (nonatomic, assign) EMHorizontalPagingControlAlignment alignment;
@property (nonatomic, assign) UIEdgeInsets pageControlEdgeInsets;

@property (nonatomic, assign) id<EMHorizontalCollectionViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end