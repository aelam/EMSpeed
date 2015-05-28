//
//  MMInfoCell2.h
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-26.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCellModel.h"
#import "MSCellUpdating.h"


@interface MMInfoCell2 : UITableViewCell<MSCellUpdating>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end


@interface MMInfoCellModel2 : NSObject<MSCellModel>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dateString;

@end
