//
//  MSRadioControlViewController.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSRadioControlViewController.h"
#import "MSThemeRadioControl.h"

@interface MSRadioControlViewController ()

@end

@implementation MSRadioControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MSThemeRadioControl *c0 = [[MSThemeRadioControl alloc] initWithTitles:@[@"已致7人死亡", @"与民居仅隔条马路四川武胜县遭遇13级大风", @"333", @"000吨"]];
    c0.frame = CGRectMake(0, 10, MSScreenWidth(), 100);
    c0.spacing = 10;
    c0.lineHeight = 24;
    c0.countPerRow = 1;
    c0.radioGroupEdgeInsets = UIEdgeInsetsMake(8, 10, 0, 0);
    [self.view addSubview:c0];
    
    
    MSThemeRadioControl *c1 = [[MSThemeRadioControl alloc] initWithTitle:@"2. 上面那个是没有标题的, 这个是有标题的" radioTitles:@[@"已致7人死亡", @"与民居仅隔条马路四川武胜县遭遇13级大风", @"333", @"000吨"]];
    c1.frame = CGRectMake(0, 150, MSScreenWidth(), 100);
    c1.spacing = 10;
    c1.lineHeight = 24;
    c1.countPerRow = 1;
    c1.radioGroupEdgeInsets = UIEdgeInsetsMake(8, 10, 0, 0);
    [self.view addSubview:c1];
    
    
    MSThemeRadioControl *c2 = [[MSThemeRadioControl alloc] initWithTitle:@"3. 每行可以自定义放几个按钮" radioTitles:@[@"已致7人死亡", @"与民居仅隔条马路四川武胜县遭遇13级大风", @"333", @"000吨"]];
    c2.frame = CGRectMake(0, 310, MSScreenWidth(), 100);
    c2.spacing = 10;
    c2.lineHeight = 24;
    c2.countPerRow = 2;
    c2.radioGroupEdgeInsets = UIEdgeInsetsMake(8, 10, 0, 0);
    [self.view addSubview:c2];
    
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
