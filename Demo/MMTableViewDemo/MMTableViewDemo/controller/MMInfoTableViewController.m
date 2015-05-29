//
//  MMVIPTableViewController.m
//  MMTableViewDemo
//
//  Created by Samuel on 15/4/30.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MMInfoTableViewController.h"
#import "MMInfoModel.h"

@implementation MMInfoTableViewController


- (void)tableViewDidRegisterTableViewCell
{
    // 子类实现
    [self.tableView registerNib:[UINib nibWithNibName:@"MMInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MMInfoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMInfoCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MMInfoCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMInfoCell3" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MMInfoCell3"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self requestDataSource];
}

- (void)requestDataSource
{
    if (_model == nil) {
        MMInfoModel *model = [[[self theInfoModelClass] alloc] init];
        model.delegate = self;
        _model = model;
    }
    
    NSString *url = @"http://mt.emoney.cn/2pt/zx/GetBShareNews";
    [_model POST:url param:nil block:^(id respondObject, NSURLSessionDataTask *task, BOOL success) {
        if (success && ((MMInfoModel *)_model).dataSource) {
            [self reloadPages:((MMInfoModel *)_model).dataSource];
        }
    }];
    
    
    [self performSelector:@selector(requestDataSource) withObject:nil afterDelay:6.f];
}

- (void)MMInfoCellDoPressBuy:(MMInfoCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    MMInfoModel *model = (MMInfoModel *)_model;
    MMInfoCellModel *cm = [model.dataSource itemAtIndexPath:indexPath];
    
    NSLog(@"买入 title = %@", cm.title);
}

- (void)MMInfoCellDoPressSell:(MMInfoCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    MMInfoModel *model = (MMInfoModel *)_model;
    MMInfoCellModel *cm = [model.dataSource itemAtIndexPath:indexPath];
    
    NSLog(@"卖出 title = %@", cm.title);
}

- (Class)theInfoModelClass
{
    return _infoModelClass ? _infoModelClass : [MMInfoModel class];
}
@end
