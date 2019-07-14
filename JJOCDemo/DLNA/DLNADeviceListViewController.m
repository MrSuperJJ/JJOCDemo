//
//  DLNADeviceListViewController.m
//  JJOCDemo
//
//  Created by Mr.JJ on 2019/7/14.
//  Copyright © 2019 叶佳骏. All rights reserved.
//

#import "DLNADeviceListViewController.h"
#import "DLNASourceViewController.h"
#import "MRDLNA.h"

static NSString *MainCellIdentifier = @"MainTableViewCell";

@interface DLNADeviceListViewController () <UITableViewDelegate, UITableViewDataSource, DLNADelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MRDLNA  *dlnaManager;      ///< DLNA工具类
@property (nonatomic, copy) NSArray *deviceArray;        ///< DLNA设备列表
@property (nonatomic, assign) NSInteger maxTriedNumber;

@end

@implementation DLNADeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.dlnaManager startSearch];
}

- (void)dealloc {
    [MRDLNA destory];
}

#pragma mark - DLNADelegate
- (void)searchDLNAResult:(NSArray *)devicesArray {
    self.deviceArray = devicesArray;
}

- (void)dlnaDidEndSearch {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellIdentifier forIndexPath:indexPath];
    CLUPnPDevice *device = self.deviceArray[indexPath.row];
    cell.textLabel.text = device.friendlyName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.dlnaManager.device = self.deviceArray[indexPath.row];
    DLNASourceViewController *dlnaSourceViewController = [[DLNASourceViewController alloc] init];
    [self.navigationController pushViewController:dlnaSourceViewController animated:YES];
}

#pragma mark getters and setters
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MainCellIdentifier];
    }
    return _tableView;
}

- (MRDLNA *)dlnaManager {
    if (nil == _dlnaManager) {
        _dlnaManager = [MRDLNA sharedMRDLNAManager];
        _dlnaManager.delegate = self;
    }
    return _dlnaManager;
}

- (NSArray *)deviceArray {
    if (nil == _deviceArray) {
        _deviceArray = [NSArray array];
    }
    return _deviceArray;
}

@end
