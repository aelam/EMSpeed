//
//  MSIconTextStatusBarData.h
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSStatusBarModel.h"

@interface MSStatusBarIconTextModel : NSObject<MSStatusBarModel>

@property (nonatomic, strong) NSString *iconName;// 图标

- (UIView<MSStatusBarUpdating> *)statusBarWithData:(id<MSStatusBarModel>)data;

@end
