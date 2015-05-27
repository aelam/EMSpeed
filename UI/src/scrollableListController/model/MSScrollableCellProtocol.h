//
//  MSScrollableCellProtocol.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *const MSScrollableListCellSelectedNotification;
extern NSString *const MSScrollableListCellHighlightedNotification;


@protocol MSScrollableCellProtocol <NSObject>

@property (nonatomic, assign) BOOL isTitleTableViewCell; //
@property (nonatomic, strong) NSIndexPath *indexPath;

@required
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@end

/*
 
 - (void)setSelected:(BOOL)selected animated:(BOOL)animated
 {
 if(self.selected == selected)
 return;
 [super setSelected:selected animated:animated];
 [[NSNotificationCenter defaultCenter] postNotificationName:EMScrollableListCellSelectedNotification object:self];
 }
 
 - (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
 {
 if(self.highlighted == highlighted)
 return;
 [super setHighlighted:highlighted animated:animated];
 [[NSNotificationCenter defaultCenter] postNotificationName:EMScrollableListCellHighlightedNotification object:self];
 }
 
 */