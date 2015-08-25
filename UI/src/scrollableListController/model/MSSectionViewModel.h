//
//  MSSectionViewModel.h
//  EMStock
//
//  Created by Mac mini 2012 on 15/6/21.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSSectionViewModel <NSObject>


@property (nonatomic, assign) CGFloat height;


@property (nonatomic, strong) Class Class;


@property (nonatomic, strong) NSString *reuseIdentify;


@property (nonatomic, assign) BOOL isRegisterByClass;

@end
