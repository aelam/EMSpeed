//
//  EMSwitchButton.m
//  EMStock
//
//  Created by Samuel on 15/3/19.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "EMArrowButton.h"

#define kDefaultArrowButtonColor    RGB(183, 183, 183)
#define kDefaultArrowButtonSize     CGSizeMake(6, 6)

@implementation EMArrowButton
@synthesize direction = _direction;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _direction = EMArrowDirectionDown;
        _arrowPos = EMArrowButtonPositionRight;
        
        self.arrowColor = [UIColor darkGrayColor];
        self.arrowHighlightedColor = kDefaultArrowButtonColor;
        
        self.arrowShadowColor = [UIColor lightGrayColor];
        self.arrowHighlightedShadowColor = [UIColor blackColor];
    }
    
    return self;
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                      direction:(EMArrowDirection)direction
{
    EMArrowButton *button = [[[self class] alloc] initWithFrame:frame];
    button.direction = direction;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _direction = EMArrowDirectionDown;
    _arrowPos = EMArrowButtonPositionRight;
    
    self.arrowColor = [UIColor darkGrayColor];
    self.arrowHighlightedColor = kDefaultArrowButtonColor;
    
    self.arrowShadowColor = [UIColor lightGrayColor];
    self.arrowHighlightedShadowColor = [UIColor blackColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGPoint origin = [self calcArrowButtonOrigin];
    [self drawArrowAtPoint:origin];
}

- (CGPoint)calcArrowButtonOrigin
{
    
    CGFloat begin_x = 0;
    CGFloat begin_y = 0;
    
    if (self.arrowSize.width <= 0 || self.arrowSize.height <= 0) {
        self.arrowSize = kDefaultArrowButtonSize;
    }
    
    if (self.arrowOrigin.x != 0 || self.arrowOrigin.y != 0) {
        begin_x = self.arrowOrigin.x;
        begin_y = self.arrowOrigin.y;
    }
    else {
        switch (_arrowPos) {
            case EMArrowButtonPositionLeft:
                begin_x = 4;
                begin_y = self.bounds.size.height/2 - self.arrowSize.height/2;
                break;
            case EMArrowButtonPositionRight:
                begin_x = self.bounds.size.width - self.arrowSize.width - 4;
                begin_y = self.bounds.size.height/2 - self.arrowSize.height/2;
                break;
            case EMArrowButtonPositionDown:
                begin_x = .5 * (self.frame.size.width - self.arrowSize.width);
                begin_y = (self.frame.size.height - self.arrowSize.height -3);
                break;
        }
    }
    
    begin_x = ceilf(begin_x);
    begin_y = ceilf(begin_y);
    
    return CGPointMake(begin_x, begin_y);
}

- (void)drawArrowAtPoint:(CGPoint)origin
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.imgArrow) {
        [self.imgArrow drawInRect:CGRectMake(origin.x, origin.y, self.arrowSize.width, self.arrowSize.height)];
    }
    else{
        //绘制一层三角阴影
        if (self.arrowShadowColor || self.arrowHighlightedShadowColor) {
            UIColor *shadowColor = self.arrowShadowColor ? self.arrowShadowColor : self.arrowHighlightedShadowColor;
            UIColor *HighlightedShadowColor = self.arrowHighlightedShadowColor ? self.arrowHighlightedShadowColor : self.arrowShadowColor;
            
            CGDrawFillTrianle(context, _direction, CGRectMake(origin.x, origin.y+1, self.arrowSize.width, self.arrowSize.height), self.highlighted ? HighlightedShadowColor : shadowColor);
        }
        
        CGDrawFillTrianle(context, _direction, CGRectMake(origin.x, origin.y, self.arrowSize.width, self.arrowSize.height),
                          self.highlighted ? self.arrowHighlightedColor : self.arrowColor);
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
    [super cancelTrackingWithEvent:event];
}

@end
