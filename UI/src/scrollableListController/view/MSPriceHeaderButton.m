//
//  EMPriceHeaderButton.m
//  EMStock
//
//  Created by xoHome on 14-10-29.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSPriceHeaderButton.h"

@implementation MSPriceHeaderButton

- (id)init
{
    self = [super init];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
