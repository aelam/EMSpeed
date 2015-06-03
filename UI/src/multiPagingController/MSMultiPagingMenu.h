//
//  InfoMenu.h
//  ScrollView2010Demo
//
//  Created by chenmeiosis on 13-6-17.
//  Copyright (c) 2013年 Fugu Mobile Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#define MULTI_PAGING_MENU_BAR_HEIGHT        (35)
#define MULTI_PAGING_MENU_EDIT_WIDTH        (57)
#define MULTI_PAGING_MENU_SPACE             (20)
#define MULTI_PAGING_MENU_SELECTED_H        (36)

extern const CGFloat kMultiPagingMenuBarHeight;
extern const CGFloat kMultiPagingMenuEdithButtonWidth;
extern const CGFloat kMultiPagingMenuSpace;
extern const CGFloat kMultiPagingMenuSelectTwoWordWidth;
extern const CGFloat kMultiPagingMenuSelectFourWordWidth;
extern const CGFloat kMultiPagingMenuSelectFiveWordWidth;
extern const CGFloat kMultiPagingMenuSelectHeight;


@protocol EMMultiPagingMenuDelegate;
@class EMMultiPagingSelectBgView;

// 资讯滚动菜单
// 左边滚动菜单+右边编辑按钮

@interface MSMultiPagingMenu : UIView {
    UIScrollView *_svMenu;
    UIButton *_btnEdit;
    
    UIImageView *_selectedBg;
    NSUInteger _selectedIndex;
    NSMutableArray *_titles;
    NSMutableArray *_btns;
    
    UIColor *_selectedColor;
    UIColor *_unselectedColor;
    
    id<EMMultiPagingMenuDelegate> __unsafe_unretained _delegate;
}
@property (nonatomic, assign) id<EMMultiPagingMenuDelegate> delegate;
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;
@property (nonatomic, strong)　UIColor *selectedColor;
@property (nonatomic, strong)　UIColor *unselectedColor;



- (instancetype)initWithFrame:(CGRect)frame
             titles:(NSArray *)titles
           editable:(BOOL)editable;

- (BOOL)commitEditWithTitles:(NSMutableArray *)titles; // 确认编辑，更新界面
- (void)setCurrentMenuIndex:(int)index
                   animated:(BOOL)animated;
- (NSString *)titleAtIndex:(NSUInteger)index;
- (void)pressMenu:(id)sender;

@end


@protocol EMMultiPagingMenuDelegate <NSObject>
@required
- (void)EMMultiPagingMenuDidPressed:(MSMultiPagingMenu *)infoMenu
                          atIndex:(NSUInteger)index;
@optional
- (void)EMMultiPagingMenuDidPressedEdit:(MSMultiPagingMenu *)infoMenu;

@end



@interface EMMultiPagingSelectBgView : UIView

@end