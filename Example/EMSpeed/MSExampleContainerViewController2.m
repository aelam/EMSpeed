//
//  MSExampleContainerViewController2.m
//  EMSpeed
//
//  Created by flora on 16/4/13.
//  Copyright © 2016年 Ryan Wang. All rights reserved.
//

#import "MSExampleContainerViewController2.h"

@implementation MSExampleContainerViewController2

- (id)init
{
    self = [super init];
    if (self) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
        //设置新闻控制器
        NSArray *titles = [NSArray arrayWithObjects:@"con1",@"con2",@"con3",@"con4",@"controller5", nil];
        NSMutableArray *vcs = [NSMutableArray array];
        
        for (NSString *title in titles) {
            
            MSExampleTestViewController2 *newVC = [[MSExampleTestViewController2 alloc] init];
            newVC.title = title;
            [vcs addObject:newVC];
        }
        
        self.viewControllers = vcs;
        self.selectedIndex = 3;
    }
    return self;
}

@end


@implementation MSExampleTestViewController2

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

@end
