//
//  ZHNNestedPageTableViewCell.h
//  ZHNNestedTableViewController
//
//  Created by zhn on 2019/12/20.
//  Copyright © 2019 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZHNNestedPageTableViewCellDelegate
- (void)ZHNNestedPageDidScrollViewScrollToCenter:(UIScrollView *)scrollView;
@end

@interface ZHNNestedPageTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *contentScrollViews;
- (CGFloat)pageControlHeight;

@property (nonatomic, weak) id <ZHNNestedPageTableViewCellDelegate> delegate;
@property (nonatomic, strong, readonly) UIScrollView *currentScrollView;
@end

NS_ASSUME_NONNULL_END
