//
//  MSBaseViewController.m
//  UI
//
//  Created by Samuel on 15/4/10.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSDemoBaseViewController.h"
#import "MSThemeManager.h"

@interface MSDemoBaseViewController ()

@end

@implementation MSDemoBaseViewController

- (void)viewDidLoad {
    //111
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    // Do any additional setup after loading the view.
    
    if ([MSThemeManager themeType] == MSAPPThemeTypeLight) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    else if ([MSThemeManager themeType] == MSAPPThemeTypeBlack) {
        self.view.backgroundColor = [UIColor blackColor];
    }
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
