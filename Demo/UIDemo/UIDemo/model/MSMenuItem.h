//
//  EMButtonItem.h
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCellModel.h"

@interface MSMenuItem : NSObject <MSCellModel>

@property (nonatomic, strong) NSString *title;

@end
