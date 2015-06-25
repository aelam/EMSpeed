//
//  EMListCell.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-8.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCellUpdating.h"
#import "MSSpreadCellProtocol.h"

@interface MSNameListCell : UITableViewCell <MSCellUpdating, MSSpreadCellProtocol>

@end