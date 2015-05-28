//
//  MMVIPTableController.h
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSRefreshTableController.h"

@class EMVIPModel;

@interface MMVIPTableController : MSRefreshTableController {
    EMVIPModel *_model;
}

@end
