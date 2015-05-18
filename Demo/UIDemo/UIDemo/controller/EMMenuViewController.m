//
//  ViewController.m
//  UI
//
//  Created by Samuel on 15/3/26.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMMenuViewController.h"
#import "EMArrowButtonController.h"
#import "EMBorderView.h"
#import "MMMutableDataSource.h"
#import "EMMenuItem.h"
#import "EMMenuTableViewCell.h"
#import "EMThemeManager.h"

@interface EMMenuViewController ()

@end

@implementation EMMenuViewController

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
    NSArray *titles = @[@"EMArrowButton 带箭头的按钮", @"EMLinkedButton 下划线跳转按钮", @"EMRoundButton 圆角按钮", @"EMBorderView 带有边框的视图", @"EMRadioControl 单选控制器", @"EMCheckBoxControl 多选控制器", @"EMMultiPagingView 页翻", @"EMStatusBarWindow 状态栏", @"UICollectionView 翻页", @"EMSegmentControl 选项卡", @"EMGuideViewController 引导", @"EMScrollableListViewController 列表", @"EMRefreshScrollableListViewController 列表"];
    return titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = [self titles];
    NSMutableArray *items = [NSMutableArray array];
    for (int i=0; i<[titles count]; i++) {
        EMMenuItem *item = [[EMMenuItem alloc] init];
        item.title = [titles objectAtIndex:i];
        [items addObject:item];
    }
    
    MMMutableDataSource *ds = [[MMMutableDataSource alloc] initWithItems:@[items] sections:@[@""]];
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
    if ([EMThemeManager themeType] == EMAPPThemeTypeLight) {
        [[EMThemeManager sharedManager] changeTheme:EMAPPThemeBlackName];
    }
    else if ([EMThemeManager themeType] == EMAPPThemeTypeBlack) {
        [[EMThemeManager sharedManager] changeTheme:EMAPPThemeLightName];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableViewDidRegisterTableViewCell
{
    [self.tableView registerNib:[UINib nibWithNibName:@"EMMenuTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EMMenuTableViewCell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = @"";
    
    NSArray *controllerClassNames = @[@"EMArrowButtonController",
                                      @"EMLinkedButtonController",
                                      @"EMRoundButtonViewController",
                                      @"EMBorderViewViewController",
                                      @"EMRadioControlViewController",
                                      @"EMCheckBoxControlViewController",
                                      @"EMMultiPagingViewViewController",
                                      @"EMStatusBarWindowViewController",
                                      @"EMCollectionPagingViewController",
                                      @"EMSegmentViewController",
                                      @"EMGuideViewController",
                                      @"EMScrollableListViewController",
                                      @"EMRefreshScrollableListViewController",
                                      ];
    className = [controllerClassNames objectAtIndex:indexPath.row];
    UIViewController *vc = (UIViewController *)[[NSClassFromString(className) alloc] init];
    vc.title = [[self titles] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)applyTheme
{
    if ([EMThemeManager themeType] == EMAPPThemeTypeLight) {
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorColor = [UIColor darkGrayColor];
    }
    else if ([EMThemeManager themeType] == EMAPPThemeTypeBlack) {
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
