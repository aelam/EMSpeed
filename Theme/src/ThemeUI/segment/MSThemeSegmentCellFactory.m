//
//  MSSegmentCellFactory+Theme.m
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSThemeSegmentCellFactory.h"
#import "MSThemeTextSegmentCell.h"

@implementation MSThemeSegmentCellFactory


+ (UIView<MSSegmentCell> *)segmentCellForSegmentControl:(MSSegmentedControl *)segmentControl
                                                atIndex:(int)index
                                             withObject:(NSObject<MSSegmentCellObject> *)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        MSThemeTextSegmentCell *label = [[MSThemeTextSegmentCell alloc] initWithSegmentObject:object];
        
        return label;
    }
    else
    {
        return [[[object cellClass] alloc] initWithSegmentObject:object];
    }
}

@end

