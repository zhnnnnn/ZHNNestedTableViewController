//
//  ZHNNestedPageTableViewCell.m
//  ZHNNestedTableViewController
//
//  Created by zhn on 2019/12/20.
//  Copyright © 2019 zhn. All rights reserved.
//

#import "ZHNNestedPageTableViewCell.h"

@implementation ZHNNestedPageTableViewCell
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {}
- (CGFloat)pageControlHeight {return 0;}
- (UIScrollView *)currentScrollView {return nil;}
- (NSMutableArray *)contentScrollViews {
    if (_contentScrollViews == nil) {
        _contentScrollViews = [NSMutableArray array];
    }
    return _contentScrollViews;
}
@end
