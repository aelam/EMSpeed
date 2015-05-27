//
//  EMIconTextStatusBar.h
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSStatusBarUpdating.h"


@interface MSIconTextStatusBar : UIView <MSStatusBarUpdating>
@property (nonatomic, strong) UIImageView *imgvIcon;
@property (nonatomic, strong) UILabel *titleLabel;


- (void)updateStatusBar:(id<MSStatusBarModel>)model;

@end