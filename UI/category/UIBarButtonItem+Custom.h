//
//  UIBarButtonItem+EM.h
//  EMStock
//
//  Created by xoHome on 14-11-4.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    自定义导航条按钮
 */
@interface MSBarButtonItem : UIBarButtonItem

/**
 *  创建自定义的导航条按钮
 *
 *  @param image  图片
 *  @param tintColor 颜色
 *  @param style  按钮风格
 *  @param target 事件对象
 *  @param action 事件方法
 *
 *  @return 导航条按钮
 */

- (instancetype)initWithImage:(UIImage *)image
                    tintColor:(UIColor *)tintColor
                        style:(UIBarButtonItemStyle)style
                       target:(id)target
                       action:(SEL)action;


/**
 *  创建自定义的导航条按钮
 *
 *  @param title  标题
 *  @param tintColor 颜色
 *  @param style  按钮风格
 *  @param target 事件对象
 *  @param action 事件方法
 *
 *  @return 导航条按钮
 */

- (instancetype)initWithTitle:(NSString *)title
                    tintColor:(UIColor *)tintColor
                        style:(UIBarButtonItemStyle)style
                       target:(id)target
                       action:(SEL)action;

@end


@interface UIBarButtonItem(Custom)

/**
 *  右侧两个图片按钮
 *
 *  @param image1  图片1
 *  @param target1 事件对象1
 *  @param action1 事件方法1
 *  @param image2  图片2
 *  @param target2 事件对象2
 *  @param action2 事件方法2
 *
 *  @return 右侧两个图片按钮
 */
+ (NSArray *)ms_rightItemsWithImage1:(UIImage *)image1 target1:(id)target1 action1:(SEL)action1
                           image2:(UIImage *)image2 target2:(id)target2 action2:(SEL)action2;


@end

