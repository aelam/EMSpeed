//
//  EMListDemoModel.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSCellModel.h"

@interface MSNameListItem : NSObject <MSCellModel>

@property (nonatomic, assign) int code;
@property (nonatomic, strong) NSString *name;

@end


