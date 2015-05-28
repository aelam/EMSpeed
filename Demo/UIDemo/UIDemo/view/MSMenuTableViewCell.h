//
//  EMButtonTableViewCell.h
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCellUpdating.h"
#import "MSThemeProtocol.h"

@interface MSMenuTableViewCell : UITableViewCell <MSCellUpdating>
@property (weak, nonatomic) IBOutlet UILabel *buttonTitleLabel;

@end
