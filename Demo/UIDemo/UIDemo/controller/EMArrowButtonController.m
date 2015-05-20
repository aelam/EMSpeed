//
//  EMArrowButtonDemoController.m
//  UI
//
//  Created by Samuel on 15/4/1.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "EMArrowButtonController.h"
#import "EMArrowButton.h"
#import "MJRefreshConst.h"
#import "EMRadioControl.h"
#import "EMCheckBoxControl.h"
#import "EMMultiPagingView.h"
#import "EMPageModel.h"
#import "EMPageUpdating.h"
#import "EMMultiPagingView.h"
#import "EMPageItem.h"
#import "EMPageImageView.h"
#import "EMStatusBarWindow.h"
#import "EMStatusBarTextModel.h"
#import "EMStatusBarIconTextModel.h"
#import "EMActivityIndicatorTextModel.h"
#import "EMThemeArrowButton.h"

@interface EMArrowButtonController ()

@end

@implementation EMArrowButtonController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadBtn0];
    [self loadBtn1];
    [self loadBtn2];
    [self loadBtn3];
    [self loadBtn4];
    [self loadBtn5];
    [self loadBtn6];
}

- (void)loadBtn0
{
    EMThemeArrowButton *btn0 = [[EMThemeArrowButton alloc] initWithFrame:CGRectMake(10, 30, 80, 20)];
    [btn0 setTitle:@"0000" forState:UIControlStateNormal];
//    [btn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn0.layer.borderColor = [UIColor blueColor].CGColor;
    btn0.layer.borderWidth = 1.f;
    [self.view addSubview:btn0];
}

- (void)loadBtn1
{
    EMThemeArrowButton *btn1 = [[EMThemeArrowButton alloc] initWithFrame:CGRectMake(10, 60, 80, 20)];
    btn1.arrowPos = EMArrowButtonPositionLeft;
    btn1.arrowColor = [UIColor redColor];
    btn1.arrowHighlightedColor = [UIColor greenColor];
    [btn1 setTitle:@"1111" forState:UIControlStateNormal];
//    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.layer.borderColor = [UIColor blueColor].CGColor;
    btn1.layer.borderWidth = 1.f;
    [self.view addSubview:btn1];
}

- (void)loadBtn2
{
    EMThemeArrowButton *btn2 = [[EMThemeArrowButton alloc] initWithFrame:CGRectMake(10, 90, 80, 40)];
    btn2.arrowPos = EMArrowButtonPositionDown;
    btn2.arrowShadowColor = [UIColor redColor];
    [btn2 setTitle:@"2222" forState:UIControlStateNormal];
//    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.layer.borderColor = [UIColor blueColor].CGColor;
    btn2.layer.borderWidth = 1.f;
    [self.view addSubview:btn2];
}

- (void)loadBtn3
{
    EMThemeArrowButton *btn3 = [[EMThemeArrowButton alloc] initWithFrame:CGRectMake(10, 140, 80, 30)];
    btn3.arrowPos = EMArrowButtonPositionLeft;
    btn3.arrowSize = CGSizeMake(12, 12);
    [btn3 setTitle:@"3333" forState:UIControlStateNormal];
//    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.layer.borderColor = [UIColor blueColor].CGColor;
    btn3.layer.borderWidth = 1.f;
    [self.view addSubview:btn3];
}

- (void)loadBtn4
{
    EMThemeArrowButton *btn4 = [[EMThemeArrowButton alloc] initWithFrame:CGRectMake(10, 180, 80, 30)];
    btn4.arrowPos = EMArrowButtonPositionLeft;
    btn4.imgArrow = [UIImage imageNamed:MJRefreshSrcName(@"arrow.png")];
    btn4.arrowSize = CGSizeMake(12, 20);
    btn4.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn4 setTitle:@"Theme1" forState:UIControlStateNormal];
//    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn4.layer.borderColor = [UIColor blueColor].CGColor;
    btn4.layer.borderWidth = 1.f;
    [self.view addSubview:btn4];
}

- (void)loadBtn5
{
    EMThemeArrowButton *btn5 = [[EMThemeArrowButton alloc] initWithFrame:CGRectMake(10, 220, 80, 30)];
    btn5.arrowOrigin = CGPointMake(8, 12);
    btn5.arrowPos = EMArrowButtonPositionLeft;
    btn5.arrowColor = [UIColor redColor];
    btn5.arrowHighlightedColor = [UIColor greenColor];
    [btn5 setTitle:@"Theme2" forState:UIControlStateNormal];
    btn5.titleLabel.font = [UIFont systemFontOfSize:12];
//    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn5.layer.borderColor = [UIColor blueColor].CGColor;
    btn5.layer.borderWidth = 1.f;
    [self.view addSubview:btn5];
}

- (void)loadBtn6
{
    EMThemeArrowButton *btn6 = [EMThemeArrowButton buttonWithFrame:CGRectMake(10, 260, 100, 30)
                                                             title:@"股票代码"
                                                         direction:EMArrowDirectionDown];
    btn6.layer.borderColor = [UIColor blueColor].CGColor;
    btn6.layer.borderWidth = 1.f;
    [self.view addSubview:btn6];
}

@end
