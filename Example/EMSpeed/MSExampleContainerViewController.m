//
//  MSExampleContainerView.m
//  EMSpeed
//
//  Created by flora on 16/3/23.
//  Copyright © 2016年 Ryan Wang. All rights reserved.
//

#import "MSExampleContainerViewController.h"
#import <EMSpeed/MSContainerView.h>

@implementation MSExampleContainerViewController

- (void)viewDidLoad
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    //设置新闻控制器
    NSArray *titles = [NSArray arrayWithObjects:@"con1",@"con2",@"con3",@"con4",@"controller5", nil];
    NSMutableArray *vcs = [NSMutableArray array];
    
    for (NSString *title in titles) {
        
        UIViewController *newVC = [[UIViewController alloc] init];
        newVC.title = title;
        [vcs addObject:newVC];
        [self addChildViewController:newVC];
    }
    //
    //    WSContainerController *containVC = [WSContainerController containerControllerWithSubControlers:vcs parentController:self];
    //    containVC.navigationBarBackgrourdColor = [UIColor whiteColor];
    
    MSContainerView *containView = [[MSContainerView alloc] initWithViewControllers:vcs];
    containView.navigationView.selectedTextColor = [UIColor colorWithRed:70/255.0f green:144/255.0f blue:239/255.0f alpha:1];
    containView.navigationView.backgroundColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1];
//    [_menu setSelectedColor:[UIColor colorWithRed:70/255.0f green:144/255.0f blue:239/255.0f alpha:1]];
    [containView navigationToIndex:4];
    containView.frame = self.view.bounds;
    [self.view addSubview:containView];
    containView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
}
@end
