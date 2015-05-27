//
//  EMTextSegmentCell.h
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSegmentCellFactory.h"

@interface MSTextSegmentCellObject : NSObject <EMSegmentCellObject>

// Designated initializer.
- (instancetype)initWithCellClass:(Class)cellClass;

+ (instancetype)objectWithCellClass:(Class)cellClass;

@end


@interface MSTextSegmentCell : UIView <EMSegmentCell>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *normalTextColor;


- (instancetype)initWithSegmentObject:(NSObject<EMSegmentCellObject> *)object;
- (instancetype)initWithText:(NSString *)object;
@end
