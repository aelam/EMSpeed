//
//  MMVIPTableController.m
//  MMTableViewDemo
//
//  Created by Mac mini 2012 on 15-2-28.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMVIPTableController.h"
#import "EMVIPModel.h"

@interface MMVIPTableController ()

@end

@implementation MMVIPTableController

- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIView *footerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    UILabel *footerLabel = [self footerTipLabel];
    footerLabel.frame = CGRectMake(0, 0, self.view.frame.size.width-24, 30);
    [footerBGView addSubview:footerLabel];
    self.tableView.tableHeaderView = footerBGView;
    
    self.enableRefreshFooter = YES;
    self.tableView.footer.hidden = YES;
    
    _model = [[EMVIPModel alloc] initWithTitle:@"vip资讯" Id:15 URL:@"http://t.emoney.cn/platform/information/vipnews"];
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

- (void)reloadDatasource
{
    EMVIPModel *model = (EMVIPModel *)_model;
    NSString *url = model.URL;
    
    [_model modelWithURL:url block:^(id respondObject, AFHTTPRequestOperation *operation, BOOL success) {
        if (success) {
            [self reloadPages:model.dataSource];
        }
        
        if (![model.dataSource.nextPageURL length]>0) {
            self.tableView.footer.hidden = YES;
        }
        else {
            if (self.tableView.footer.hidden) {
                self.tableView.footer.hidden = NO;;
            }
        }
        
        [self.tableView.header endRefreshing];
    }];
}

- (void)refreshDataSource
{
    EMVIPModel *model = (EMVIPModel *)_model;
    NSString *url = model.dataSource.refreshURL;
    
    [_model modelWithURL:url block:^(id respondObject, AFHTTPRequestOperation *operation, BOOL success) {
        if (success && model.dataSource) {
            [self reloadPages:model.dataSource];
        }
        
        if (![model.dataSource.nextPageURL length]>0) {
            self.tableView.footer.hidden = YES;
        }
        else {
            if (self.tableView.footer.hidden) {
                self.tableView.footer.hidden = NO;;
            }
        }
        
        [self.tableView.header endRefreshing];
    }];
}

- (void)requestMoreDataSource
{
    EMVIPModel *model = (EMVIPModel *)_model;
    
    if ([model.dataSource.nextPageURL length]>0) {
        [model modelWithURL:model.dataSource.nextPageURL block:^(id respondObject, AFHTTPRequestOperation *operation, BOOL success) {
            if (success && model.dataSource) {
                [self reloadPages:model.dataSource];
            }
            
            if ([model.dataSource.nextPageURL length]>0) {
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
    else {
        [self.tableView.footer noticeNoMoreData];
    }
}

- (BOOL)isReload
{
    EMVIPModel *model = (EMVIPModel *)_model;
    return [model.dataSource.refreshURL length] == 0;
}

- (void)headerRefreshing
{
    if ([self isReload]) {
        [self reloadDatasource];
    }
    else {
        [self refreshDataSource];
    }
}

- (void)footerRefreshing
{
    [self requestMoreDataSource];
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
