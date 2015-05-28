//
//  MSCheckBoxControlViewController.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSCheckBoxControlViewController.h"
#import "MSThemeCheckBoxControl.h"

@interface MSCheckBoxControlViewController ()

@end

@implementation MSCheckBoxControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MSThemeCheckBoxControl *cb = [[MSThemeCheckBoxControl alloc] initWithTitle:@"环保部曾发文建议撤销古雷PX规划批复 公函莫名消失引国有银行高管离职潮 跳槽率超基层 越共中央总书记阮富仲今起访华江西彭泽企业日排污3000吨 与民居仅隔条马路四川武胜县遭遇13级大风 已致7人死亡" checkBoxTitles:@[@"已致7人死亡", @"与民居仅隔条马路四川武胜县遭遇13级大风", @"333", @"000吨"]];
    cb.frame = CGRectMake(0, 10, MSScreenWidth(), 100);
    //    c.spacing = 10;
    cb.lineHeight = 24;
    cb.countPerRow = 4;
    cb.radioGroupEdgeInsets = UIEdgeInsetsMake(4, 10, 0, 0);
    
    [cb setCheckBox:YES atIndex:1];
    [cb setCheckBox:YES atIndex:0];
    [self.view addSubview:cb];

    
    MSThemeCheckBoxControl *c1 = [[MSThemeCheckBoxControl alloc] initWithTitle:@"2. 上面那个是没有标题的, 这个是有标题的" checkBoxTitles:@[@"已致7人死亡", @"与民居仅隔条马路四川武胜县遭遇13级大风", @"333", @"000吨"]];
    c1.frame = CGRectMake(0, 150, MSScreenWidth(), 100);
    c1.spacing = 10;
    c1.lineHeight = 24;
    c1.countPerRow = 1;
    c1.radioGroupEdgeInsets = UIEdgeInsetsMake(8, 10, 0, 0);
    [self.view addSubview:c1];
    
    
    MSThemeCheckBoxControl *c2 = [[MSThemeCheckBoxControl alloc] initWithTitle:@"3. 每行可以自定义放几个按钮" checkBoxTitles:@[@"已致7人死亡", @"与民居仅隔条马路四川武胜县遭遇13级大风", @"333", @"000吨"]];
    c2.frame = CGRectMake(0, 310, MSScreenWidth(), 100);
    c2.spacing = 10;
    c2.lineHeight = 20;
    c2.countPerRow = 3;
    [c2 setCheckBox:YES atIndex:0];
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
