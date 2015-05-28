//
//  MSSegmentCellFactory+Theme.h
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSSegmentCellFactory.h"
#import "MSThemeProtocol.h"
#import "MSTextSegmentCell.h"

@interface MSThemeSegmentCellFactory : MSSegmentCellFactory

+ (UIView<MSSegmentCell> *)segmentCellForSegmentControl:(MSSegmentedControl *)segmentControl
                                                atIndex:(int)index
                                             withObject:(NSObject<MSSegmentCellObject> *)object;

@end
