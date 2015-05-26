//
//  EMIconTextStatusBar.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMIconTextStatusBar.h"
#import "EMStatusBarIconTextModel.h"
#import "MSCore.h"

@implementation EMIconTextStatusBar

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
        
        _imgvIcon = [[UIImageView alloc] init];
        [self addSubview:_imgvIcon];
    }
    
    return self;
}

- (void)updateStatusBar:(id<EMStatusBarModel>)model
{
    if ([model isKindOfClass:[EMStatusBarIconTextModel class]]) {
        EMStatusBarIconTextModel *data = model;
        
        _titleLabel.text = data.title;
        _imgvIcon.image = [UIImage imageNamed:data.iconName];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = CGRectMake(2, CGRectGetHeight(self.frame)/2-_imgvIcon.image.size.height/2, _imgvIcon.image.size.width, _imgvIcon.image.size.height);
    _imgvIcon.frame = frame;
    
    frame = self.bounds;
    frame.origin.x = CGRectGetMaxX(_imgvIcon.frame) + 2;
    frame.size.width = self.bounds.size.width - frame.origin.x;
    _titleLabel.frame = frame;
}



@end
