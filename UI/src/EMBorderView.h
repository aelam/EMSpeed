//
//  EMBorderView.h
//  EMStock
//
//  Created by xoHome on 14-9-30.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  可选边缘线显示 枚举类型
 */
typedef NS_OPTIONS(NSUInteger, EMBorderStyle){
    EMBorderStyleNone   = 0,
    EMBorderStyleLeft   = 1 << 0,
    EMBorderStyleRight  = 1 << 1,
    EMBorderStyleTop    = 1 << 2,
    EMBorderStyleBottom = 1 << 3,
    EMBorderStyleAll    = ~0UL
};

/**
 *  可有边缘线的视图
 */
@interface EMBorderView : UIView


/**
 *  边缘线的插入位置
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;


/**
 *  边缘线显示枚举类型
 */
@property (nonatomic, assign) EMBorderStyle border;


/**
 *  边缘线颜色
 */
@property (nonatomic, strong) UIColor *borderColor;


@end
