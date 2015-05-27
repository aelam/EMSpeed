//
//  EMMultiPagingBaseController+EMMultiPagingSubclass.h
//  EMStock
//
//  Created by Mac mini 2012 on 14-4-3.
//
//

#import "MSMultiPagingBaseController.h"

@interface MSMultiPagingBaseController (ForSubclassEyesOnly)

- (void)createMenu;
- (void)createScrollView;
- (void)createPages;
- (void)clearOldSubViews;
- (void)layoutVisiblePages;
- (void)deceleratingScrollView:(UIScrollView *)scrollView
                      animated:(BOOL)animated
                   sendPackage:(BOOL)canSendPackage;
- (void)tilePages;

- (CGRect)frameForPageAtIndex:(NSUInteger)index;
- (void)recycleUnDisplayedControllers;
- (void)addDisplayedControllers;

@end
