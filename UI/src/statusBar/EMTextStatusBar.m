//
//  EMStatusBarLabel.m
//  UI
//
//  Created by Samuel on 15/4/9.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMTextStatusBar.h"
#import "EMStatusBarTextModel.h"
#import "EMCore.h"

@interface EMTextStatusBar() {
}

@end

@implementation EMTextStatusBar

- (instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, EMScreenWidth(), EMStatusBarHeight());
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        _titleLabel = label;
    }
    
    return self;
}

- (void)updateStatusBar:(id<EMStatusBarModel>)model
{
    if ([model isKindOfClass:[EMStatusBarTextModel class]]) {
        EMStatusBarTextModel *data = (EMStatusBarTextModel *)model;
        _titleLabel.text = data.title;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
