//
//  EMInfoNewsItem.h
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCellModel.h"
#import "MSParseableObject.h"

@interface EMInfoNewsItem : MSParseableObject <MSCellModel>

@property (nonatomic, assign) BOOL isJian;
@property (nonatomic, strong) NSString *jianText;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, assign) BOOL activity;
@property (nonatomic, strong) NSString *sectionTitle; // option for user behavior

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options;

@end
