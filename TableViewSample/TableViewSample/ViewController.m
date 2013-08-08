//
//  ViewController.m
//  TableViewSample
//
//  Created by Masud Shuvo on 7/23/13.
//  Copyright (c) 2013 Wide Space. All rights reserved.
//

#import "ViewController.h"

@interface ViewController() <UITableViewDelegate,UITableViewDataSource>
{
    
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    numberOfTableRow = 100;
    
    array = [[NSMutableArray alloc] init];
    [self setAllElementofArrayToZero];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 320, 400) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
}

- (void)setAllElementofArrayToZero
{
    for(int i = 0;i < numberOfTableRow ;i++)
    {
        [array addObject:[NSNumber numberWithInteger:0]];
    }
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numberOfTableRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (UITableViewCell *) customUITableViewCell:(NSString *)cellIdentifier {
    
    CGRect cellFrame = CGRectMake(0, 0, 320, 65);
    CGRect labelFrame = CGRectMake(60,0,60,30);
    
    UILabel *label;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.frame = cellFrame;
    label = [[UILabel alloc] initWithFrame:labelFrame];
    [label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
    label.tag = 1;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    [cell.contentView addSubview:label];
    return cell;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [self customUITableViewCell:cellIdentifier];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"add" forState:UIControlStateNormal];
        //set the position of the button
        [button setFrame:CGRectMake(0, 0, 50, 30)];
        [button addTarget:self action:@selector(increaseItemCount:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor= [UIColor redColor];
        [cell.contentView addSubview:button];
    }
    UILabel *displayCount = (UILabel *)[cell viewWithTag:1];
    displayCount.text = [NSString stringWithFormat:@"%i",[[array objectAtIndex:indexPath.row] intValue]];
    return cell;
}

-(void)increaseItemCount:(UIButton *)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
    NSIndexPath *path = [table indexPathForCell:cell];
    
    [array replaceObjectAtIndex:path.row withObject:[NSNumber numberWithInteger:[[array objectAtIndex:path.row] intValue]+1 ]];
    
    [table reloadData];
    
}
@end
