//
//  ViewController.m
//  UI
//
//  Created by Samuel on 15/3/26.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSMenuViewController.h"
#import "MSArrowButtonController.h"
#import "MSBorderView.h"
#import "MSMutableDataSource.h"
#import "MSMenuItem.h"
#import "MSMenuTableViewCell.h"
#import "MSThemeManager.h"

@interface MSMenuViewController ()

@end

@implementation MSMenuViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
        
        [self registerThemeChangeNotificaiton];
    }
    
    return self;
}

- (NSArray *)titles
{
    NSArray *titles = @[@"MSArrowButton 带箭头的按钮", @"MSLinkedButton 下划线跳转按钮", @"MSRoundButton 圆角按钮", @"MSBorderView 带有边框的视图", @"MSRadioControl 单选控制器", @"MSCheckBoxControl 多选控制器", @"MSMultiPagingView 页翻", @"MSStatusBarWindow 状态栏", @"UICollectionView 翻页", @"MSSegmentControl 选项卡", @"MSGuideViewController 引导", @"MSScrollableListViewController 列表", @"MSRefreshScrollableListViewController 列表"];
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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"theme" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 80, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [btn addTarget:self action:@selector(doChangeTheme) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self applyTheme];
}

- (void)doChangeTheme
{
    if ([MSThemeManager themeType] == MSAPPThemeTypeLight) {
        [[MSThemeManager sharedManager] changeTheme:EMAPPThemeBlackName];
    }
    else if ([MSThemeManager themeType] == MSAPPThemeTypeBlack) {
        [[MSThemeManager sharedManager] changeTheme:EMAPPThemeLightName];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableViewDidRegisterTableViewCell
{
    [self.tableView registerNib:[UINib nibWithNibName:@"MSMenuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MSMenuTableViewCell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = @"";
    
    NSArray *controllerClassNames = @[@"MSArrowButtonController",
                                      @"MSLinkedButtonController",
                                      @"MSRoundButtonViewController",
                                      @"MSBorderViewViewController",
                                      @"MSRadioControlViewController",
                                      @"MSCheckBoxControlViewController",
                                      @"MSMultiPagingViewViewController",
                                      @"MSStatusBarWindowViewController",
                                      @"MSCollectionPagingViewController",
                                      @"MSSegmentViewController",
                                      @"MSGuideViewController",
                                      @"MSScrollableListViewController",
                                      @"MSRefreshScrollableListViewController",
                                      ];
    className = [controllerClassNames objectAtIndex:indexPath.row];
    UIViewController *vc = (UIViewController *)[[NSClassFromString(className) alloc] init];
    vc.title = [[self titles] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)applyTheme
{
    if ([MSThemeManager themeType] == MSAPPThemeTypeLight) {
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorColor = [UIColor darkGrayColor];
    }
    else if ([MSThemeManager themeType] == MSAPPThemeTypeBlack) {
        self.tableView.backgroundColor = [UIColor blackColor];
        self.tableView.separatorColor = [UIColor lightGrayColor];
    }
}

- (void)registerThemeChangeNotificaiton
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self registerThemeChangeNotificaiton];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self applyTheme];
}

- (void)themeDidChangeNotification:(NSNotification *)notification
{
    [self applyTheme];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
