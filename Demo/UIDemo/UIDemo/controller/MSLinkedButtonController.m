//
//  MSLinkedButtonController.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSLinkedButtonController.h"
#import "MSThemeLinkedButton.h"

@interface MSLinkedButtonController ()

@end

@implementation MSLinkedButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    MSThemeLinkedButton *linkedBtn = [MSThemeLinkedButton buttonWithType:UIButtonTypeCustom];
    linkedBtn.frame = CGRectMake(10, 10, 120, 40);
    linkedBtn.url = @"http://www.apple.com";
    linkedBtn.offsetY = 2;
    [linkedBtn setTitle:@"苹果" forState:UIControlStateNormal];
    [self.view addSubview:linkedBtn];
    
    
    MSLinkedButton *linkedBtn1 = [MSLinkedButton buttonWithType:UIButtonTypeCustom];
    linkedBtn1.frame = CGRectMake(150, 10, 120, 40);
    linkedBtn1.url = @"http://www.baidu.com";
    linkedBtn1.offsetY = -2;
    [linkedBtn1 setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [linkedBtn1 setTitle:@"百度地图" forState:UIControlStateNormal];
    [self.view addSubview:linkedBtn1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
