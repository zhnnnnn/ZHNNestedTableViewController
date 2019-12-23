//
//  ZHNNestedPageViewController.m
//  ZHNNestedTableViewController
//
//  Created by zhn on 2019/12/23.
//  Copyright © 2019 zhn. All rights reserved.
//

#import "ZHNNestedPageViewController.h"
#import "ZHNNestedPageTableViewCell.h"

@interface ZHNNestedPageViewController ()
<UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
ZHNNestedPageTableViewCellDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIScrollView *virtualScrollView;
@property (nonatomic, strong) UIScrollView *pageCenterScrollView;
@property (nonatomic, strong) ZHNNestedPageTableViewCell *pageCell;
@property (nonatomic, assign) CGFloat pageCellHeight;
@end

@implementation ZHNNestedPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageCellHeight = 1;
    self.pageCell = [self createPageCell];
    self.pageCell.delegate = self;
    
    [self.view addSubview:self.virtualScrollView];
    self.virtualScrollView.frame = self.view.bounds;
    [self.view addSubview:self.mainTableView];
    self.mainTableView.frame = self.view.bounds;
    
    [self.mainTableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    self.pageCenterScrollView = self.pageCell.currentScrollView;
    [self.pageCenterScrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        if (object == self.mainTableView) {
            CGPoint offset = self.virtualScrollView.contentOffset;
            self.virtualScrollView.contentSize = self.mainTableView.contentSize;
            [self.virtualScrollView setContentOffset:offset animated:NO];
        }
        if (object == self.pageCenterScrollView) {
            [self __reloadPageCell];
        }
    }
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self ZHNNestedPageNumOfRowsInMainTableView:tableView];
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self ZHNNestedPageMainTableView:tableView cellforRow:indexPath.row];
    }
    else {
        return self.pageCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self ZHNNestedPageMainTableView:tableView heightForRow:indexPath.row];
    }
    else {
        return self.pageCellHeight;
    }
}

#pragma mark - tableView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.virtualScrollView) {
        CGFloat offsety = scrollView.contentOffset.y;
        if (offsety > [self __scrollPointY]) {
            self.mainTableView.contentOffset = CGPointMake(0, [self __scrollPointY]);
            self.pageCell.currentScrollView.contentOffset = CGPointMake(0, offsety - [self __scrollPointY]);
        }
        else {
            self.mainTableView.contentOffset = self.virtualScrollView.contentOffset;
            self.pageCell.currentScrollView.contentOffset = CGPointZero;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.virtualScrollView) {
        [self __clearPageSectionAllScrollViewContentOffsetStatusExceptCenter];
    }
}

#pragma mark - ZHNNestedPageTableViewCellDelegate
- (void)ZHNNestedPageDidScrollViewScrollToCenter:(UIScrollView *)scrollView {
    if (self.virtualScrollView.contentOffset.y >= [self __scrollPointY]) {
        CGFloat offsety = scrollView.contentOffset.y + [self __scrollPointY];
        self.virtualScrollView.contentOffset = CGPointMake(0, offsety);
    }
    self.pageCenterScrollView = scrollView;
}

#pragma mark - public methods
- (NSInteger)ZHNNestedPageNumOfRowsInMainTableView:(UITableView *)tableView {
    return 0;
}

- (CGFloat)ZHNNestedPageMainTableView:(UITableView *)tableView heightForRow:(NSInteger)row {
    return 0;
}

- (UITableViewCell *)ZHNNestedPageMainTableView:(UITableView *)tableView cellforRow:(NSInteger)row {
    return nil;
}

- (ZHNNestedPageTableViewCell *)createPageCell {
    return nil;
}

#pragma mark - pravite methods
- (void)__reloadPageCell {
    self.pageCellHeight = self.pageCenterScrollView.contentSize.height + [self.pageCell pageControlHeight];
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.mainTableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)__clearPageSectionAllScrollViewContentOffsetStatusExceptCenter {
    for (UIScrollView *scrollView in self.pageCell.contentScrollViews) {
        if (scrollView != self.pageCell.currentScrollView) {
            scrollView.contentOffset = CGPointZero;
        }
    }
}

- (CGFloat)__scrollPointY {
    NSInteger mainRowCount = [self ZHNNestedPageNumOfRowsInMainTableView:self.mainTableView];
    CGFloat mainSectionHeight = 0;
    for (int index = 0; index < mainRowCount; index++) {
        mainSectionHeight += [self ZHNNestedPageMainTableView:self.mainTableView heightForRow:index];
    }
    return mainSectionHeight;
}

#pragma mark - setters
- (void)setPageCenterScrollView:(UIScrollView *)pageCenterScrollView {
    if (pageCenterScrollView == _pageCenterScrollView) {
        return;
    }
    else {
        [_pageCenterScrollView removeObserver:self forKeyPath:@"contentSize"];
        _pageCenterScrollView = pageCenterScrollView;
        [pageCenterScrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        [self __reloadPageCell];
    }
}

#pragma mark - getters
- (UIScrollView *)virtualScrollView {
    if (_virtualScrollView == nil) {
        _virtualScrollView = [[UIScrollView alloc] init];
        _virtualScrollView.delegate = self;
        _virtualScrollView.scrollEnabled = YES;
        [self.view addGestureRecognizer:_virtualScrollView.panGestureRecognizer];
        if (@available(iOS 11.0, *)) {
            [_virtualScrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    }
    return _virtualScrollView;
}

- (UITableView *)mainTableView {
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            [_mainTableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    }
    return _mainTableView;
}
@end
