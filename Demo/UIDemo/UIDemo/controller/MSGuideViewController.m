//
//  MSGuideViewController.m
//  UIDemo
//
//  Created by Samuel on 15/4/28.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSGuideViewController.h"
#import "MSMutableDataSource.h"
#import "MSMenuItem.h"
#import "MSMenuTableViewCell.h"
#import "MSThemeManager.h"
#import "MSGuideScrollView.h"
#import "MSGuideScrollLaunchCell.h"
#import "MSSingleGuideView.h"

@implementation MSGuideViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
    }
    
    return self;
}

- (NSArray *)titles
{
    NSArray *titles = @[@"开机引导", @"单点功能引导"];
    return titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = [self titles];
    NSMutableArray *items = [NSMutableArray array];
    for (int i=0; i<[titles count]; i++) {
        MSMenuItem *item = [[MSMenuItem alloc] init];
        item.title = [titles objectAtIndex:i];
        [items addObject:item];
    }
    
    MSMutableDataSource *ds = [[MSMutableDataSource alloc] initWithItems:@[items] sections:@[@""]];
    [self reloadPages:ds];
    
    self.tableView.backgroundColor = [UIColor darkGrayColor];
}



- (void)tableViewDidRegisterTableViewCell
{
    [self.tableView registerNib:[UINib nibWithNibName:@"MSMenuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MSMenuTableViewCell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self showGuideScrollView];
    }
    else if (indexPath.row == 1){
        [self showSingleGuideView];
    }
}


- (void)showGuideScrollView
{
    NSMutableArray *items = [NSMutableArray array];
    
    for (int i=0; i<3; i++) {
        MSGuideScrollLaunchItem *item = [[MSGuideScrollLaunchItem alloc] init];
        item.image = [UIImage imageNamed:@"11.jpg"];
        item.contentMode = UIViewContentModeScaleAspectFill;
        [items addObject:item];
    }
    
    [MSGuideScrollView showGuideScrollViewWithItems:items
                                             InView:self.view
                                           fromRect:[[UIScreen mainScreen] bounds]
                                   autoDismissDelay:3.f
                                         completion:^(void){
                                             
                                         }];
}

- (void)showSingleGuideView
{
    NSMutableArray *array = [NSMutableArray array];
    
    UIImage *image = [UIImage imageNamed:@"liangzhifangda"];
    EMSingleGuideItem *item = [[EMSingleGuideItem alloc] init];
    item.image = image;
    item.point = CGPointMake(.3 * (self.view.frame.size.width - image.size.width), .3 *self.view.frame.size.height);
    [array addObject:item];
    
    image = [UIImage imageNamed:@"liangzhifangda"];
    item = [[EMSingleGuideItem alloc] init];
    item.image = image;
    item.point = CGPointMake(.5 * (self.view.frame.size.width - image.size.width), .7 *self.view.frame.size.height);
    [array addObject:item];
    
    MSSingleGuideView *guidView = [MSSingleGuideView showSingleGuidViewWithitems:array inView:self.view dismissAutomatically:YES completion:^{
        
    }];
    guidView.backgroundColor = [UIColor colorWithWhite:0 alpha:.6f];
    
}

@end
