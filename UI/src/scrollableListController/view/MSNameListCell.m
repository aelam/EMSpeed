//
//  EMListCell.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSNameListCell.h"
#import "MSCore.h"

@implementation MSNameListCell
@synthesize isTitleTableViewCell;
@synthesize indexPath;


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.isTitleTableViewCell = YES;
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    bgView.backgroundColor = RGB(0xff, 0xff, 0xff);
    self.backgroundView = bgView;
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.backgroundColor = RGB(0xfa, 0xfa, 0xfa);
    self.selectedBackgroundView = view;
    
}

- (void)update:(id<MSCellModel>)cellModel
     indexPath:(NSIndexPath *)aIndexPath
{
    self.indexPath = aIndexPath;
}

- (void)update:(id<MSCellModel>)cellModel
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(self.selected == selected)
        return;
    [super setSelected:selected animated:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:MSScrollableListCellSelectedNotification object:self];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if(self.highlighted == highlighted)
        return;
    [super setHighlighted:highlighted animated:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:MSScrollableListCellHighlightedNotification object:self];
}

@end
