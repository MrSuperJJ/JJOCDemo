//
//  JJMeituanPullRefreshViewController.m
//  JJOCDemo
//
//  Created by 叶佳骏 on 2018/11/29.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "JJMeituanPullRefreshViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "JJMeituanRefreshHeader.h"

@interface JJMeituanPullRefreshViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JJMeituanPullRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellReuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = @"11111";
    return cell;
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellReuseIdentifier"];
        _tableView.mj_header = [JJMeituanRefreshHeader headerWithRefreshingBlock:^{
            NSLog(@"11111");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView.mj_header endRefreshing];
            });
        }];
    }
    return _tableView;
}

@end
