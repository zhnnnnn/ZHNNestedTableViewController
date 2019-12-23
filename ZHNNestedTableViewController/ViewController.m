//
//  ViewController.m
//  ZHNNestedTableViewController
//
//  Created by zhn on 2019/12/20.
//  Copyright © 2019 zhn. All rights reserved.
//

#import "ViewController.h"
#import "DemoTestTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)ZHNNestedPageMainTableView:(UITableView *)tableView cellforRow:(NSInteger)row {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"main -- %ld",row];
    return cell;
}

- (CGFloat)ZHNNestedPageMainTableView:(UITableView *)tableView heightForRow:(NSInteger)row {
    return 100;
}

- (NSInteger)ZHNNestedPageNumOfRowsInMainTableView:(UITableView *)tableView {
    return 4;
}

- (ZHNNestedPageTableViewCell *)createPageCell {
    return [[DemoTestTableViewCell alloc] init];
}
@end
