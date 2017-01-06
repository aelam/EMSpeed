//
//  UIView+Layout.m
//  IStock2
//  布局一组等宽高的子view
//  Created by songbo on 15/10/30.
//  Copyright © 2015年 emoney. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "UIView+Layout.h"

@implementation UIView (Layout)

#pragma mark 在父view布局一组等宽高的子view

+ (void)makeEqualWidthViews:(NSArray<UIView *> *)views inView:(UIView *)containerView margin:(CGFloat)margin padding:(CGFloat)padding
{
    UIView * lastView;
    for (UIView * view in views) {
        [containerView addSubview:view];
        if (lastView)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView.mas_top).offset(margin);
                make.bottom.equalTo(containerView.mas_bottom).offset(-margin);
                make.left.equalTo(lastView.mas_right).offset(padding);
                make.width.equalTo(containerView.mas_width);
            }];
        } else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView.mas_top).offset(margin);
                make.left.equalTo(containerView.mas_left).offset(margin);
            }];
        }
        lastView = view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView.mas_right).offset(-margin);
    }];
    
}

#pragma mark  在父view布局一组等宽高的子view1

+ (void)makeEqualWidthViews:(NSArray<UIView *> *)views inView:(UIView *)containerView TBMargin:(CGFloat)tMargin  LRMargin:(CGFloat)lMargin padding:(CGFloat)padding
{
    UIView * lastView;
    for (UIView * view in views) {
        [containerView addSubview:view];
        if (lastView)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView).offset(tMargin);
                make.bottom.equalTo(containerView).offset(-tMargin);
                make.left.equalTo(lastView.mas_right).offset(padding);
                make.width.equalTo(lastView);
            }];
        }else{
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView.mas_top).offset(tMargin);
                make.bottom.equalTo(containerView.mas_bottom).offset(-tMargin);
                make.left.equalTo(containerView.mas_left).offset(lMargin);
            }];
        }
        lastView = view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView.mas_right).offset(-lMargin);
    }];
    
}

#pragma mark   在父view布局一组等宽高的子view2

+ (void)makeEqualWidthViews:(NSArray<UIView *> *)views inView:(UIView *)containerView topMargin:(CGFloat)tMargin  bottomMargin:(CGFloat)bMargin LRMargin:(CGFloat)lMargin padding:(CGFloat)padding
{
    UIView * lastView;
    for (UIView * view in views) {
        [containerView addSubview:view];
        if (lastView)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(containerView.mas_top).offset(tMargin);
                make.bottom.equalTo(containerView.mas_bottom).offset(-bMargin);
                make.left.equalTo(lastView.mas_right).offset(padding);
                make.width.equalTo(lastView.mas_width);
            }];
        }else{
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(containerView.mas_top).offset(tMargin);
                make.bottom.equalTo(containerView.mas_bottom).offset(-bMargin);
                make.left.equalTo(containerView.mas_left).offset(lMargin);
            }];
        }
        lastView = view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView.mas_right).offset(-lMargin);
    }];
    
}

#pragma mark   在父view布局一组等宽高的子view2

+ (void)makeEqualWidthViews:(NSArray<UIView *> *)views inView:(UIView *)containerView edgeInsets:(UIEdgeInsets)edgeInsets padding:(CGFloat)padding
{
    UIView * lastView;
    
    for (UIView * view in views) {
        [containerView addSubview:view];
        if (lastView)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(containerView.mas_top).offset(edgeInsets.top);
                make.bottom.equalTo(containerView.mas_bottom).offset(-edgeInsets.bottom);
                make.left.equalTo(lastView.mas_right).offset(padding);
                make.width.equalTo(lastView.mas_width);
            }];
        }else{
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(containerView.mas_top).offset(edgeInsets.top);
                make.bottom.equalTo(containerView.mas_bottom).offset(-edgeInsets.bottom);
                make.left.equalTo(containerView.mas_left).offset(edgeInsets.left);
            }];
        }
        lastView = view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView).offset(-edgeInsets.right);
    }];
}

#pragma mark   在父view布局一组等宽高的子view2
+ (void)makeEqualWidthViews:(NSArray<UIView *> *)views inView:(UIView *)containerView edgeInsets:(UIEdgeInsets)edgeInsets padding:(CGFloat)padding lines:(NSUInteger)lines columns:(NSUInteger)columns
{
    NSMutableArray *viewsArray = [NSMutableArray arrayWithArray:views];
    if (lines == 0 || lines == 1)
    {
        [self makeEqualWidthViews:views inView:containerView edgeInsets:edgeInsets padding:padding];
        return;
    }
    NSAssert((views.count >= lines * columns), @"UIView + Layout: value of (lines *columns) must bigger than value of (views.count)");
    
    UIView *lastView;
    CGFloat heightMulti = 1.0/lines;
    CGFloat widthMulti = 1.0/columns;
    CGFloat heightOffset = edgeInsets.top + (-edgeInsets.bottom)+ (lines - 1) * padding;
    CGFloat widthOffset = edgeInsets.left + (-edgeInsets.right) + (columns - 1) * padding;
    for (NSUInteger i = 0; i < lines;i++)
    {
        NSUInteger loc = i * columns;
        NSArray<UIView *> *lineViews = [viewsArray subarrayWithRange:NSMakeRange(loc,columns)];
        
        for (UIView * view in lineViews)
        {
            [containerView addSubview:view];
            NSUInteger j = [lineViews indexOfObject:view];
            if (i == 0)
            {
                if (lastView)
                {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(lastView);
                        make.height.equalTo(lastView.mas_height);
                        make.left.equalTo(lastView.mas_right).offset(padding);
                        make.width.equalTo(lastView.mas_width);
                    }];
                }else
                {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(containerView.mas_top).offset(edgeInsets.top);
                        make.height.equalTo(containerView.mas_height).offset(heightOffset).multipliedBy(heightMulti);
                        make.left.equalTo(containerView.mas_left).offset(edgeInsets.left);
                        make.width.equalTo(containerView.mas_width).offset(widthOffset).multipliedBy(widthMulti);
                    }];
                }

            } else
            {
                if (j == 0)
                {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(lastView.mas_bottom).offset(padding);
                        make.height.equalTo(lastView.mas_height);
                        make.left.equalTo(containerView.mas_left).offset(edgeInsets.left);
                        make.width.equalTo(lastView.mas_width);
                    }];
                }else
                {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(lastView.mas_top);
                        make.height.equalTo(lastView.mas_height);
                        make.left.equalTo(lastView.mas_right).offset(padding);
                        make.width.equalTo(lastView.mas_width);
                    }];
                }
            }
            lastView = view;
        }
    }
}
@end
