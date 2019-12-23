//
//  ZHNNestedPageViewController.h
//  ZHNNestedTableViewController
//
//  Created by zhn on 2019/12/23.
//  Copyright © 2019 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHNNestedPageTableViewCell;
NS_ASSUME_NONNULL_BEGIN

@interface ZHNNestedPageViewController : UIViewController
- (NSInteger)ZHNNestedPageNumOfRowsInMainTableView:(UITableView *)tableView;
- (CGFloat)ZHNNestedPageMainTableView:(UITableView *)tableView heightForRow:(NSInteger)row;
- (UITableViewCell *)ZHNNestedPageMainTableView:(UITableView *)tableView cellforRow:(NSInteger)row;
- (ZHNNestedPageTableViewCell *)createPageCell;
@end

NS_ASSUME_NONNULL_END
