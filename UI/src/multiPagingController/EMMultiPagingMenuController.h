//
//  EMMultiPagingMenuController.h
//  EMStock
//
//  Created by Mac mini 2012 on 14-4-21.
//
//

#import "EMMultiPagingBaseController.h"
#import "EMMultiPagingMenu.h"



@interface EMMultiPagingMenuController : EMMultiPagingBaseController <EMMultiPagingMenuDelegate> {
    
    EMMultiPagingMenu   *_menu;                     // 标题栏
    BOOL                _isMenuHidden;              // 是否隐藏标题栏
}
- (void)setMenuHidden:(BOOL)hidden; // 隐藏菜单
- (void)EMMultiPagingMenuDidPressed:(EMMultiPagingMenu *)infoMenu
                            atIndex:(NSUInteger)index;
@end
