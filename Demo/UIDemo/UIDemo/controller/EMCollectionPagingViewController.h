//
//  EMCollectionPagingViewController.h
//  UI
//
//  Created by Samuel on 15/4/17.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMBaseViewController.h"
#import "EMHorizontalCollectionView.h"

@interface EMCollectionPagingViewController : EMBaseViewController <EMHorizontalCollectionViewDelegate> {

    EMHorizontalCollectionView *_pagingView0;
    EMHorizontalCollectionView *_pagingView1;
}

@end
