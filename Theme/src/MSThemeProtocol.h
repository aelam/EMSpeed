//
//  EMThemeUpdateProtocol.h
//  UI
//
//  Created by Samuel on 15/4/13.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSThemeManager.h"

/**
 *  场景切换字符串常量, 注册通知时用
 */
extern NSString * const RNThemeManagerDidChangeThemes;


/**
 *  场景更新的
 */
@protocol MSThemeProtocol <NSObject>

@required


/**
 *  注册场景变化通知
 */
- (void)registerThemeChangeNotificaiton;


/**
 *  场景切换通知
 *
 *  @param notification 通知
 */
- (void)themeDidChangeNotification:(NSNotification *)notification;


/**
 *  场景更新, 颜色变化
 */
- (void)applyTheme;

@end




// 只要实现MSThemeProtocol, 并复制下面代码即可 (init相关方法注意一下, 不用的可以删除)

/*
 
 - (void)applyTheme{
 
 }
 
 - (void)registerThemeChangeNotificaiton {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
 }
 
 - (instancetype)init {
    if (self = [super init]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
 }
 
 - (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
 }
 
 - (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self registerThemeChangeNotificaiton];
        [self applyTheme];
    }
    return self;
 }
 
 - (void)awakeFromNib {
    [super awakeFromNib];
    [self applyTheme];
 }
 
 - (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
 }
 
 - (void)dealloc {
 
    [[NSNotificationCenter defaultCenter] removeObserver:self];
 }
 
 */
