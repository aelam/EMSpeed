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
    _titles = [NSArray arrayWithObject:@"ContainerView"];
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
    MSExampleContainerViewController *controller = [[MSExampleContainerViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
