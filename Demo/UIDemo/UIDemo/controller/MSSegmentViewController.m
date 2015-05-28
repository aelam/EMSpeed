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
#import "PPiFlatSegmentedControl.h"

@implementation MSSegmentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSegment1];
    [self createSegment2];
    [self createSegment3];
    [self createSegment4];
    [self createSegment5];
    [self createSegment6];
    [self createSegment7];
    [self createSegment8];
    [self createSegment9];
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

- (void)createSegment5
{
    NSArray *items = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"Face" andIcon:@"icon-facebook"],
                       [[PPiFlatSegmentItem alloc] initWithTitle:@"Linkedin" andIcon:@"icon-linkedin"],
                       [[PPiFlatSegmentItem alloc] initWithTitle:@"Twitter" andIcon:@"icon-twitter"]];
    PPiFlatSegmentedControl *segmented5=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 160, 250, 30)
                                                                                 items:items
                                                                          iconPosition:IconPositionRight
                                                                     andSelectionBlock:^(NSUInteger segmentIndex) {}
                                                                        iconSeparation:5];
    segmented5.color=[UIColor colorWithRed:88.0f/255.0 green:88.0f/255.0 blue:88.0f/255.0 alpha:1];
    segmented5.borderWidth=0.5;
    segmented5.borderColor= [UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:147.0f/255.0 alpha:1];
    segmented5.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:147.0f/255.0 alpha:1];
    segmented5.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented5.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                        NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented5];
}

- (void)createSegment6
{
    NSArray *items2 = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"Linkedin" andIcon:@"icon-linkedin"],
                        [[PPiFlatSegmentItem alloc] initWithTitle:@"Twitter" andIcon:@"icon-twitter"]];
    PPiFlatSegmentedControl *segmented6=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 200, 250, 30)
                                                                                 items:items2
                                                                          iconPosition:IconPositionRight
                                                                     andSelectionBlock:^(NSUInteger segmentIndex) { }
                                                                        iconSeparation:5];
    segmented6.color=[UIColor whiteColor];
    segmented6.borderWidth=0.5;
    segmented6.borderColor=[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1];
    segmented6.selectedColor=[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1];
    segmented6.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                NSForegroundColorAttributeName:[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1]};
    segmented6.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                        NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented6];
}

- (void)createSegment7
{
    NSArray *items2 = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"Linkedin" andIcon:@"icon-linkedin"],
                         [[PPiFlatSegmentItem alloc] initWithTitle:@"Twitter" andIcon:@"icon-twitter"]];
    NSArray *items3 = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"Facebook" andIcon:@"icon-facebook"],
                        [[PPiFlatSegmentItem alloc] initWithTitle:@"Twitter" andIcon:@"icon-twitter"],
                        [[PPiFlatSegmentItem alloc] initWithTitle:@"Cloud" andIcon:@"icon-cloud"]];
    PPiFlatSegmentedControl *segmented7=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 240, 250, 30)
                                                                                 items:items3
                                                                          iconPosition:IconPositionRight
                                                                     andSelectionBlock:^(NSUInteger segmentIndex) {}
                                                                        iconSeparation:0];
    segmented7.color=[UIColor colorWithRed:88.0f/255.0 green:88.0f/255.0 blue:88.0f/255.0 alpha:1];
    segmented7.borderWidth=0.5;
    segmented7.borderColor=[UIColor darkGrayColor];
    segmented7.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:176.0f/255.0 alpha:1];
    segmented7.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented7.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                        NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented7];
    [segmented7 setItems:items2];
}

- (void)createSegment8
{
    PPiFlatSegmentedControl *segmented8 = [[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 280, 250, 30)
                                                                                   items:@[[[PPiFlatSegmentItem alloc] initWithTitle:NSLocalizedString(@"Friends", nil) andIcon:nil], [[PPiFlatSegmentItem alloc] initWithTitle:NSLocalizedString(@"Everyone", nil) andIcon:nil], [[PPiFlatSegmentItem alloc] initWithTitle:NSLocalizedString(@"Everyone1", nil) andIcon:nil]]
                                                                            iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                                                                // code here
                                                                            }
                                                                          iconSeparation:0];
    segmented8.layer.cornerRadius = 0;
    segmented8.color=[UIColor colorWithRed:235.0f/255.0 green:179.0f/255.0 blue:125.0f/255.0 alpha:1];
    segmented8.borderWidth=.5;
    segmented8.borderColor=[UIColor whiteColor];
    segmented8.selectedColor=[UIColor colorWithRed:228.0f/255.0 green:153.0f/255.0 blue:81.0f/255.0 alpha:1];
    segmented8.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented8.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                        NSForegroundColorAttributeName:[UIColor whiteColor]};
    //    [segmentControl setSegmentAtIndex:1 enabled:NO];
    [self.view addSubview:segmented8];
}

- (void)createSegment9
{
    NSArray *theItems = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"全部记录" andIcon:nil], [[PPiFlatSegmentItem alloc] initWithTitle:@"物品兑换" andIcon:nil], [[PPiFlatSegmentItem alloc] initWithTitle:@"功能兑换" andIcon:nil]];
    
    
    PPiFlatSegmentedControl *segmented9 = [[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(15, 320, self.view.bounds.size.width - 30, 32) items:theItems iconPosition:IconPositionLeft andSelectionBlock:^(NSUInteger segmentIndex) {
        NSLog(@"segmentIndex = %ld", segmentIndex);
    } iconSeparation:3];
    
    segmented9.color = [UIColor clearColor];
    segmented9.borderWidth = 1;
    segmented9.borderColor = RGB(0x46, 0x90, 0xef);
    segmented9.selectedColor = RGB(0x46, 0x90, 0xef);
    segmented9.textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                  NSForegroundColorAttributeName:RGB(0x46, 0x90, 0xef)};
    segmented9.selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                          NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview: segmented9];
}


- (void)valueChanged:(MSSegmentedControl *)control
{
    NSLog(@"index = %ld", control.selectedSegmentIndex);
}

@end
