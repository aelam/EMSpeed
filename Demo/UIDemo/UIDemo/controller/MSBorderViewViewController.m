//
//  MSBorderViewViewController.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSBorderViewViewController.h"
#import "MSBorderView.h"
#import "MSThemeBorderView.h"

@interface MSBorderViewViewController ()

@end

@implementation MSBorderViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MSThemeBorderView *border1 = [[MSThemeBorderView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    border1.border = MSBorderStyleLeft;
//    border1.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.f];
//    border1.borderColor = [UIColor redColor];
    [self.view addSubview:border1];
    
    MSThemeBorderView *border2 = [[MSThemeBorderView alloc] initWithFrame:CGRectMake(150, 10, 100, 100)];
    border2.border = MSBorderStyleRight;
//    border2.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.f];
//    border2.borderColor = [UIColor redColor];
    [self.view addSubview:border2];
    
    MSThemeBorderView *border3 = [[MSThemeBorderView alloc] initWithFrame:CGRectMake(10, 130, 100, 100)];
    border3.border = MSBorderStyleTop;
    [self.view addSubview:border3];
    
    MSThemeBorderView *border4 = [[MSThemeBorderView alloc] initWithFrame:CGRectMake(150, 130, 100, 100)];
    border4.border = MSBorderStyleBottom;
    [self.view addSubview:border4];
    
    MSThemeBorderView *border5 = [[MSThemeBorderView alloc] initWithFrame:CGRectMake(10, 250, 100, 100)];
    border5.border = MSBorderStyleAll;
    [self.view addSubview:border5];
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
