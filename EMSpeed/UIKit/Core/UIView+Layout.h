//
//  UIView+Layout.h
//  IStock2
//  布局一组等宽高的子view
//  Created by songbo on 15/10/30.
//  Copyright © 2015年 emoney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

/**
 *   在父view布局一组等宽高的子view(默认1行)
 *
 *  @param views         一组子view
 *  @param containerView 父view
 *  @param margin       上下左右的的Margin（子view 与父view的外边距）
 *  @param padding       子view 与 子view 的内间距
 */
+ (void)makeEqualWidthViews:(NSArray <UIView *>*)views inView:(UIView *)containerView margin:(CGFloat)margin padding:(CGFloat)padding;

/**
 *   在父view布局一组等宽高的子view1(默认1行)
 *
 *  @param views         一组子view
 *  @param containerView 父view
 *  @param tMargin       上下的的Margin（子view 与父view的外边距）
 *  @param lMargin       左右的的Margin（子view 与父view的外边距）
 *  @param padding       子view 与 子view 的内间距
 */
+ (void)makeEqualWidthViews:(NSArray <UIView *>*)views inView:(UIView *)containerView TBMargin:(CGFloat)tMargin  LRMargin:(CGFloat)lMargin padding:(CGFloat)padding;

/**
 *   在父view布局一组等宽高的子view2(默认1行)
 *
 *  @param views         一组子view
 *  @param containerView 父view
 *  @param tMargin       上的的Margin（子view 与父view的外边距）
 *  @param bMargin       下的的Margin（子view 与父view的外边距）
 *  @param lMargin       左右的的Margin（子view 与父view的外边距）
 *  @param padding       子view 与 子view 的内间距
 */
+ (void)makeEqualWidthViews:(NSArray <UIView *>*)views inView:(UIView *)containerView topMargin:(CGFloat)tMargin  bottomMargin:(CGFloat)bMargin LRMargin:(CGFloat)lMargin padding:(CGFloat)padding;



/**
 *   在父view布局一组等宽高的子view3(默认1行)
 *
 *  @param views         一组子view
 *  @param containerView 父view
 *  @param edgeInsets    上下左右的的的Margin
 *  @param padding       子view 与 子view 的内间距
 */

+ (void)makeEqualWidthViews:(NSArray <UIView *>*)views inView:(UIView *)containerView edgeInsets:(UIEdgeInsets)edgeInsets padding:(CGFloat)padding;


/**
  在父view布局一组等宽高的子view4(多行、多列）

 @param views         一组子view
 @param containerView 父view
 @param edgeInsets    上下左右的的的Margin
 @param padding       子view 与 子view 的内间距
 @param lines         多少行
 @param columns       多少列
 */
+ (void)makeEqualWidthViews:(NSArray <UIView *>*)views inView:(UIView *)containerView edgeInsets:(UIEdgeInsets)edgeInsets padding:(CGFloat)padding lines:(NSUInteger)lines columns:(NSUInteger)columns;

/**
  在父view布局一组等宽高的子view5(多行、多列）

 @param views         一组子view
 @param containerView 父view
 @param edgeInsets    上下左右的的的Margin
 @param hPadding      子view 与 子view 的水平内间距
 @param vPadding      子view 与 子view 的垂直内间距
 @param lines         多少行
 @param columns       多少列
 */
+ (void)makeEqualWidthViews:(NSArray <UIView *>*)views inView:(UIView *)containerView edgeInsets:(UIEdgeInsets)edgeInsets hPadding:(CGFloat)hPadding vPadding:(CGFloat)vPadding  lines:(NSUInteger)lines columns:(NSUInteger)columns;
@end
