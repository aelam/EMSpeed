//
//  EMPageImageView.m
//  UI
//
//  Created by Samuel on 15/4/9.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMPageImageView.h"
#import "UIImageView+emDownloadIcon.h"
#import "EMPageItem.h"

@implementation EMPageImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    
    return self;
}


- (void)updatePageView:(id <EMPageModel>)pageModel
{
    if ([pageModel isKindOfClass:[EMPageItem class]]) {
        EMPageItem *page = (EMPageItem *)pageModel;
        [self ms_setImageWithURL:[NSURL URLWithString:page.img] localCache:YES];
    }
}

@end