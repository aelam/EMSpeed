//
//  MSNetworkJSONViewController.m
//  EMSpeed
//
//  Created by flora on 16/11/18.
//  Copyright © 2016年 Ryan Wang. All rights reserved.
//

#import "MSNetworkJSONViewController.h"
#import <EMSpeed/MSJSONSessionManager.h>
#import "MSZaoBaoJSONModel.h"

@interface MSNetworkJSONViewController ()
{
    IBOutlet UITextField *_countTextField;
    IBOutlet UILabel *_titleLabel;
    IBOutlet UIButton *_requestButton;
}
@end


#define MSInformationZaoBaoURL @"http://mt.emoney.cn/platform/news/MorningReport"

@implementation MSNetworkJSONViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (IBAction)requestData
{

    [[MSJSONSessionManager sharedManager] JM_GET:MSInformationZaoBaoURL
                                      parameters:nil
                                    headerFields:nil
                                  JSONModelClass:[MSZaoBaoJSONModel class]
                                      completion:^(MSZaoBaoJSONModel *jsonModel, JSONModelError * _Nullable err) {
                                          if (jsonModel.status == 0) {
                                              //数据更新到视图
                                              
                                              _countTextField.text = [NSString stringWithFormat:@"%lu",(unsigned long)[jsonModel.data count]];
                                              _titleLabel.text = ((MSZaoBaoItem *)jsonModel.data.lastObject).title;
                                          }
                                      }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self requestData];
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
