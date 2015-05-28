//
//  MSMultiPagingViewViewController.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSMultiPagingViewViewController.h"
#import "MSMultiPagingView.h"
#import "MSPageItem.h"

@interface MSMultiPagingViewViewController ()

@end

@implementation MSMultiPagingViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    MSMultiPagingView *pageView = [[MSMultiPagingView alloc] initWithFrame:CGRectMake(0, 0, MSScreenWidth(), 120)];
    
    MSPageItem *data = [[MSPageItem alloc] init];
    data.img = @"http://static.emoney.cn/www/news_market/news_img/201504/952d1319-3617-4ce6-b9cd-8ff72ca07de1_t.png";
    data.url = @"http://www.baidu.com";
    
    MSPageItem *data1 = [[MSPageItem alloc] init];
    data1.img = @"http://static.emoney.cn/www/news_market/news_img/201504/952d1319-3617-4ce6-b9cd-8ff72ca07de1_t.png";
    data1.url = @"http://www.baidu.com";
    
    MSPageItem *data2 = [[MSPageItem alloc] init];
    data2.img = @"http://static.emoney.cn/www/news_market/news_img/201504/952d1319-3617-4ce6-b9cd-8ff72ca07de1_t.png";
    data2.url = @"http://www.baidu.com";
    
    pageView.pageItems = [NSArray arrayWithObjects:data, data1, data2, nil];
    
    [self.view addSubview:pageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
