//
//  MMVIPTableViewController.m
//  MMTableViewDemo
//
//  Created by Samuel on 15/4/30.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMVIPTableViewController.h"
#import "EMVIPModel.h"
#import "MSCoreMetrics.h"

@interface MMVIPTableViewController ()

@end

@implementation MMVIPTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.tableHeaderView = [self headerView];
    self.enableRefreshFooter = YES;
    self.tableView.footer.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView.header beginRefreshing];
}

- (void)tableViewDidRegisterTableViewCell
{
    // 子类实现
    [self.tableView registerNib:[UINib nibWithNibName:@"EMInfoNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EMInfoNewsCell"];
}

- (void)headerRefreshing
{
    if (_model == nil) {
        _model = [[EMVIPModel alloc] initWithTitle:@"vip资讯" Id:15 URL:@"http://t.emoney.cn/platform/information/vipnews"];
    }
    
    NSString *url = ((EMVIPModel *)_model).dataSource.refreshURL && [((EMVIPModel *)_model).dataSource.refreshURL length]>0 ? ((EMVIPModel *)_model).dataSource.refreshURL : ((EMVIPModel *)_model).URL;
    
    [_model modelWithURL:url block:^(id respondObject, NSURLSessionDataTask *task, BOOL success) {
        if (success && ((EMVIPModel *)_model).dataSource) {
            [self reloadPages:((EMVIPModel *)_model).dataSource];
        }
        
        if ([((EMVIPModel *)_model).dataSource.nextPageURL length]>0) {
            
            if (self.tableView.footer.hidden) {
                self.tableView.footer.hidden = NO;;
            }
        }
        else {
            self.tableView.footer.hidden = YES;
        }
        
        [self.tableView.header endRefreshing];
    }];
    
}

- (void)footerRefreshing
{
    if ([((EMVIPModel *)_model).dataSource.nextPageURL length]>0) {
        [_model modelWithURL:((EMVIPModel *)_model).dataSource.nextPageURL block:^(id respondObject, NSURLSessionDataTask *task, BOOL success) {
            if (success && ((EMVIPModel *)_model).dataSource) {
                [self reloadPages:((EMVIPModel *)_model).dataSource];
            }
            
            if ([((EMVIPModel *)_model).dataSource.nextPageURL length]>0) {
                if (self.tableView.footer.hidden) {
                    self.tableView.footer.hidden = NO;
                }
                [self.tableView.footer endRefreshing];
            }
            else {
                [self.tableView.footer noticeNoMoreData];
            }
        }];
    }
}

- (UIView *)headerView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSScreenWidth(), 30)];
    UILabel *footerLabel = [self footerTipLabel];
    footerLabel.frame = CGRectMake(0, 0, MSScreenWidth()-24, 30);
    [headerView addSubview:footerLabel];
    
    return headerView;
}

- (UILabel *)footerTipLabel
{
    UILabel *label        = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor       = [UIColor redColor];
    label.font            = [UIFont systemFontOfSize:12.0f];
    label.textAlignment   = NSTextAlignmentRight;
    label.frame           = CGRectMake(0, 0, 320, 30);
    label.text            = @"以上选股结果为盘中更新";
    return label;
}

@end
