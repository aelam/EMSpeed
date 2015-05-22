//
//  EMParseableObjectCellModel.h
//  MMTableViewDemo
//
//  Created by Samuel on 15/4/29.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "EMParseableObject.h"
#import "MMCellModel.h"
#import "EMParseableObject+CellModel.h"

@protocol EMCellModelParser <EMParser>

@optional

/**
 *  获取cell model
 *
 *  @param dictionary JSON数据
 *  @param cls        对应的cell model class
 *
 *  @return cell model对象
 */
+ (id<MMCellModel>)cellModelWithData:(NSDictionary *)dictionary cellModelClass:(Class)cls;


/**
 *  获取cell model对象数组
 *
 *  @param array JSON数据的数组
 *  @param cls   对应的cell model class
 *
 *  @return cell model对象数组
 */
+ (NSMutableArray *)cellModelsWithArray:(NSArray *)array cellModelClass:(Class)cls;

@end


/**
 *  实现了EMCellModelParser协议
 */
@interface EMParseableObject(CellModel) <EMCellModelParser>


@end
