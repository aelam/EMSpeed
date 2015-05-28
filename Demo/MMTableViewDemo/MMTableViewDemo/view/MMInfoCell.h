//
//  EMInfoCell.h
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCellModel.h"
#import "MSCellUpdating.h"

@class MMInfoCell;
@protocol MMInfoCellDelegate <NSObject>
- (void)MMInfoCellDoPressBuy:(MMInfoCell *)cell;
- (void)MMInfoCellDoPressSell:(MMInfoCell *)cell;

@end



@interface MMInfoCell : UITableViewCell <MSCellUpdating>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) id<MMInfoCellDelegate> delegate;

- (IBAction)pressButton:(id)sender;

@end



@interface MMInfoCellModel : NSObject <MSCellModel>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dateString;
@property (weak, nonatomic) id<MMInfoCellDelegate> delegate;

@end
