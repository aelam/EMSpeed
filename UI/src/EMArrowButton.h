//
//  EMSwitchButton.h
//  EMStock
//
//  Created by Samuel on 15/3/19.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMContext.h"


/**
    箭头按钮位置
 */

typedef NS_ENUM(NSInteger, EMArrowButtonPosition) {
    EMArrowButtonPositionLeft,  // 在文字左侧
    EMArrowButtonPositionRight, // 在文字右侧
    EMArrowButtonPositionDown,  // 在文字下方
    
};


/**
 *  箭头按钮
 */
@interface  EMArrowButton: UIButton
{
    EMArrowDirection _direction;
}


/**
 *  箭头方向
 */
@property (nonatomic, assign) EMArrowDirection direction;


/**
 *  箭头颜色
 */
@property (nonatomic, strong) UIColor *arrowColor;


/**
 *  箭头高亮颜色
 */
@property (nonatomic, strong) UIColor *arrowHighlightedColor;


/**
 *  箭头阴影颜色, 设置了就有阴影了, 默认没的
 */
@property (nonatomic, strong) UIColor *arrowShadowColor;


/**
 *  箭头阴影高亮颜色, 设置了就有阴影了, 默认没的
 */
@property (nonatomic, strong) UIColor *arrowHighlightedShadowColor;


/**
 *  箭头尺寸
 */
@property (nonatomic, assign) CGSize arrowSize;


/**
 *  箭头位置, 左边, 下边, 右边
 */
@property (nonatomic, assign) EMArrowButtonPosition arrowPos;


/**
 *  箭头坐标, 设置这个位置后, 无视arrowPos
 */
@property (nonatomic, assign) CGPoint arrowOrigin;


/**
 *  箭头图片, 如果设置了这图片则arrowColor, arrowHighlightedColor, arrowShadowColor, arrowHighlightedShadowColor自动无效了
 */
@property (nonatomic, strong) UIImage *imgArrow;



/**
 *  通用的按钮
 *
 *  @param frame  尺寸
 *  @param title  标题
 *  @param direct 剪头方向
 *
 *  @return 按钮
 */
+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                      direction:(EMArrowDirection)direct;

@end

