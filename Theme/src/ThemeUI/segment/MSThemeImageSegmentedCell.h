//
//  EMThemeImageSegmentedCell.h
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSImageSegmentedCell.h"

@interface MSThemeImageSegmentedCellObject : MSTextSegmentCellObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

+ (instancetype)objectWithTitle:(NSString *)title image:(UIImage *)image;

@end


@interface MSThemeImageSegmentedCell : MSImageSegmentedCell

@end
