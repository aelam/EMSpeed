//
//  MSStatusBarWindowViewController.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSStatusBarWindowViewController.h"
#import "MSStatusBarWindow.h"
#import "MSThemeStatusBarIconTextModel.h"
#import "MSThemeStatusBarTextModel.h"
#import "MSThemeActivityIndicatorTextModel.h"
#import "MSContext.h"

@interface MSStatusBarWindowViewController ()

@end

@implementation MSStatusBarWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(30, 100, 120, 40);
    [btn1 addTarget:self action:@selector(doAnim1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"单条标题" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor redColor];
    btn2.frame = CGRectMake(170, 100, 120, 40);
    [btn2 addTarget:self action:@selector(doAnim2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"图标+标题" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.backgroundColor = [UIColor redColor];
    btn3.frame = CGRectMake(30, 160, 120, 40);
    [btn3 addTarget:self action:@selector(doAnim3) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"多条标题" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.backgroundColor = [UIColor redColor];
    btn4.frame = CGRectMake(170, 160, 120, 40);
    [btn4 addTarget:self action:@selector(doAnim4) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setTitle:@"组合标题" forState:UIControlStateNormal];
    [self.view addSubview:btn4];

}

- (void)doAnim1
{
    MSThemeStatusBarTextModel *bar1 = [[MSThemeStatusBarTextModel alloc] init];
    bar1.title = @"Hello, 我是一个标题";
    [MSStatusBarWindow showStatusBarWithModel:bar1];
}

- (void)doAnim2
{
    MSThemeStatusBarIconTextModel *bar1 = [[MSThemeStatusBarIconTextModel alloc] init];
    bar1.title = @"Hello, 我是一个带有图标的标题";
    bar1.iconName = MSUIResName(@"radio_on.png");
    [MSStatusBarWindow showStatusBarWithModel:bar1];
}

- (void)doAnim3
{
    MSThemeStatusBarTextModel *bar1 = [[MSThemeStatusBarTextModel alloc] init];
    bar1.title = @"尼玛 我是个标题1111111";
    
    MSThemeStatusBarTextModel *bar2 = [[MSThemeStatusBarTextModel alloc] init];
    bar2.title = @"尼玛 我是个标题2222222";
    
    MSThemeStatusBarTextModel *bar3 = [[MSThemeStatusBarTextModel alloc] init];
    bar3.title = @"尼玛 我是个标题3333333";
    
    [MSStatusBarWindow showStatusBarWithArray:@[bar1, bar2, bar3]];
}

- (void)doAnim4
{
    MSThemeStatusBarIconTextModel *bar1 = [[MSThemeStatusBarIconTextModel alloc] init];
    bar1.title = @"尼玛 我是个标题1111";
    bar1.iconName = @"radio_on.png";
    
    MSThemeStatusBarTextModel *bar2 = [[MSThemeStatusBarTextModel alloc] init];
    bar2.title = @"尼玛 我是个标题22222222";
    
    MSThemeStatusBarTextModel *bar3 = [[MSThemeStatusBarTextModel alloc] init];
    bar3.title = @"尼玛 我是个标题3333333";
    
    MSThemeStatusBarTextModel *bar4 = [[MSThemeStatusBarTextModel alloc] init];
    bar4.title = @"尼玛 我是个标题4444444";
    
    MSThemeActivityIndicatorTextModel *bar5 = [[MSThemeActivityIndicatorTextModel alloc] init];
    bar5.title = @"尼玛 我是个标题555555";
    bar5.isActivityIndicatorAnimating = YES;
    
    [MSStatusBarWindow showStatusBarWithArray:@[bar1, bar2, bar3, bar4, bar5]];
}

- (void)dd
{
    [MSStatusBarWindow hiddenStatusBarAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [MSStatusBarWindow hiddenStatusBarAnimated:NO];
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
