//
//  MSBorderView.m
//  EMStock
//
//  Created by xoHome on 14-9-30.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSBorderView.h"
#import "MSCore.h"

#define kDefaultBorderColor RGB(0xe5, 0xe5, 0xe5)

@implementation MSBorderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.borderColor = kDefaultBorderColor;
        self.border = MSBorderStyleAll;
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    self.borderColor = kDefaultBorderColor;
    self.border = MSBorderStyleAll;
}


- (void)drawRect:(CGRect)rect {
    
    if (self.border == MSBorderStyleNone) {
        return;
    }
    
    rect = UIEdgeInsetsInsetRect(rect, self.contentInsets);
    
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (self.border & MSBorderStyleLeft)
    {
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    }
    
    if (self.border & MSBorderStyleRight)
    {
        CGContextMoveToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    }
    
    if (self.border & MSBorderStyleTop)
    {
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    }
    
    if (self.border & MSBorderStyleBottom)
    {
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    }
    
    CGContextSetStrokeColorWithColor(ctx, self.borderColor.CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
}


@end
