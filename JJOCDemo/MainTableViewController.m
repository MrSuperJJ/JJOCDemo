//
//  MainTableViewController.m
//  JJDemo
//
//  Created by yejiajun on 16/9/13.
//  Copyright © 2016年 yejiajun. All rights reserved.
//

#import "MainTableViewController.h"
#import "JJMeituanPullRefreshViewController.h"
#import "JJWeChatViewController.h"
#import "JJQQViewController.h"
#import "JJImageBrowserViewController.h"
#import "JJDistrictPickerViewController.h"
#import "JJAnimationImageViewController.h"
#import "DLNADeviceListViewController.h"

static NSString *mainCellIdentifier = @"MainTableViewCell";

@interface MainTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableResultArray;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Main";
    self.tableResultArray = @[@"美团下拉刷新", @"微信浮窗", @"QQ可拉伸头部控件", @"图片浏览器", @"地区选择器", @"UIImageView动画图片", @"DLNA"];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableResultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = _tableResultArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *detailViewController = [[UIViewController alloc] init];
    switch (indexPath.row) {
        case 0:
            detailViewController = [[JJMeituanPullRefreshViewController alloc] init];
            break;
        case 1:
            detailViewController = [[JJWeChatViewController alloc] init];
            break;
        case 2:
            detailViewController = [[JJQQViewController alloc] init];
            break;
        case 3: {
            NSMutableArray *imageArray = [NSMutableArray array];
            for (NSUInteger i = 1; i <= 6; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_0%zd", i]];
                [imageArray addObject:image];
            }
            CGSize imageSize = [imageArray[0] size];
            detailViewController = [[JJImageBrowserViewController alloc] initWithImageArray:imageArray imageSize:imageSize currentIndex:0];
            [self presentViewController:detailViewController animated:YES completion:nil];
            return;
        }
        case 4:
            detailViewController = [[JJDistrictPickerViewController alloc] init];
            break;
        case 5:
            detailViewController = [[JJAnimationImageViewController alloc] init];
            break;
        case 6:
            detailViewController = [[DLNADeviceListViewController alloc] init];
        default:
            break;
    }

    detailViewController.title = _tableResultArray[indexPath.row];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:mainCellIdentifier];
    }
    return _tableView;
}

@end
