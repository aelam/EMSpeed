//
//  EMBorderView.m
//  EMStock
//
//  Created by xoHome on 14-9-30.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMBorderView.h"

#define kDefaultBorderColor RGB(0xe5, 0xe5, 0xe5)

@implementation EMBorderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.borderColor = kDefaultBorderColor;
        self.border = EMBorderStyleAll;
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    self.borderColor = kDefaultBorderColor;
    self.border = EMBorderStyleAll;
}


- (void)drawRect:(CGRect)rect {
    
    if (self.border == EMBorderStyleNone) {
        return;
    }
    
    rect = UIEdgeInsetsInsetRect(rect, self.contentInsets);
    
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (self.border & EMBorderStyleLeft)
    {
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    }
    
    if (self.border & EMBorderStyleRight)
    {
        CGContextMoveToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    }
    
    if (self.border & EMBorderStyleTop)
    {
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    }
    
    if (self.border & EMBorderStyleBottom)
    {
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    }
    
    CGContextSetStrokeColorWithColor(ctx, self.borderColor.CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
}


@end
