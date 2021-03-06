//
//  MSViewController.m
//  EMSpeed
//
//  Created by Ryan Wang on 10/22/2015.
//  Copyright (c) 2015 Ryan Wang. All rights reserved.
//

#import "MSViewController.h"
#import <EMSpeed/MSContext.h>
#import "MSExampleContainerViewController.h"
#import "MSExampleContainerViewController2.h"

#import "MSNetworkJSONViewController.h"

@interface MMSViewController ()
{
    NSArray *_titles;
}
@end

@implementation MMSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    _titles = [NSArray arrayWithObjects:@"ContainerView",@"MSExampleContainerViewController2",@"JSON 数据请求",nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableviewcell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcell"];
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        MSExampleContainerViewController *controller = [[MSExampleContainerViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 1)
    {
        MSExampleContainerViewController2 *controller = [[MSExampleContainerViewController2 alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 2)
    {
        
        MSNetworkJSONViewController *controller = [[MSNetworkJSONViewController alloc] initWithNibName:@"MSNetworkJSONViewController" bundle:nil];

        [self.navigationController pushViewController:controller animated:YES];

    }

}


@end
