//
//  JJQQViewController.m
//  JJOCDemo
//
//  Created by Mr.JJ on 2018/12/2.
//  Copyright © 2018 叶佳骏. All rights reserved.
//

#import "JJQQViewController.h"
#import "JJQQCustomNavBar.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define HeaderHeight 160.f

@interface JJQQViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) JJQQCustomNavBar *navBar;

@property (nonatomic, assign) CGRect bgOriginalFrame;
@property (nonatomic, assign) CGFloat ratio;


@end

@implementation JJQQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];

    ///背景图片
    self.ratio = 0.8f;
    self.bgOriginalFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * self.ratio);
    self.bgView = [[UIImageView alloc] initWithFrame:self.bgOriginalFrame];
    self.bgView.image = [UIImage imageNamed:@"qq_bg"];
    [self.view addSubview:self.bgView];


    ///导航栏
    self.navBar = [[JJQQCustomNavBar alloc] init];
    self.navBar.title = @"标题";
    self.navBar.leftText = @"返回";
    self.navBar.rightText = @"确定";
    [self.view addSubview:self.navBar];

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HeaderHeight)];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;

    [self.view addSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < HeaderHeight) {   ///当滑动到导航栏底部之前
        CGFloat colorAlpha = offsetY / HeaderHeight;
        self.navBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:colorAlpha];
    } else {   ///超过导航栏底部
        self.navBar.backgroundColor = [UIColor greenColor];
    }

    ///处理往上移动效果、处理放大效果
    if (offsetY > 0) {   ///往上移动
        self.bgView.frame = ({
            CGRect frame = self.bgOriginalFrame;
            frame.origin.y = self.bgOriginalFrame.origin.y - offsetY;
            frame;
        });
    } else {   ///往下移动
        self.bgView.frame = ({
            CGRect frame = self.bgOriginalFrame;
            frame.size.height = self.bgOriginalFrame.size.height - offsetY;
            frame.size.width = self.bgOriginalFrame.size.height / self.ratio;
            frame.origin.x = self.bgOriginalFrame.origin.x - (frame.size.width - self.bgOriginalFrame.size.width) / 2;
            frame;
        });
    }
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellReuseIdentifier"];
    }
    return _tableView;
}

@end
