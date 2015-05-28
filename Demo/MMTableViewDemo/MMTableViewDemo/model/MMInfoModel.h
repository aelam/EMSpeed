//
//  MMStockWebModel.h
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-13.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MSHTTPRequestModel.h"
#import "MSMutableDataSource.h"
#import "MMInfoCell.h"

@interface MMInfoModel : MSHTTPRequestModel {
    
    MSMutableDataSource *_dataSource;    
}

@property (nonatomic, strong) MSMutableDataSource *dataSource;
@property (nonatomic, assign) id<MMInfoCellDelegate> delegate;


@end


@interface MMInfoModel2 : MMInfoModel {
    
}

@end


@interface MMInfoModel3 : MMInfoModel {
    
}

@end

