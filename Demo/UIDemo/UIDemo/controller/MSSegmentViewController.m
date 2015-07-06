//
//  MSSegmentViewController.m
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSSegmentViewController.h"
#import "MSSegmentedControl.h"
#import "MSThemeSegmentedControl.h"
#import "MSImageSegmentedCell.h"
#import "MSContext.h"
#import "MSSrollSegmentedControl.h"
#import "MSThemeSrollSegmentedControl.h"

@implementation MSSegmentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSegment1];
    [self createSegment2];
    [self createSegment3];
    [self createSegment4];
}

- (void)createSegment1
{
    MSThemeSegmentedControl *segment1 = [[MSThemeSegmentedControl alloc] initWithItems:@[@"标题1", @"标题2", @"标题3", @"标题4", @"标题5"]];
    segment1.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    segment1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [segment1 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    segment1.selectedSegmentIndex = 0;
    segment1.didNeedsSeperateLine = NO;
    segment1.selectedIndicatorStyle = MSselectedIndicatorStyleMenuTitle;
    [self.view addSubview:segment1];
}

- (void)createSegment2
{
    MSThemeSegmentedControl *segment2 = [[MSThemeSegmentedControl alloc] initWithItems:@[@"标题1", @"标题2", @"标题3", @"标题4"]];
    segment2.frame = CGRectMake(0, 40, self.view.frame.size.width, 30);
    segment2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [segment2 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    segment2.selectedSegmentIndex = 0;
    segment2.selectedIndicatorStyle = MSselectedIndicatorStyleMenuContent;
    [segment2 setIndicatorBackgroundColor:self.view.backgroundColor];
    [self.view addSubview:segment2];
}

- (void)createSegment3
{
    MSImageSegmentedCellObject *obj1 = [MSImageSegmentedCellObject objectWithTitle:@"无图片" image:nil];
    MSImageSegmentedCellObject *obj2 = [MSImageSegmentedCellObject objectWithTitle:@"有图片" image:[UIImage imageNamed:MSUIResName(@"szfx.png")]];
    MSThemeSegmentedControl *segment3 = [[MSThemeSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:obj1,obj2,nil]];
    segment3.didNeedsSeperateLine = YES;
    [segment3 setIndicatorBackgroundColor:[UIColor clearColor]];
    segment3.selectedIndicatorStyle = MSselectedIndicatorStyleMenuContent;
    segment3.selectedSegmentIndex = 0;
    segment3.frame = CGRectMake(0, 80, self.view.frame.size.width, 30);
    [segment3 setIndicatorBackgroundColor:self.view.backgroundColor];
    [segment3 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:segment3];
}

- (void)createSegment4
{
    MSThemeSrollSegmentedControl *segment4 = [[MSThemeSrollSegmentedControl alloc] initWithItems:@[@"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6", @"标题7", @"标题8"]];
    segment4.didNeedsSeperateLine = YES;
    [segment4 setIndicatorBackgroundColor:[UIColor clearColor]];
    segment4.selectedIndicatorStyle = MSselectedIndicatorStyleMenuContent;
    segment4.selectedSegmentIndex = 0;
    segment4.frame = CGRectMake(0, 120, self.view.frame.size.width, 30);
    [segment4 setIndicatorBackgroundColor:self.view.backgroundColor];
    [segment4 addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventTouchUpInside];
    segment4.pageMaxCount = 4;
    [self.view addSubview:segment4];
}


- (void)valueChanged:(MSSegmentedControl *)control
{
    NSLog(@"index = %ld", control.selectedSegmentIndex);
}

@end
