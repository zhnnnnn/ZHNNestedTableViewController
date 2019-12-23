//
//  DemoTestTableViewCell.m
//  ZHNNestedTableViewController
//
//  Created by zhn on 2019/12/23.
//  Copyright © 2019 zhn. All rights reserved.
//

#import "DemoTestTableViewCell.h"
#import "Masonry.h"

@interface DemoTestTableViewCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UILabel *pageLabel;
@property (nonatomic, strong) UIScrollView *pageScrollView;
@property (nonatomic, assign) CGFloat count;
@end

@implementation DemoTestTableViewCell
- (instancetype)init {
    if (self = [super init]) {
        self.count = 40;
        [self addSubview:self.pageLabel];
        [self.pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        [self addSubview:self.pageScrollView];
        [self.pageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.pageLabel.mas_bottom);
        }];
        
        [self setupTableViews];
        self.pageScrollView.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width * 10, 0);
    }
    return self;
}

- (void)setupTableViews {
    for (int index = 0; index < 10; index++) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.scrollEnabled = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.pageScrollView addSubview:tableView];
        CGFloat width = UIScreen.mainScreen.bounds.size.width;
        CGFloat vHeight = UIScreen.mainScreen.bounds.size.height;
        tableView.frame = CGRectMake(width * index, 0, width, vHeight - 40);
        [self.contentScrollViews addObject:tableView];
        
        NSInteger aRedValue = arc4random()%255;
        NSInteger aGreenValue = arc4random()%255;
        NSInteger aBlueValue = arc4random()%255;
        UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
        tableView.backgroundColor = randColor;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.count = 50;
    [(UITableView *)self.currentScrollView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = UIColor.clearColor;
    cell.textLabel.text = [NSString stringWithFormat:@"2 -- %ld",indexPath.row];
    return cell;
}


/// 下面的三个方法需要针对特定的需求处理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.delegate ZHNNestedPageDidScrollViewScrollToCenter:self.currentScrollView];
}

- (CGFloat)pageControlHeight {
    return 40;
}

- (UIScrollView *)currentScrollView {
    NSInteger index = self.pageScrollView.contentOffset.x / self.frame.size.width;
    return [self.contentScrollViews objectAtIndex:index];
}

#pragma mark - getters
- (UILabel *)pageLabel {
    if (_pageLabel == nil) {
        _pageLabel = [[UILabel alloc] init];
        _pageLabel.text = @"滚动切换";
        _pageLabel.backgroundColor = UIColor.lightGrayColor;
        _pageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _pageLabel;
}
    
- (UIScrollView *)pageScrollView {
    if (_pageScrollView == nil) {
        _pageScrollView = [[UIScrollView alloc] init];
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.delegate = self;
        _pageScrollView.showsHorizontalScrollIndicator = NO;
        _pageScrollView.bounces = NO;
    }
    return _pageScrollView;
}

@end
