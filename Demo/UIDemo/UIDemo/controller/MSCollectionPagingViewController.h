//
//  MSCollectionPagingViewController.h
//  UI
//
//  Created by Samuel on 15/4/17.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSBaseViewController.h"
#import "MSHorizontalCollectionView.h"

@interface MSCollectionPagingViewController : MSBaseViewController <MSHorizontalCollectionViewDelegate> {

    MSHorizontalCollectionView *_pagingView0;
    MSHorizontalCollectionView *_pagingView1;
}

@end
