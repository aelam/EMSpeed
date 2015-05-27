//
//  MSCellModel.h
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-27.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  cell的viewmodel, 一个cell对应一个cellModel
 */

@protocol MSCellModel <NSObject>


/**
 *  cell的高度
 */
@property (nonatomic, assign) float height;


/**
 *  cellmodel对应的cell的类
 */
@property (nonatomic, strong) Class Class;


/**
 *  cell的重用名
 */
@property (nonatomic, strong) NSString *reuseIdentify;


/**
 *  cell是否通过class注册, 默认是NO, 建议使用Xib创建, 效率高, 且不用设置这个参数
 */
@property (nonatomic, assign) BOOL isRegisterByClass;

@optional

/**
 *  计算cell的高度
 *
 *  @return 高度
 */
- (float)calculateHeight;

/**
 *  处理成cell model
 *
 *  @param item 数据
 */
- (void)parseItem:(id)item;

@end

