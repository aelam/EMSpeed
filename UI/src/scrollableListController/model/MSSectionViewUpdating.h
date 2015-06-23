//
//  MSSectionViewUpdating.h
//  EMStock
//
//  Created by Mac mini 2012 on 15/6/21.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSectionViewModel.h"

@protocol MSSectionViewUpdating <NSObject>

@required
- (void)update:(id<MSSectionViewModel>)sectionViewModel;

@optional
- (void)update:(id<MSSectionViewModel>)sectionViewModel section:(int)section;


@end
